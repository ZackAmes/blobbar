use blobbar::models::types::{Direction, TileType, Vec2};
use blobbar::models::blobtender::{Blobtender};

// define the interface
#[dojo::interface]
trait IActions {
    fn spawn();
    fn move(direction: Direction);
}

#[dojo::interface]
trait IActionsComputed {
    fn tile_type(level: u8, vec: Vec2) -> TileType;
}

// dojo decorator
#[dojo::contract]
mod actions {
    use super::{IActions, IActionsComputed};

    use starknet::{ContractAddress, get_caller_address};
    use blobbar::models::{
                        types::{Level, Direction, TileType, DrinkType, Vec2}, 
                        blobtender::{Blobtender, BlobtenderTrait}};

    #[abi(embed_v0)]
    impl ActionsImpl of IActions<ContractState> {
        fn spawn(world: IWorldDispatcher) {
            let player = get_caller_address();
            let blobtender = get!(world, player, (Blobtender));
            let level = blobtender.level;
            assert!(level == Level::None, "already spawned");
            set!(world, (blobtender));
        }

        fn move(world: IWorldDispatcher, direction: Direction) {
            
        }
    }

    #[abi(embed_v0)]
    impl ActionsComputedImpl of IActionsComputed<ContractState> {
        fn tile_type(level: u8, vec: Vec2) -> TileType {
            //for level 1
            match vec.y {
                0 => {
                    match vec.x {
                        0 => TileType::Bar,
                        1 => TileType::Bar,
                        2 => TileType::Bar,
                        3 => TileType::Bar,
                        4 => TileType::Bar,
                        _ => TileType::None
                    }
                },
                1 => {
                    match vec.x {
                        0 => TileType::Trash,
                        1 => TileType::Ground,
                        2 => TileType::Ground,
                        3 => TileType::Ground,
                        4 => TileType::Trash,
                        _ => TileType::None
                    }
                },
                2 => {
                    match vec.x {
                        0 => TileType::Bar,
                        1 => TileType::Ingredient(DrinkType::Grog),
                        2 => TileType::Ingredient(DrinkType::Rum),
                        3 => TileType::Ingredient(DrinkType::Soda),
                        4 => TileType::Bar,
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
