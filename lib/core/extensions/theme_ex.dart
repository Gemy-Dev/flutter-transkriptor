import 'package:flutter/material.dart';

extension UpdateThem on BuildContext{
 TextStyle? get largTitle=>Theme.of(this).textTheme.titleLarge;
 TextStyle? get titleMedium=>Theme.of(this).textTheme.titleMedium;
 TextStyle? get titleSmall=>Theme.of(this).textTheme.titleSmall;
 TextStyle? get bodyLarge=>Theme.of(this).textTheme.bodyLarge;
 TextStyle? get bodyMedium=>Theme.of(this).textTheme.bodyMedium;
 TextStyle? get bodySmall=>Theme.of(this).textTheme.bodySmall;
}