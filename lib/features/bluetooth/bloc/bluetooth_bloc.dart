import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:blue_thermal_printer/blue_thermal_printer.dart';

class BluetoothState {
  final List<BluetoothDevice> devices;
  final List<BluetoothDevice> unpairedDevices;
  final BluetoothDevice? selectedDevice;
  final bool printingInProgress;

  BluetoothState({
    required this.devices,
    required this.unpairedDevices,
    required this.selectedDevice,
    required this.printingInProgress,
  });

  factory BluetoothState.initial() {
    return BluetoothState(
      devices: [],
      unpairedDevices: [],
      selectedDevice: null,
      printingInProgress: false,
    );
  }

  BluetoothState copyWith({
    List<BluetoothDevice>? devices,
    List<BluetoothDevice>? unpairedDevices,
    BluetoothDevice? selectedDevice,
    bool? printingInProgress,
  }) {
    return BluetoothState(
      devices: devices ?? this.devices,
      unpairedDevices: unpairedDevices ?? this.unpairedDevices,
      selectedDevice: selectedDevice ?? this.selectedDevice,
      printingInProgress: printingInProgress ?? this.printingInProgress,
    );
  }
}

abstract class BluetoothEvent {}

class GetBluetoothDevices extends BluetoothEvent {}

class ConnectToDevice extends BluetoothEvent {
  final BluetoothDevice device;

  ConnectToDevice(this.device);
}

class DisconnectDevice extends BluetoothEvent {}

class PrintOk extends BluetoothEvent {}

class BluetoothBloc extends Bloc<BluetoothEvent, BluetoothState> {
  BlueThermalPrinter bluetoothPrinter = BlueThermalPrinter.instance;

  BluetoothBloc() : super(BluetoothState.initial());

  @override
  Stream<BluetoothState> mapEventToState(BluetoothEvent event) async* {
    if (event is GetBluetoothDevices) {
      yield* _mapGetBluetoothDevicesToState();
    } else if (event is ConnectToDevice) {
      yield* _mapConnectToDeviceToState(event.device);
    } else if (event is DisconnectDevice) {
      yield* _mapDisconnectDeviceToState();
    } else if (event is PrintOk) {
      yield* _mapPrintOkToState();
    }
  }

  Stream<BluetoothState> _mapGetBluetoothDevicesToState() async* {
    try {
      List<BluetoothDevice> devices = await bluetoothPrinter.getBondedDevices();
      yield state.copyWith(devices: devices);
    } catch (e) {
      // Handle error
    }
  }

  Stream<BluetoothState> _mapConnectToDeviceToState(
      BluetoothDevice device) async* {
    try {
      // Connect to the device
      await bluetoothPrinter.connect(device);
      yield state.copyWith(selectedDevice: device);
    } catch (e) {
      // Handle error
    }
  }

  Stream<BluetoothState> _mapDisconnectDeviceToState() async* {
    try {
      // Disconnect from the device
      await bluetoothPrinter.disconnect();
      yield state.copyWith(selectedDevice: null);
    } catch (e) {
      // Handle error
    }
  }

  Stream<BluetoothState> _mapPrintOkToState() async* {
    try {
      // Print "OK"
      await bluetoothPrinter.printLeftRight("Številka:", "18000001", 5,
          charset: "windows-1250");
      await bluetoothPrinter.printCustom("Body left", 2, 1);
      await bluetoothPrinter.printCustom("Body right", 1, 3);
      await bluetoothPrinter.printNewLine();
      await bluetoothPrinter.printCustom("Thank You", 5, 2);
      await bluetoothPrinter.printNewLine();
      await bluetoothPrinter.printQRcode(
          "Insert Your Own Text to Generate", 200, 200, 2);
      await bluetoothPrinter.printNewLine();
      await bluetoothPrinter.printNewLine();
    } catch (e) {
      // Handle error
    }
  }
}
