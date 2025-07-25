#[derive(uniffi::Enum, Debug, Clone)]
pub enum Network {
    Bitcoin,
    Testnet,
    Signet,
    Regtest,
}

#[uniffi::export]
pub fn get_signet_network() -> Network {
    Network::Signet
}

#[uniffi::export]
pub fn network_to_string(network: Network) -> String {
    match network {
        Network::Bitcoin => "Bitcoin".to_string(),
        Network::Testnet => "Testnet".to_string(),
        Network::Signet => "Signet".to_string(),
        Network::Regtest => "Regtest".to_string(),
    }
}