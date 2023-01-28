lib physics;

pub struct State {
    ball_position: Vec<u64>, 
    velocity: Velocity;
    players: Vec<Player>,
    last_action: Action
}

pub struct Player {
    position: Position 
}

pub type Position = [u64, 2];
pub type Velocity = [u64, 2]


pub fn apply_force(pre_state: State, player: Player, direction: Velocity, energy: u64) -> State {

}