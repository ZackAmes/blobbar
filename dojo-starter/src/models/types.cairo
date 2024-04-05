
#[derive(Serde, Copy, Drop, Introspect)]
enum TileType {
    None,
    Ground,
    Drink,
    Trash,
    Bar,
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
    Wine
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
