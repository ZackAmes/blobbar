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
    fn tile_type(vec: Vec2) -> TileType;
}

// dojo decorator
#[dojo::contract]
mod actions {
    use super::{IActions, IActionsComputed};

    use starknet::{ContractAddress, get_caller_address};
    use blobbar::models::{
                        types::{Level, Direction, TileType, DrinkType, DrinkTypeTrait, IngredientType, Vec2}, 
                        blobtender::{Blobtender, BlobtenderTrait}};

    #[abi(embed_v0)]
    impl ActionsImpl of IActions<ContractState> {
        fn spawn(world: IWorldDispatcher) {
            let player = get_caller_address();
            let blobtender = get!(world, player, (Blobtender));
            let level = blobtender.level;
            assert!(level == Level::None, "already spawned");
            let blobtender = BlobtenderTrait::new(player);
            set!(world, (blobtender));
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
