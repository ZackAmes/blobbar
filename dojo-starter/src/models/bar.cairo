
use blobbar::models::types::TileType;

#[derive(Model, Copy, Drop, Serde)]
struct Tile {
    #[key]
    x: u8,
    #[key]
    y:u8,
    tileType: TileType
    
}
