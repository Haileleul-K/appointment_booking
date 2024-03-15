import 'package:hive/hive.dart';

class HiveService {
  static const _boxName = 'user_data';

  // Save user ID 
  static Future<void> saveUser(String userId,String role) async {
    final box = await Hive.openBox<String>(_boxName);
    await box.put('userId', userId);
    await box.put('role', role);
    await box.close();
  }

  
  static Future<String?> getUserIdExist() async {
    final box = await Hive.openBox<String>(_boxName);
    final userId = box.get('userId');
    await box.close();
    return userId;
  }
   static Future<String?> getUserRole() async {
    final box = await Hive.openBox<String>(_boxName);
    final role = box.get('role');
    await box.close();
    return role;
  }


  static Future<void> deleteUser() async {
    final box = await Hive.openBox<String>(_boxName);
    await box.delete('userId');
    await box.delete('role');
    await box.close();
  }
}
