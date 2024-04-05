
use blobbar::models::types::{Direction, DrinkType};
use blobbar::models::position::{Vec2};
use starknet::ContractAddress;

#[derive(Model, Copy, Drop, Serde)]
struct Blobtender {
    #[key]
    player: ContractAddress,
    position: Vec2,
    serving: DrinkType

}

