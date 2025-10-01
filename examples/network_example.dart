import 'package:bdk_dart/bdk.dart';

void main() {
  // Create a NetworkExample instance
  final networkHelper = NetworkExample();
  
  // Get the Signet network
  final signetNetwork = networkHelper.get_signet();
  
  // Convert it to string - should print "Signet"
  final networkName = networkHelper.network_name(signetNetwork);
  
  print("Network: $networkName");
}