library physics;
dep math;
use ::math::sqrt_ceil;
use std::block::height;
use std::logging::log;
use signed_integers::i64::I64;

// pub const MAX_WIDTH = 100;
// pub const MAX_HEIGHT = 100;
pub struct State {
    position: PhysicsVector,
    velocity: PhysicsVector,
    t: u64
    // players: Vec<Player>,
}
pub struct PhysicsVector {
    x: I64,
    y: I64,
    z: I64
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
        x: state.position.x + (state.velocity.x * I64::from(t)),
        y: state.position.y + (state.velocity.y * I64::from(t)),
        z: state.position.z + (state.velocity.z * I64::from(t))
    }
}

pub fn get_distance(from: PhysicsVector, to: PhysicsVector) -> u64 {
    let dx = from.x - to.x;
    let dy = from.y - to.y;
    let dz = from.z - to.z;
    let sum_d = (dx * dx) + (dy * dy) + (dz * dz);
    // sum_d is guaranteed to be positive
    sqrt_ceil(sum_d.into())
}

// just readability helper  
pub fn magnitude(v: PhysicsVector) -> u64 {
    let zero_vec = PhysicsVector {x: I64::from(0), y: I64::from(0), z: I64::from(0)};
    get_distance(zero_vec, v)
}

#[test]
fn test_distance() {
    let point1 = PhysicsVector {
        x: I64::from(0),
        y: I64::from(0),
        z: I64::from(0)
    };
    // good ole pythagorean triple
    let point2 = PhysicsVector {
        x: I64::from(1),
        y: I64::from(1), 
        z: I64::from(1)
    };
    
    let d = get_distance(point1, point2);
    // let dr = get_distance(point2, point1);
    // assert(d == 0);
    // let far_point = PhysicsVector {
    //     x: I64::from(68),
    //     y: I64::from(285), 
    //     z: I64::from(0)};
    // let d = get_distance(point1, far_point);
    // assert(d == 293);

    // let a = PhysicsVector {
    //     x: I64::from(4),
    //     y: I64::from(4),
    //     z: I64::from(4)
    // };
    // let b = PhysicsVector {
    //     x: I64::from(17),
    //     y: I64::from(6),
    //     z: I64::from(2)
    // };
    // // 13.304
    // let d = get_distance(a, b);
    // assert(d != 14);
}

#[test]
fn test_i64_math() {
    let i = I64::from(1);
    let ii = I64::from(1);
    let ir = i + ii;
    assert(i + ii == I64::from(2));
}