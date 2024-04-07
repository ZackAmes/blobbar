use blobbar::models::types::{Direction, TileType, Vec2, DrinkType};
use blobbar::models::blobtender::{Blobtender};
use blobbar::blobert::types::seeder::Seed;
use starknet::ContractAddress;

// define the interface
#[dojo::interface]
trait IActions {
    fn spawn();
    fn move(direction: Direction);
    fn set_addresses(seeder: ContractAddress, descriptor: ContractAddress);
    fn get_random_blobert() -> ByteArray;
    fn get_client_blobert(index: u8) -> ByteArray;
    fn get_client_order(index: u8) -> DrinkType;
    fn get_queue_size() -> u8;
    fn start_level();
}

#[dojo::interface]
trait IActionsComputed {
    fn tile_type(vec: Vec2) -> TileType;
}

// dojo decorator
#[dojo::contract]
mod actions {
    use super::{IActions, IActionsComputed};

    use starknet::{ContractAddress, get_caller_address, get_block_timestamp};
    use blobbar::models::{
                        types::{Level, Direction, TileType, DrinkType, DrinkTypeTrait, IngredientType, Vec2}, 
                        blobtender::{Blobtender, BlobtenderTrait},
                        addresses::{Addresses}};
    use blobbar::blobert::seeder::{ISeederDispatcher, ISeederDispatcherTrait};
    use blobbar::blobert::descriptor::{IDescriptorDispatcher, IDescriptorDispatcherTrait};
    use blobbar::blobert::types::seeder::Seed;

    const ADDRESS_KEY: u8 = 69;

    #[abi(embed_v0)]
    impl ActionsImpl of IActions<ContractState> {
        fn spawn(world: IWorldDispatcher) {
            let player = get_caller_address();
            let blobtender = get!(world, player, (Blobtender));
            assert!(blobtender.high_score==0 && blobtender.clients_served==0, "already spawned");
            let test_seed = Seed {order: 0, armour: 0, mask: 0, weapon: 0, jewelry: 0};
            let blobtender = BlobtenderTrait::new(player, test_seed, start_time: 0);
            set!(world, (blobtender));
        }

        fn start_level(world: IWorldDispatcher) {
            let player = get_caller_address();
            let mut blobtender = get!(world, player, (Blobtender));
            assert!(blobtender.level != Level::None, "not spawned");
            blobtender.start_time = get_block_timestamp();
            blobtender.level_up();
            set!(world, (blobtender));
        }

        fn set_addresses(world: IWorldDispatcher, seeder: ContractAddress, descriptor: ContractAddress) {
            let mut addresses = get!(world, ADDRESS_KEY, (Addresses));
            assert!(!addresses.set, "already set");
            addresses = Addresses { key: ADDRESS_KEY, seeder, descriptor, set: true};
            set!(world, (addresses));

        }

        fn get_random_blobert(world: IWorldDispatcher) -> ByteArray {
            let addresses = get!(world, ADDRESS_KEY, (Addresses));
            let Seeder = ISeederDispatcher {contract_address: addresses.seeder};
            let Descriptor = IDescriptorDispatcher {contract_address: addresses.descriptor};
            let salt:felt252 = get_caller_address().into();
            let seed: Seed = Seeder.generate_seed(addresses.descriptor,Level::One, get_block_timestamp(),1, salt);
            Descriptor.svg_image(seed)
        }

        fn move(world: IWorldDispatcher, direction: Direction) {
            let player = get_caller_address();
            let mut blobtender = get!(world, player, (Blobtender));
            assert!(blobtender.level != Level::None, "not spawned");
            let mut next_pos: Vec2 = blobtender.position;
            match direction {
                Direction::None => {
                    
                },
                Direction::Left => {
                    next_pos.x -= 1;
                },
                Direction::Right => {
                    next_pos.x += 1;
                },
                Direction::Up => {
                    next_pos.y += 1;
                },
                Direction::Down => {
                    next_pos.y -= 1;
                },
            }
            let next_tile = self.tile_type(next_pos);
            match next_tile {
                TileType::None => {
                    panic!("how???")
                },
                TileType::Ground => {
                    blobtender.position = next_pos;
                },
                TileType::Trash => {
                    blobtender.serving = DrinkType::None;
                },
                TileType::Bar => {
                    //TODO: serve
                },
                TileType::Ingredient(ingedient_type) => {
                    blobtender.serving = blobtender.serving.combine(ingedient_type);
                }
            }
            set!(world, (blobtender));

        }

