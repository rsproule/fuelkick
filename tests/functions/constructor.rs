use crate::utils::{setup::setup};
 mod success {
        use super::*;

    #[tokio::test]
    async fn create_game() {
        let (player1, player2) = setup().await;
    }
 }