library interface;
use ::physics::PhysicsVector;

abi FuelKick {
    #[storage(read, write)]
    fn kick(velocity: PhysicsVector);
    #[storage(read, write)]
    fn join(energy_to_buy: u64, spawn_location: PhysicsVector);
    #[storage(read, write)]
    fn move(to: PhysicsVector);
}

pub struct Kick {
    player: Address, 
    direction: PhysicsVector,
    t: u64,
    energy: u64
}

pub struct Join {
    player: Address, 
    energy: u64,
    location: PhysicsVector
}

pub struct Move {
    player: Address, 
    pre_location: PhysicsVector,
    post_location: PhysicsVector,
    distance: u64
}

pub struct Player {
    energy: u64,
    location: PhysicsVector
}