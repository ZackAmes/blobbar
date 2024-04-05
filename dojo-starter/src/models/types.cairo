
#[derive(Serde, Copy, Drop)]
enum TileType {
    None,
    Ground,
    Trash,
    Bar,
    Ingredient: DrinkType,

}

#[derive(Serde, Copy, Drop, Introspect)]
enum Level {
    None,
    One,
    Two,
    Three,
    Endless
}

#[derive(Serde, Copy, Drop, Introspect)]
enum DrinkType {
    None,
    Grog,
    Rum, 
    Vodka,
    Soda,
    Juice,
    Syrup
}



#[derive(Serde, Copy, Drop, Introspect)]
enum Direction {
    None,
    Left,
    Right,
    Up,
    Down,
}


impl DirectionIntoFelt252 of Into<Direction, felt252> {
    fn into(self: Direction) -> felt252 {
        match self {
            Direction::None => 0,
            Direction::Left => 1,
            Direction::Right => 2,
            Direction::Up => 3,
            Direction::Down => 4,
        }
    }
}
