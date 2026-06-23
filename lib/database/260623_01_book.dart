class Book {
  // 定義欄位名稱
  static const String columnTitle = "title";
  static const String columnAuthor = "author";
  static const String columnPublisher = "publisher";
  static const String columnPrice = "price";

  // 定義欄位裡面值得型態
  final String title;
  final String author;
  final String publisher;
  final int price;

  // 建構式
  const Book({
    required this.title,
    required this.author,
    required this.publisher,
    required this.price,
  });

  // 轉換成 Map 格式
  Map<String, dynamic> toMap() {
    return {
      columnTitle: title,
      columnAuthor: author,
      columnPublisher: publisher,
      columnPrice: price,
    };
  }
}
