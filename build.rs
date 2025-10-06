fn main() {
    const UDL_PATH: &str = "bdk-ffi/bdk-ffi/src/bdk.udl";
    println!("cargo:rerun-if-changed={}", UDL_PATH);
    uniffi::generate_scaffolding(UDL_PATH).expect("failed to generate uniffi scaffolding");
}
