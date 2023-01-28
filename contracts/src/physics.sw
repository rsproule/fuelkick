library physics;

// pub const MAX_WIDTH = 100;
// pub const MAX_HEIGHT = 100;
pub struct State {
    ball_position: PhysicsVector,
    velocity: PhysicsVector
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

pub fn apply_force(pre_state: State, direction: PhysicsVector) -> State {
    // TODO
    pre_state
}