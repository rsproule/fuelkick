library physics;
dep math;
use ::math::sqrt_ceil;
use std::block::height;

// pub const MAX_WIDTH = 100;
// pub const MAX_HEIGHT = 100;
pub struct State {
    position: PhysicsVector,
    velocity: PhysicsVector,
    t: u64
    // players: Vec<Player>,
}
pub struct PhysicsVector {
    x: u64,
    y: u64,
    z: u64
}
pub struct Action {
    // player: Player,
    direction: PhysicsVector,
    energy: u64
}

// just treat this as a normal perfect elastic collision, 
pub fn apply_force(pre_state: State, kick_velo: PhysicsVector) -> State {
    // m1*v1 + m2v2 = m1*v1 + m2v2
    // assume the masses are just 1, and that the kicker's post momentum is 0
    // v1 + v2 = v1_post + 0
    let collision_point = get_position(pre_state, height());
    let v1 = pre_state.velocity;
    // TODO: foresee a problem with using u64 (need negatives)
    let v_post = PhysicsVector {
        x: v1.x + kick_velo.x,
        y: v1.y + kick_velo.y,
        z: v1.z + kick_velo.z,
    };
    let post_state = State {
        position: collision_point,
        velocity: v_post,
        t: height(),
    };
    post_state
}

pub fn get_position(state: State, blocknumber: u64) -> PhysicsVector {
    let t = blocknumber - state.t; 
    PhysicsVector {
        x: state.position.x + (state.velocity.x * t),
        y: state.position.y + (state.velocity.y * t),
        z: state.position.z + (state.velocity.z * t),
    }
}

pub fn get_distance(from: PhysicsVector, to: PhysicsVector) -> u64 {
    let dx = if from.x > to.x {from.x - to.x } else {to.x - from.x};
    let dy = if from.y > to.y {from.y - to.y } else {to.y - from.y};
    let dz = if from.z > to.z {from.z - to.z } else {to.z - from.z};
    let sum_d = (dx * dx) + (dy * dy) + (dz * dz);

    sqrt_ceil(sum_d)
}