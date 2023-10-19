import 'package:esc_pos_bluetooth/esc_pos_bluetooth.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:flutter/material.dart' hide Image;

class BluetoothPage extends StatefulWidget {
  @override
  _BluetoothPageState createState() => _BluetoothPageState();
}

class _BluetoothPageState extends State<BluetoothPage> {
  PrinterBluetoothManager printerManager = PrinterBluetoothManager();
  List<PrinterBluetooth> _devices = [];
  PrinterBluetooth? _selectedDevice;
  bool _printingInProgress = false;

  @override
  void initState() {
    super.initState();
    _startScanDevices();
  }

  Future<void> _getBluetoothDevices() async {
    printerManager.scanResults.listen((devices) async {
      if (mounted) {
        setState(() {
          _devices = devices;
        });
      }
    });
    // _startScanDevices();
  }

  void _startScanDevices() {
    setState(() {
      _devices = [];
    });
    printerManager.startScan(const Duration(seconds: 4));
    _getBluetoothDevices();
  }

  void _stopScanDevices() {
    printerManager.stopScan();
  }

  Future<List<int>> demoReceipt(
      PaperSize paper, CapabilityProfile profile) async {
    final Generator ticket = Generator(paper, profile);
    List<int> bytes = [];

    bytes += ticket.text('Alphatech GT PLC.',
        styles: const PosStyles(
          align: PosAlign.center,
          height: PosTextSize.size2,
          width: PosTextSize.size2,
        ),
        linesAfter: 1);

    bytes += ticket.text('Agent:  Mati',
        styles: const PosStyles(align: PosAlign.center));
    bytes += ticket.text('ka\'umsa:  Ambo Station',
        styles: const PosStyles(align: PosAlign.center));
    bytes += ticket.text('ka\'umsa:  Ambo Station',
        styles: const PosStyles(align: PosAlign.center));
    bytes += ticket.text('Ga\'umsa:  Asko Station',
        styles: const PosStyles(align: PosAlign.center));
    bytes += ticket.text('Lakk. Gabate:  OR-20234',
        styles: const PosStyles(align: PosAlign.center));
    bytes += ticket.text('Maqaa Imalaa:  Abalulaa',
        styles: const PosStyles(align: PosAlign.center));
    bytes += ticket.text('Lakk. Tessumaa:  #3',
        styles: const PosStyles(align: PosAlign.center));
    bytes += ticket.text('Fageenya:  20 KM',
        styles: const PosStyles(align: PosAlign.center));
    bytes += ticket.text('Gatii Geejjibaa:  120 ETB',
        styles: const PosStyles(align: PosAlign.center));
    bytes += ticket.text('Gatii Tajajilaa:  3.50 ETB',
        styles: const PosStyles(align: PosAlign.center));
    bytes += ticket.text('Waliigala:  123.50 ETB',
        styles: const PosStyles(align: PosAlign.center));
    bytes += ticket.hr();
    bytes += ticket.text('Tel: 09202020202',
        styles: const PosStyles(align: PosAlign.center));
    bytes += ticket.text('Web: www.alphatechtrading.com',
        styles: const PosStyles(align: PosAlign.center), linesAfter: 1);
    bytes += ticket.emptyLines(2);
    return bytes;
  }

  void _testPrint() async {
    if (_selectedDevice == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please select a device"),
          duration: Duration(seconds: 3),
        ),
      );
      return;
    }

    const PaperSize paper = PaperSize.mm80;
    final profile = await CapabilityProfile.load();

    final PosPrintResult res =
        await printerManager.printTicket((await demoReceipt(paper, profile)));
  }

  Future<void> _refreshDevices() async {
    setState(() {
      _devices = [];
      _selectedDevice = null;
    });
    _startScanDevices();
  }

  Future<void> _connectToDevice(PrinterBluetooth device) async {
    if (_selectedDevice?.address == device.address) {
      setState(() {
        _selectedDevice = null;
        printerManager = PrinterBluetoothManager();
      });
    } else {
      printerManager.selectPrinter(device);
      setState(() {
        _selectedDevice = device;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bluetooth Devices'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _refreshDevices,
        child: const Icon(Icons.refresh),
      ),
      body: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: _devices.length,
            itemBuilder: (context, index) {
              PrinterBluetooth device = _devices[index];
              bool isConnected = device == _selectedDevice;
              return ListTile(
                // onTap: () => _connectToDevice(device),
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
            onPressed: () {
              _printingInProgress ? null : _testPrint();
            },
            child: const Text('Print'),
          ),
        ],
      ),
    );
  }
}
