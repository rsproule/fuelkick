contract;

abi FuelKick {
    fn kick() -> bool;
}

impl FuelKick for Contract {
    fn kick() -> bool {
        true
    }
}
