import 'package:flutter/material.dart';
import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/services.dart';

class BluetoothPagea extends StatefulWidget {
  @override
  _BluetoothPageaState createState() => _BluetoothPageaState();
}

class _BluetoothPageaState extends State<BluetoothPagea> {
  BlueThermalPrinter bluetoothPrinter = BlueThermalPrinter.instance;
  List<BluetoothDevice> _devices = [];
  List<BluetoothDevice> _unpairedDevices = [];
  BluetoothDevice? _selectedDevice;
  bool _printingInProgress = false;

  @override
  void initState() {
    super.initState();
    _getBluetoothDevices();
  }

  Future<void> _getBluetoothDevices() async {
    List<BluetoothDevice> devices = await bluetoothPrinter.getBondedDevices();
    setState(() {
      _devices = devices;
    });
  }

  Future<void> _connectToDevice(BluetoothDevice device) async {
    bool? isConnected = await bluetoothPrinter.isConnected;
    if (isConnected!) {
      await bluetoothPrinter.disconnect();
      setState(() {
        _selectedDevice = null;
      });
    } else {
      bool isConnected = await bluetoothPrinter.connect(device);
      if (isConnected) {
        setState(() {
          _selectedDevice = device;
        });
      }
    }
  }

  Future<void> _printOk() async {
    if (_selectedDevice != null) {
      setState(() {
        _printingInProgress = true;
      });
      // ByteData bytesData = await rootBundle.load("assets/images/logo.png");
      // await bluetoothPrinter.printImageBytes(bytesData.buffer
      //     .asUint8List(bytesData.offsetInBytes, bytesData.lengthInBytes));

      await bluetoothPrinter.printNewLine();
      await bluetoothPrinter.printCustom("-------------------------", 0, 0);
      await bluetoothPrinter.printCustom("Alphatech PLC", 2, 0);
      await bluetoothPrinter.printCustom("-------------------------", 0, 0);
      await bluetoothPrinter.print3Column("Agent:", "Name", "", 1);
      await bluetoothPrinter.printLeftRight("Station:", "Ambo", 1);
      await bluetoothPrinter.printLeftRight("Destination:", "Addis Ababa", 1);
      await bluetoothPrinter.printLeftRight("Plate Number:", "OR-20342", 1);
      await bluetoothPrinter.printLeftRight("Passenger Name:", "Abalula", 1);
      await bluetoothPrinter.printLeftRight("Seat Number:", "#2", 1);
      await bluetoothPrinter.printLeftRight("Distance:", "20 KM", 1);
      await bluetoothPrinter.printLeftRight("Tarrif:", "130 ETB", 1);
      await bluetoothPrinter.printLeftRight("Service Charge:", "3.5 ETb", 1);
      await bluetoothPrinter.printLeftRight("Total:", "133.5 ETB", 1);
      await bluetoothPrinter.printNewLine();
      await bluetoothPrinter.printCustom("Thank You", 2, 2);
      await bluetoothPrinter.printNewLine();
      await bluetoothPrinter.printNewLine();
      await bluetoothPrinter.printNewLine();

      setState(() {
        _printingInProgress = false;
      });
    }
  }

  Future<void> _refreshDevices() async {
    setState(() {
      _devices = [];
      _unpairedDevices = [];
      _selectedDevice = null;
    });
    await _getBluetoothDevices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bluetooth Devices'),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: _refreshDevices,
                child: Icon(Icons.refresh),
              ),
            ],
          ),
          Text('Paired Bluetooth Devices:s'),
          ListView.builder(
            shrinkWrap: true,
            itemCount: _devices.length,
            itemBuilder: (context, index) {
              BluetoothDevice device = _devices[index];
              bool isConnected = device == _selectedDevice;
              return ListTile(
                title: Text(device.name!),
                subtitle: Text(
                  isConnected ? 'Connected' : 'Disconnected',
                  style: TextStyle(
                    color: isConnected ? Colors.green : Colors.red,
                  ),
                ),
                leading: Checkbox(
                  value: isConnected,
                  onChanged: (value) => _connectToDevice(device),
                ),
              );
            },
          ),
          ElevatedButton(
            onPressed: _printingInProgress ? null : _printOk,
            child: Text('Print OK'),
          ),
        ],
      ),
    );
  }
}
