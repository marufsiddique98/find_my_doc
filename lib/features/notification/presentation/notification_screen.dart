import 'dart:math';

import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';

import '../../../config/constants/app_colors.dart';
import '../../../core/common/widgets/my_app_bar.dart';

List _elements = [
  {'name': 'John', 'group': 'Today'},
  {'name': 'Will', 'group': 'Yesterday'},
  {'name': 'Beth', 'group': 'This Weekend'},
  {'name': 'Miranda', 'group': 'This Weekend'},
  {'name': 'Mike', 'group': 'This Weekend'},
  {'name': 'Danny', 'group': 'This Weekend'},
  {'name': 'Danny', 'group': 'This Weekend'},
  {'name': 'Danny', 'group': 'This Weekend'},
  {'name': 'Danny', 'group': 'This Weekend'},
  {'name': 'Danny', 'group': 'This Weekend'},
];

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Notification'),
      body: GroupedListView<dynamic, String>(
        elements: _elements,
        groupBy: (element) => element['group'],
        groupComparator: (value1, value2) => value2.compareTo(value1),
        itemComparator: (item1, item2) => item1['name'].compareTo(item2['name']),
        order: GroupedListOrder.ASC,
        useStickyGroupSeparators: true,
        groupSeparatorBuilder: (String value) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
          child: Text(
            value,
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.grayColor1E,
            ),
          ),
        ),
        itemBuilder: (c, element) {
          return ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
            leading: CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(
                'https://s3-alpha-sig.figma.com/img/8d53/ab37/17fe089b7861faeb1a0410ba4b759dd3?Expires=1736726400&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=cXUfJo5ujNqcgTqCZzy8-Sw~mQQ28AYu2~1L7~PLyV-YcaCOCw5ftL6IeLw~JbvKDN-RWZp3VDyivgJcg7zA-r6K30RSEIXjJQOhYmD~fkm8KNf5sJ3UrxeVAWJ9LUsa~Wnm47Ighxz8apkRtAn7WFUnthzMCTkhJ0b2IYVphzUfa3aWHPWQcAPAuhO5Mfxdi0R4tgFv9NxplUEq4fFOzNu3Uqnb9jtSm5HFRhxjShtCl5JyGNk5qPH2JqvPlPBfZdyHgPx-uyKH336JYJHe6k5~E7by0tRawfVl~XqiXIOiKHcVAhiizPJDwbYURLyNsTY~ac9XcpfRwNIO34d85Q__',
              ),
            ),
            title: Text(
              element['name'],
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.grayColor1E,
              ),
            ),
            subtitle: Text(
              element['name'],
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.grayColorA7,
              ),
            ),
            trailing: Transform.rotate(
              angle: 3 * pi / 2,
              child: const Icon(
                Icons.arrow_drop_down_sharp,
              ),
            ),
          );
        },
      ),
    );
  }
}
