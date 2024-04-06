use blobbar::blobert::types::seeder::Seed;

#[dojo::interface]
trait IDescriptor<TContractState> {
    fn armour_count(self: @TContractState) -> u8;
    fn armour(self: @TContractState, index: u8) -> (ByteArray, ByteArray);

    fn JEWELRY_COUNT(self: @TContractState) -> u8;
    fn jewelry(self: @TContractState, index: u8) -> (ByteArray, ByteArray);

    fn mask_count(self: @TContractState) -> u8;
    fn mask(self: @TContractState, index: u8) -> (ByteArray, ByteArray);

    fn weapon_count(self: @TContractState) -> u8;
    fn weapon(self: @TContractState, index: u8) -> (ByteArray, ByteArray);

    fn svg_image(self: @TContractState, seed: Seed) -> ByteArray;
}

#[dojo::contract]
mod Descriptor {
    use blobbar::blobert::generation::{
        armour::{ARMOUR_COUNT}, mask::{MASK_COUNT},
        jewelry::{JEWELRY_COUNT}, weapon::{WEAPON_COUNT}
    };
    use blobbar::blobert::generation::{
        armour::{armours}, mask::{masks}, jewelry::{jewellries}, weapon::{weapons}
    };
    use blobbar::blobert::types::seeder::Seed;
    use graffiti::json::JsonImpl;


    use graffiti::{Tag, TagImpl};

    use starknet::ContractAddress;


    #[abi(embed_v0)]
    impl DescriptorImpl of super::IDescriptor<ContractState> {
        fn armour_count(self: @ContractState) -> u8 {
            return ARMOUR_COUNT;
        }

        fn armour(self: @ContractState, index: u8) -> (ByteArray, ByteArray) {
            armours(index)
        }

        fn JEWELRY_COUNT(self: @ContractState) -> u8 {
            return JEWELRY_COUNT;
        }

        fn jewelry(self: @ContractState, index: u8) -> (ByteArray, ByteArray) {
            jewellries(index)
        }

        fn mask_count(self: @ContractState) -> u8 {
            return MASK_COUNT;
        }

        fn mask(self: @ContractState, index: u8) -> (ByteArray, ByteArray) {
            masks(index)
        }

        fn weapon_count(self: @ContractState) -> u8 {
            return WEAPON_COUNT;
        }

        fn weapon(self: @ContractState, index: u8) -> (ByteArray, ByteArray) {
            weapons(index)
        }

        fn svg_image(self: @ContractState, seed: Seed) -> ByteArray {
            let (armour_bytes, _) = armours(seed.armour);
            let (mask_bytes, _) = masks(seed.mask);
            let (jewelry_bytes, _) = jewellries(seed.jewelry);
            let (weapon_bytes, _) = weapons(seed.weapon);

            self
                .construct_image(
                    armour: armour_bytes,
                    mask: mask_bytes,
                    jewelry: jewelry_bytes,
                    weapon: weapon_bytes,
                )
        }
    }


    #[generate_trait]
    impl InternalImpl of InternalTrait {

        fn construct_image(
            self: @ContractState,
            armour: ByteArray,
            mask: ByteArray,
            jewelry: ByteArray,
            weapon: ByteArray,
        ) -> ByteArray {
            // construct svg image

            let image_body: Tag = TagImpl::new("image")
                .attr("href", "data:image/png;base64," + armour)
                .attr("x", "0")
                .attr("y", "0")
                .attr("width", "350px")
                .attr("height", "350px");

            let image_head: Tag = TagImpl::new("image")
                .attr("href", "data:image/png;base64," + mask)
                .attr("x", "0")
                .attr("y", "0")
                .attr("width", "350px")
                .attr("height", "350px");

            let image_jewelry: Tag = TagImpl::new("image")
                .attr("href", "data:image/png;base64," + jewelry)
                .attr("x", "0")
                .attr("y", "0")
                .attr("width", "350px")
                .attr("height", "350px");

            let image_weapon: Tag = TagImpl::new("image")
                .attr("href", "data:image/png;base64," + weapon)
                .attr("x", "0")
                .attr("y", "0")
                .attr("width", "350px")
                .attr("height", "350px");

            let svg_root: Tag = TagImpl::new("svg")
                .attr("xmlns", "http://www.w3.org/2000/svg")
                .attr("preserveAspectRatio", "xMinYMin meet")
                .attr("style", "image-rendering: pixelated")
                .attr("viewBox", "0 0 350 350");

            let svg = svg_root
                .insert(image_head)
                .insert(image_body)
                .insert(image_jewelry)
                .insert(image_weapon)
                .build();

            svg
        }


    }
}