        fn get_client_blobert(world: IWorldDispatcher, index: u8) -> ByteArray{
            let player = get_caller_address();
            let blobtender = get!(world, player, (Blobtender));
            assert!(blobtender.start_time !=0, "level not started");
            assert!(index <= self.get_queue_size(), "index larger than queue size");
            let addresses = get!(world, ADDRESS_KEY, (Addresses));
            let Seeder = ISeederDispatcher {contract_address: addresses.seeder };
            let Descriptor = IDescriptorDispatcher {contract_address: addresses.seeder};
            let seed = Seeder.generate_seed(addresses.descriptor, blobtender.level, blobtender.start_time, index, player.into());
            Descriptor.svg_image(seed)
        }

        fn get_client_order(world: IWorldDispatcher, index: u8) -> DrinkType {
            let player = get_caller_address();
            let blobtender = get!(world, player, (Blobtender));
            assert!(blobtender.start_time !=0, "level not started");
            assert!(index <= self.get_queue_size(), "index larger than queue size");
            let addresses = get!(world, ADDRESS_KEY, (Addresses));
            let Seeder = ISeederDispatcher {contract_address: addresses.seeder };
            let seed = Seeder.generate_seed(addresses.descriptor, blobtender.level, blobtender.start_time, index, player.into());
            let res:DrinkType = seed.order.into();
            res
            
        }

        fn get_queue_size(world: IWorldDispatcher) -> u8{
            let player = get_caller_address();
            let blobtender = get!(world, player, (Blobtender));
            assert!(blobtender.start_time != 0, "level not started");
            let time_stamp = get_block_timestamp();
            let queue_size: u64 = time_stamp - blobtender.start_time / 30;
            let res: u8 = queue_size.try_into().unwrap();
            res + 2
        }
    }
    #[abi(embed_v0)]
    impl ActionsComputedImpl of IActionsComputed<ContractState> {
        #[computed(Vec2)]
        fn tile_type(vec: Vec2) -> TileType {
            //for level 1
            match vec.y {
                0 => {
                    match vec.x {
                        0 => TileType::Bar,
                        1 => TileType::Bar,
                        2 => TileType::Bar,
                        3 => TileType::Bar,
                        4 => TileType::Bar,
                        5=> TileType::Bar,
                        _ => TileType::None
                    }
                },
                1 => {
                    match vec.x {
                        0 => TileType::Trash,
                        1 => TileType::Ground,
                        2 => TileType::Ground,
                        3 => TileType::Ground,
                        4 => TileType::Ground,
                        5 => TileType::Trash,
                        _ => TileType::None
                    }
                },
                2 => {
                    match vec.x {
                        0 => TileType::Bar,
                        1 => TileType::Ingredient(IngredientType::Grog),
                        2 => TileType::Ingredient(IngredientType::Mead),
                        3 => TileType::Ingredient(IngredientType::Soda),
                        4 => TileType::Ingredient(IngredientType::Juice),
                        5 => TileType::Bar,
                        _ => TileType::None
                    }
                },
                _ => {
                    TileType::None
                }
            }
        }

    }

    
}

fn next_state(mut blobtender: Blobtender, direction: Direction) -> Blobtender {
    match direction {
        Direction::None => { return blobtender; },
        Direction::Left => { blobtender.position.x -= 1; },
        Direction::Right => { blobtender.position.x += 1; },
        Direction::Up => { blobtender.position.y -= 1; },
        Direction::Down => { blobtender.position.y += 1; },
    };
    blobtender
}
