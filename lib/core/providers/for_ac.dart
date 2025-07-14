import 'package:flutter/material.dart';
import '/app/app.dart';
import '/core/core.dart';

class ACProvider with ChangeNotifier {
  final List<ACModel> _acs = [
    ACModel(
      id: 0,
      temperature: 25,
      mode: 'Eco',
      fanSpeed: 'Low',
      isPowerOn: true,
      isOnline: false,
      liveEnergyUsage: 850,
      energyStatus: 'Excellent',
      cost: 24.71,
      nativeCost: 2100,
      co2Emission: 0.6,
      co2Status: 'Excellent',
      serviceAlert: false,
      nickname: 'Office',
      roomSvg: AppStrings.officeAsset,
      roomLottie: AppStrings.office
    ),
    ACModel(
      id: 1,
      temperature: 22,
      mode: 'Cool',
      fanSpeed: 'Auto',
      isPowerOn: true,
      isOnline: true,
      liveEnergyUsage: 1250,
      energyStatus: 'Good',
      cost: 33.53,
      nativeCost: 2850,
      co2Emission: 1.2,
      co2Status: 'Good',
      serviceAlert: false,
      nickname: 'Living Room',
      roomSvg: AppStrings.livingroomAsset,
      roomLottie: AppStrings.livingroom
    ),
    ACModel(
      id: 2,
      temperature: 18,
      mode: 'Eco',
      fanSpeed: 'Low',
      isPowerOn: false,
      isOnline: false,
      liveEnergyUsage: 700,
      energyStatus: 'Excellent',
      cost: 21.18,
      nativeCost: 1800,
      co2Emission: 0.8,
      co2Status: 'Excellent',
      serviceAlert: false,
      nickname: 'Bedroom',
      roomSvg: AppStrings.bedroomAsset,
      roomLottie: AppStrings.bedroom
    ),
    ACModel(
      id: 3,
      temperature: 25,
      mode: 'Turbo',
      fanSpeed: 'High',
      isPowerOn: false,
      isOnline: true,
      liveEnergyUsage: 1800,
      energyStatus: 'Extreme',
      cost: 45.88,
      nativeCost: 3900,
      co2Emission: 2.7,
      co2Status: 'Extreme',
      serviceAlert: true,
      nickname: 'Office',
      roomSvg: AppStrings.officeAsset,
      roomLottie: AppStrings.office
    ),
    ACModel(
      id: 4,
      temperature: 20,
      mode: 'Sleep',
      fanSpeed: 'Medium',
      isPowerOn: false,
      isOnline: false,
      liveEnergyUsage: 0,
      energyStatus: 'Good',
      cost: 0.00,
      nativeCost: 0,
      co2Emission: 0,
      co2Status: 'Good',
      serviceAlert: false,
      nickname: 'Hallway',
      roomSvg: AppStrings.hallwayAsset,
      roomLottie: AppStrings.livingroom
    ),
    ACModel(
      id: 5,
      temperature: 24,
      mode: 'Cool',
      fanSpeed: 'Low',
      isPowerOn: true,
      isOnline: true,
      liveEnergyUsage: 1150,
      energyStatus: 'Good',
      cost: 30.00,
      nativeCost: 2550,
      co2Emission: 1.0,
      co2Status: 'Good',
      serviceAlert: false,
      nickname: 'Kitchen',
      roomSvg: AppStrings.kitchenAsset,
      roomLottie: AppStrings.kitchen
    ),
    ACModel(
      id: 6,
      temperature: 16,
      mode: 'Turbo',
      fanSpeed: 'High',
      isPowerOn: true,
      isOnline: true,
      liveEnergyUsage: 2000,
      energyStatus: 'Extreme',
      cost: 55.59,
      nativeCost: 4725,
      co2Emission: 3.0,
      co2Status: 'Extreme',
      serviceAlert: true,
      nickname: 'Living Room',
      roomSvg: AppStrings.livingroomAsset,
      roomLottie: AppStrings.livingroom
    ),
    ACModel(
      id: 7,
      temperature: 23,
      mode: 'Eco',
      fanSpeed: 'Medium',
      isPowerOn: false,
      isOnline: false,
      liveEnergyUsage: 0,
      energyStatus: 'Excellent',
      cost: 0.00,
      nativeCost: 0,
      co2Emission: 0,
      co2Status: 'Excellent',
      serviceAlert: false,
      nickname: 'Bedroom',
      roomSvg: AppStrings.bedroomAsset,
      roomLottie: AppStrings.bedroom
    ),
    ACModel(
      id: 8,
      temperature: 20,
      mode: 'Sleep',
      fanSpeed: 'Auto',
      isPowerOn: true,
      isOnline: false,
      liveEnergyUsage: 900,
      energyStatus: 'Good',
      cost: 26.47,
      nativeCost: 2250,
      co2Emission: 1.5,
      co2Status: 'Good',
      serviceAlert: false,
      nickname: 'Hallway',
      roomSvg: AppStrings.hallwayAsset,
      roomLottie: AppStrings.livingroom
    ),
    ACModel(
      id: 9,
      temperature: 19,
      mode: 'Cool',
      fanSpeed: 'High',
      isPowerOn: true,
      isOnline: true,
      liveEnergyUsage: 1450,
      energyStatus: 'Good',
      cost: 37.06,
      nativeCost: 3150,
      co2Emission: 1.8,
      co2Status: 'Good',
      serviceAlert: false,
      nickname: 'Kitchen',
      roomSvg: AppStrings.kitchenAsset,
      roomLottie: AppStrings.kitchen
    ),
  ];

  List<ACModel> get acs => _acs;

  ACModel getById(int id) => _acs[id];

  void togglePower(int id, {bool? val}) {
    final ac = getById(id);
    ac.isPowerOn = val ?? !ac.isPowerOn;
    notifyListeners();
  }

  void setTemperature(int id, int temp) {
    final ac = getById(id);
    ac.temperature = temp;
    notifyListeners();
  }

  void setMode(int id, String mode) {
    final ac = getById(id);
    ac.mode = mode;
    notifyListeners();
  }

  void setFanSpeed(int id, String speed) {
    final ac = getById(id);
    ac.fanSpeed = speed;
    notifyListeners();
  }

  void setNickname(int id, String name) {
    final ac = getById(id);
    ac.nickname = name;
    notifyListeners();
  }

  void setServiceAlert(int id, bool alert) {
    final ac = getById(id);
    ac.serviceAlert = alert;
    notifyListeners();
  }

  List<ACModel> sortByCost({bool ascending = true}) {
    final acs = _acs;
    acs.sort(
      (a, b) => ascending ? a.cost.compareTo(b.cost) : b.cost.compareTo(a.cost),
    );

    return acs;
  }

  double totalCost() {
    double total = 0;

    for (ACModel ac in acs) {
      total += ac.cost;
    }

    return total;
  }

  void addAc(ACModel ac) {
    ac.id = _acs.length;
    _acs.add(ac);
    notifyListeners();
  }

  void removeAc(int acId) {
    _acs.removeWhere((ac) => ac.id == acId);
    notifyListeners();
  }
}
