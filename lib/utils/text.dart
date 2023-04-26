class TextUtil {
  static String ellipse(String text, {int length = 50}) {
    if (text.length <= 20) {
      return text;
    }
    return '${text.substring(0, length)}...';
  }
}
