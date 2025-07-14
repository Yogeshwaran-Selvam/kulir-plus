class ACModel {
  late int id;

  // Core Controls
  late int temperature;
  late String mode; // Cool, Eco, Turbo, Sleep
  late String fanSpeed; // Low, Medium, High, Auto
  late bool isPowerOn;
  late bool isOnline;

  // Energy Insights
  late double liveEnergyUsage; // in watts
  late String energyStatus; // Extreme, Good, Excellent
  late double cost; // in $
  late double nativeCost; // in local currency
  late double co2Emission; // in kg
  late String co2Status; // Extreme, Good, Excellent

  // Maintenance
  late bool serviceAlert;

  // Personalization
  late String nickname;
  late String roomSvg;
  late String roomLottie;

  ACModel({
    this.id = -1,
    required this.isOnline,
    required this.temperature,
    required this.mode,
    required this.fanSpeed,
    required this.isPowerOn,
    required this.liveEnergyUsage,
    required this.energyStatus,
    required this.cost,
    required this.nativeCost,
    required this.co2Emission,
    required this.co2Status,
    required this.serviceAlert,
    required this.nickname,
    required this.roomSvg,
    required this.roomLottie,
  });
}