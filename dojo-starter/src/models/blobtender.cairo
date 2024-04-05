
use blobbar::models::types::{Direction, DrinkType, Level, Vec2};
use starknet::ContractAddress;

#[derive(Model, Copy, Drop, Serde)]
struct Blobtender {
    #[key]
    player: ContractAddress,
    level: Level,
    position: Vec2,
    serving: DrinkType,

}

#[generate_trait]
impl BlobtenderImpl of BlobtenderTrait {

    fn new(player: ContractAddress) -> Blobtender {
        Blobtender {player, level:Level::One, position: Vec2 {x: 2, y:1}, serving: DrinkType::None}
    }
    
}

