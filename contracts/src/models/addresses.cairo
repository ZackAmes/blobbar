use starknet::ContractAddress;

#[derive(Model, Copy, Drop, Serde)]
struct Addresses {
    #[key]
    key: u8,
    seeder: ContractAddress,
    descriptor: ContractAddress,
    set: bool
}