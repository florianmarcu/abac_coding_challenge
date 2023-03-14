import 'package:abac_coding_challenge/models/models.dart';

class Order{
  List<PartOrderItem> parts;
  Station station;
  DateTime date;

  Order({required this.parts, required this.station, required this.date});
}