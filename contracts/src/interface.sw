library interface;

abi FuelKick {
    #[storage(read, write)]
    fn kick(velocity: [u64;2]);
    #[storage(read, write)]
    fn join(energy_to_buy: u64);
}