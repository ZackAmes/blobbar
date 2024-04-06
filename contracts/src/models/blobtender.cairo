
use blobbar::models::types::{Direction, DrinkType, Level, Vec2};
use blobbar::blobert::types::seeder::Seed;
use starknet::ContractAddress;

#[derive(Model, Copy, Drop, Serde)]
struct Blobtender {
    #[key]
    player: ContractAddress,
    level: Level,
    position: Vec2,
    serving: DrinkType,
    points: u32,
    blobert: Seed
}

#[generate_trait]
impl BlobtenderImpl of BlobtenderTrait {

    fn new(player: ContractAddress, blobert: Seed) -> Blobtender {
        Blobtender {player, level:Level::One, position: Vec2 {x: 2, y:1}, serving: DrinkType::None, points: 0, blobert}
    }

    fn serve(ref self: Blobtender) {
        match self.level {
            Level::None => {
                panic!("??");
            },
            Level::One => {
                self.points += 100;
            },
            Level::Two => {
                self.points += 150;
            },
            Level::Three => {
                self.points += 250;
            },
            Level::Endless => {
                self.points+=300;
            }
        }
        self.serving = DrinkType::None;
    }
    
}

