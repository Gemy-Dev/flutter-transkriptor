import 'package:intl/intl.dart';

extension OnTime on DateTime{

    String get formattedDate => DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
}