import 'package:flutter/cupertino.dart';

extension SizedBoxExtension on num {
  SizedBox get verticalSpace => SizedBox(height: double.parse(this.toString()));
  SizedBox get horizontalSpace =>
      SizedBox(width: double.parse(this.toString()));
}
