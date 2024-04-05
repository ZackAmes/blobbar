use blobbar::models::types::{Direction, TileType};
use blobbar::models::position::{Position, Vec2};


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
    use super::{IActions, IActionsComputed, next_position};

    use starknet::{ContractAddress, get_caller_address};
    use blobbar::models::{position::{Position, Vec2}, types::{Level, Direction, TileType}, blobtender::{Blobtender}};

    #[abi(embed_v0)]
    impl ActionsImpl of IActions<ContractState> {
        fn spawn(world: IWorldDispatcher) {
            let player = get_caller_address();
            let btender = get!(world, player, (Blobtender));
            
        }

        fn move(world: IWorldDispatcher, direction: Direction) {
        
        }
    }

    #[abi(embed_v0)]
    impl ActionsComputedImpl of IActionsComputed<ContractState> {
        fn tile_type(level: u8, vec: Vec2) -> TileType {
            TileType::None
        }
    }

    
}

fn next_position(mut position: Position, direction: Direction) -> Position {
    match direction {
        Direction::None => { return position; },
        Direction::Left => { position.vec.x -= 1; },
        Direction::Right => { position.vec.x += 1; },
        Direction::Up => { position.vec.y -= 1; },
        Direction::Down => { position.vec.y += 1; },
    };
    position
}
