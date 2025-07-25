// Simple implementation just for the Network enum
#[derive(Debug, Clone)]
pub enum Network {
    Bitcoin,
    Testnet,
    Signet,
    Regtest,
    Testnet4,
}

pub struct NetworkExample;

impl NetworkExample {
    pub fn new() -> Self {
        Self
    }

    pub fn get_signet(&self) -> Network {
        Network::Signet
    }

    pub fn network_name(&self, network: Network) -> String {
        match network {
            Network::Bitcoin => "Bitcoin".to_string(),
            Network::Testnet => "Testnet".to_string(),
            Network::Signet => "Signet".to_string(),
            Network::Regtest => "Regtest".to_string(),
            Network::Testnet4 => "Testnet4".to_string(),
        }
    }
}

uniffi::include_scaffolding!("simple_bdk");