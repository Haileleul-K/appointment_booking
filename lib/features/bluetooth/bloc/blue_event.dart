import 'package:blue_thermal_printer/blue_thermal_printer.dart';

abstract class BluetoothEvent {
  const BluetoothEvent();

  @override
  List<Object> get props => [];
}

class GetBluetoothDevices extends BluetoothEvent {}

class ConnectToDevice extends BluetoothEvent {
  final BluetoothDevice device;

  ConnectToDevice(this.device);

  @override
  List<Object> get props => [device];
}

class DisconnectDevice extends BluetoothEvent {}

class PrintText extends BluetoothEvent {
  final String text;

  PrintText(this.text);

  @override
  List<Object> get props => [text];
}
