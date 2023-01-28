contract;

dep physics;
dep interface;
use interface::FuelKick;
use physics::{State, apply_force, PhysicsVector};
use std::storage::StorageVec;
use std::auth::msg_sender;

storage {
    physics_state: State = State {
            ball_position: PhysicsVector {x: 0, y: 0, z: 0},
            velocity: PhysicsVector {x: 0, y: 0, z: 0}
        },
}

impl FuelKick for Contract {
    #[storage(read, write)]
    fn kick(velocity: [u64; 2]) {
        // TODO: some auth checks and spend energy 
        let sender = msg_sender();
        // let player
        let v = PhysicsVector {x: velocity[0], y: velocity[1], z: 0};
        let post_state = apply_force(storage.physics_state, v);
        // TODO: check for win conditions
        storage.physics_state = post_state; 

    }
    
    #[storage(read, write)]
    fn join(energy_to_buy: u64) {

    }
}
