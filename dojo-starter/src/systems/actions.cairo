use blobbar::models::types::Direction;
use blobbar::models::position::Position;

// define the interface
#[dojo::interface]
trait IActions {
    fn spawn();
    fn move(direction: Direction);
}

// dojo decorator
#[dojo::contract]
mod actions {
    use super::{IActions, next_position};

    use starknet::{ContractAddress, get_caller_address};
    use blobbar::models::{position::{Position, Vec2}, types::{Level, Direction}, blobtender::{Blobtender}, bar::{Tile}};


    // impl: implement functions specified in trait
    #[abi(embed_v0)]
    impl ActionsImpl of IActions<ContractState> {
        fn spawn(world: IWorldDispatcher) {
            // Get the address of the current caller, possibly the player's address.
            let player = get_caller_address();
            // Retrieve the player's current position from the world.
            let btender = get!(world, player, (Blobtender));

            
        }

        fn move(world: IWorldDispatcher, direction: Direction) {
        
        }
    }

    #[generate_trait]
    impl Private of PrivateTrait {
        fn spawn_level(world: IWorldDispatcher, level: Level) {
            match level {
                Level::One => {
                    
                },
                Level::Two => {

                },
                Level::Three => {

                },
                Level::Endless => {
                    
                }

            }
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
