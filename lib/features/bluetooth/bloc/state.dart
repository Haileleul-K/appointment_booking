import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/material.dart';

@immutable
abstract class BluetoothState {
  const BluetoothState();

  BluetoothState copyWith();
}

class BluetoothInitial extends BluetoothState {
  @override
  BluetoothState copyWith() {
    return BluetoothInitial();
  }
}

class BluetoothLoading extends BluetoothState {
  @override
  BluetoothState copyWith() {
    return BluetoothLoading();
  }
}

class BluetoothLoaded extends BluetoothState {
  final List<BluetoothDevice> devices;

  BluetoothLoaded({required this.devices});

  @override
  BluetoothState copyWith() {
    return BluetoothLoaded(devices: devices);
  }
}

class BluetoothError extends BluetoothState {
  final String errorMessage;

  BluetoothError({required this.errorMessage});

  @override
  BluetoothState copyWith() {
    return BluetoothError(errorMessage: errorMessage);
  }
}

class BluetoothPrinting extends BluetoothState {
  @override
  BluetoothState copyWith() {
    return BluetoothPrinting();
  }
}

class BluetoothPrintSuccess extends BluetoothState {
  final String successMessage;

  BluetoothPrintSuccess({required this.successMessage});

  @override
  BluetoothState copyWith() {
    return BluetoothPrintSuccess(successMessage: successMessage);
  }
}

class BluetoothPrintError extends BluetoothState {
  final String errorMessage;

  BluetoothPrintError({required this.errorMessage});

  @override
  BluetoothState copyWith() {
    return BluetoothPrintError(errorMessage: errorMessage);
  }
}
