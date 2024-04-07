use blobbar::blobert::types::seeder::Seed;
use blobbar::models::types::Level;
#[dojo::interface]
trait ISeeder<TContractState> {
    fn generate_seed(
        self: @TContractState,
        descriptor_addr: starknet::ContractAddress,
        level: Level,
        time_stamp: u64,
        index: u32,
        address: felt252
    ) -> Seed;
}



#[dojo::contract]
mod Seeder {
    use alexandria_math::BitShift;
    use blobbar::blobert::descriptor::{
        IDescriptorDispatcher, IDescriptorDispatcherTrait
    };
    use blobbar::blobert::types::seeder::Seed;
    use blobbar::models::types::Level;
    use core::poseidon::poseidon_hash_span;
    use core::u256;

    use starknet::ContractAddress;

    #[abi(embed_v0)]
    impl Seeder of super::ISeeder<ContractState> {

        fn generate_seed(
            self: @ContractState,
            descriptor_addr: starknet::ContractAddress,
            level: Level,
            time_stamp: u64,
            index: u32,
            address:felt252
        ) -> Seed {
            let descriptor = IDescriptorDispatcher { contract_address: descriptor_addr };

            let randomness: u256 = poseidon_hash_span(
                array![address,time_stamp.into(), index.into()]
                    .span()
            )
                .into();

            let mut order_count = 1;


            match level {
                Level::None => {
                },
                Level::One => {
                    order_count = 5;
                },
                Level::Two => {
                    order_count = 9;
                },
                Level::Three => {
                    order_count = 13;
                },
                Level::Endless => {
                    order_count = 17;
                }
            }
            let armour_count: u256 = descriptor.armour_count().into();
            let JEWELRY_COUNT: u256 = descriptor.JEWELRY_COUNT().into();
            let weapon_count: u256 = descriptor.weapon_count().into();
            let mut mask_count: u256 = descriptor.mask_count().into();

            let order: u8 = (randomness % order_count).try_into().unwrap();
            let armour: u8 = (BitShift::shr(randomness, 48) % armour_count).try_into().unwrap();

            // only allow the mask to be one of the first 8 masks 
            // where the armour is sheep wool or kigurumi
            if armour == 0 || armour == 1 {
                mask_count = 8;
            };

            let jewelry: u8 = (BitShift::shr(randomness, 96) % JEWELRY_COUNT).try_into().unwrap();
            let mask: u8 = (BitShift::shr(randomness, 144) % mask_count).try_into().unwrap();
            let weapon: u8 = (BitShift::shr(randomness, 192) % weapon_count).try_into().unwrap();
            return Seed { order, armour, jewelry, mask, weapon };
        }
    }
}