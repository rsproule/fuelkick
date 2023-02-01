contract;

dep math;
dep physics;
dep interface;
use interface::{Kick, Move, Join, Player, FuelKick};
use physics::{State, apply_force, PhysicsVector, get_distance, magnitude};
use std::storage::StorageMap;
use std::auth::msg_sender;
use std::logging::log;
use signed_integers::i64::I64;

storage {
    physics_state: State = State {
            position: PhysicsVector {x: I64::new(), y: I64::new(), z: I64::new()},
            velocity: PhysicsVector {x: I64::new(), y: I64::new(), z: I64::new()},
            t: 0
        },
    players: StorageMap<Address, Player> = StorageMap {}
}

impl FuelKick for Contract {
    #[storage(read, write)]
    fn kick(velocity: PhysicsVector) {
        // TODO: some auth checks and spend energy 
        let sender = msg_sender();
        // magnitude is my energy thing, basically the cost of this operation 
        let magnitude = magnitude(velocity);
        let post_state = apply_force(storage.physics_state, velocity);
        // TODO: check for win conditions
        storage.physics_state = post_state; 
        // log(Kick{
        //     player: sender,
        //     direction: velocity,
        //     t: height(),
        //     energy: magnitude 
        // });
    }
    
    #[storage(read, write)]
    fn join(energy_to_buy: u64, spawn_location: PhysicsVector) {
        let sender = msg_sender();
        if let Identity::Address(addr) = sender.unwrap() {
            // for now this can just be arbitrary number, 
            // in reality we will just want this to be the same as tokens
            // which removes the need for this. 
            // they just need to chose their position eventually (if we want that mechanic)
            let new_player = Player {
                energy: energy_to_buy,
                location: spawn_location
            };
            storage.players.insert(addr, new_player);
            // log this
            log(Join{
                player: addr,
                energy: energy_to_buy, 
                location: spawn_location
            });
        } else {
            revert(0);
        }
    }

    #[storage(read, write)]
    fn move(to: PhysicsVector) {
        let sender = msg_sender();
        if let Identity::Address(addr) = sender.unwrap() {
            // log this
            let player = storage.players.get(addr).unwrap();

            let pre_location = player.location;
            let distance = get_distance(player.location, to);
            // spend the energy based on the distance moved 
            log(Move{
                player: addr, 
                pre_location: player.location, 
                post_location: to, 
                distance: distance
                });
        } else {
            revert(0);
        }
    }
}
