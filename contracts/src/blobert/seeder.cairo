use blobbar::blobert::types::seeder::Seed;

#[starknet::interface]
trait ISeeder<TContractState> {
    fn generate_seed(
        self: @TContractState,
        token_id: u256,
        descriptor_addr: starknet::ContractAddress,
        salt: felt252
    ) -> Seed;
}



#[starknet::contract]
mod Seeder {
    use alexandria_math::BitShift;
    use blobbar::blobert::descriptor::{
        IDescriptorDispatcher, IDescriptorDispatcherTrait
    };
    use blobbar::blobert::types::seeder::Seed;
    use core::poseidon::poseidon_hash_span;
    use core::u256;

    use starknet::ContractAddress;


    #[storage]
    struct Storage {}

    #[abi(embed_v0)]
    impl Seeder of super::ISeeder<ContractState> {
        fn generate_seed(
            self: @ContractState,
            token_id: u256,
            descriptor_addr: starknet::ContractAddress,
            salt: felt252
        ) -> Seed {
            let descriptor = IDescriptorDispatcher { contract_address: descriptor_addr };

            let block_timestamp = starknet::get_block_timestamp();
            let randomness: u256 = poseidon_hash_span(
                array![block_timestamp.into(), token_id.low.into(), token_id.high.into(), salt]
                    .span()
            )
                .into();

            let armour_count: u256 = descriptor.armour_count().into();
            let JEWELRY_COUNT: u256 = descriptor.JEWELRY_COUNT().into();
            let weapon_count: u256 = descriptor.weapon_count().into();
            let mut mask_count: u256 = descriptor.mask_count().into();

            let armour: u8 = (BitShift::shr(randomness, 48) % armour_count).try_into().unwrap();

            // only allow the mask to be one of the first 8 masks 
            // where the armour is sheep wool or kigurumi
            if armour == 0 || armour == 1 {
                mask_count = 8;
            };

            let jewelry: u8 = (BitShift::shr(randomness, 96) % JEWELRY_COUNT).try_into().unwrap();
            let mask: u8 = (BitShift::shr(randomness, 144) % mask_count).try_into().unwrap();
            let weapon: u8 = (BitShift::shr(randomness, 192) % weapon_count).try_into().unwrap();
            return Seed { background: 0, armour, jewelry, mask, weapon };
        }
    }
}