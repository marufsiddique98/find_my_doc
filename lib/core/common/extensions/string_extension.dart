extension StringExtension on String {
  String capitalize() {
    if (isEmpty) {
      return this;
    }
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }

  String capitalizeEachWord() {
    return split(' ').map((word) => word.capitalize()).join(' ');
  }
}
