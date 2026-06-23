import 'package:flutter/material.dart';

import 'database/260623_01_book.dart';
import 'database/260623_02_bookDBHelper.dart';

void main() {
  runApp(const MyApp());
}

// StatelessWidget 不會變更的 UI
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 外框
    return MaterialApp(
      title: '資料庫範例 DB SQLite',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: '資料庫範例 DB SQLite'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();
  final TextEditingController _publisherController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  final BookDbHelper _dbHelper = BookDbHelper.instance;

  final ValueNotifier<List<Book>> _booksNotifier = ValueNotifier<List<Book>>(
    <Book>[],
  );

  @override
  void initState() {
    super.initState();
    _loadAllBooks();
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _authorController.dispose();
    _publisherController.dispose();
    _priceController.dispose();

    _dbHelper.closeDatabase();

    _booksNotifier.dispose();
  }

  Future<void> _loadAllBooks() async {
    final List<Book> books = await _dbHelper.getAllBooks();

    if (!mounted) return;

    _booksNotifier.value = books;
  }

  Future<void> _insertBook() async {
    final String title = _titleController.text.trim();
    final String author = _authorController.text.trim();
    final String publisher = _publisherController.text.trim();
    final int? price = int.tryParse(_priceController.text.trim());

    if (title.isEmpty || author.isEmpty || publisher.isEmpty || price == null) {
      _showMessage("請完整輸入書名、作者、出版社與正確售價");
      return;
    }

    final Book book = Book(
      title: title,
      author: author,
      publisher: publisher,
      price: price,
    );

    await _dbHelper.insertBook(book);
    await _loadAllBooks();

    _clearInputs();
    _showMessage("已成功加入書籍!");
  }

  Future<void> _queryBooks() async {
    final String keyword = _titleController.text.trim();
    final List<Book> books = await _dbHelper.queryBooksByTitle(keyword);

    if (books.isEmpty) {
      _booksNotifier.value = await _dbHelper.getAllBooks();
      return;
    }

    _booksNotifier.value = books;
  }

  Future<void> _deleteBook() async {
    final String title = _titleController.text.trim();

    if (title.isEmpty) {
      _showMessage("請輸入要刪除的書名");
      return;
    }

    await _dbHelper.deleteBookByTitle(title);
    await _loadAllBooks();

    _clearInputs();
    _showMessage("已刪除書籍：$title!");
  }

  void _clearInputs() {
    _titleController.clear();
    _authorController.clear();
    _publisherController.clear();
    _priceController.clear();
  }

  void _showMessage(String msg) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    // final Widget body = Padding(
    //   padding: const EdgeInsets.all(20),
    //   child: Column(
    //     children: <Widget>[
    //       _buildTextField(controller: _titleController, labelText: '書名'),
    //       _buildTextField(controller: _authorController, labelText: '作者'),
    //       _buildTextField(controller: _publisherController, labelText: '出版社'),
    //       _buildTextField(
    //         controller: _priceController,
    //         labelText: '價格',
    //         keyboardType: TextInputType.number,
    //       ),
    //       const SizedBox(height: 12),
    //       _buildButtonPanel(),
    //       const SizedBox(height: 12),
    //       Expanded(
    //         child: ValueListenableBuilder(
    //           valueListenable: _booksNotifier,
    //           builder: _bookListBuilder,
    //         ),
    //       ),
    //     ],
    //   ),
    // );
    final Widget body = Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        // 👈 關鍵修改 1：最外層改用 Row 達成橫向排列
        crossAxisAlignment: CrossAxisAlignment.start, // 讓左右兩列對齊頂部
        children: <Widget>[
          // ================= 左半邊：輸入表單與按鈕 =================
          Expanded(
            flex: 1, // 可以透過 flex 調整比例，1 代表左右等寬
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _buildTextField(controller: _titleController, labelText: '書名'),
                _buildTextField(controller: _authorController, labelText: '作者'),
                _buildTextField(
                  controller: _publisherController,
                  labelText: '出版社',
                ),
                _buildTextField(
                  controller: _priceController,
                  labelText: '價格',
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 5),
                _buildButtonPanel(), // 按鈕面板放在表單下方
              ],
            ),
          ),

          const SizedBox(width: 10), // 👈 關鍵修改 2：左右兩列中間的間距
          // ================= 右半邊：書籍列表 =================
          Expanded(
            flex: 1, // 保持與左邊 1:1 的寬度
            child: Column(
              children: [
                // 如果右邊只需要放列表，必須保留 Expanded 讓 ListView 有無限延伸的空間
                Expanded(
                  child: ValueListenableBuilder(
                    valueListenable: _booksNotifier,
                    builder: _bookListBuilder,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: body,
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    TextInputType? keyboardType,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        style: const TextStyle(fontSize: 15),
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: const TextStyle(fontSize: 15),
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _buildButtonPanel() {
    return Row(
      children: <Widget>[
        Expanded(
          child: _buildActionButton(text: "加入", onPressed: _insertBook),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _buildActionButton(text: "查詢", onPressed: _queryBooks),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _buildActionButton(text: "刪除", onPressed: _deleteBook),
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required String text,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.amber,
        foregroundColor: Colors.pinkAccent,
        padding: const EdgeInsets.symmetric(vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        elevation: 8,
      ),
      child: Text(text, style: const TextStyle(fontSize: 18)),
    );
  }

  Widget _bookListBuilder(
    BuildContext context,
    List<Book> books,
    Widget? child,
  ) {
    if (books.isEmpty) {
      return const Center(
        child: Text("目前沒有任何書籍資料", style: TextStyle(fontSize: 20)),
      );
    }

    return ListView.separated(
      itemBuilder: (context, index) {
        final Book book = books[index];
        return ListTile(
          title: Text(book.title, style: const TextStyle(fontSize: 20)),
          subtitle: Text(
            '作者：${book.author}\n出版社：${book.publisher}\n售價：${book.price}',
            style: const TextStyle(fontSize: 16),
          ),
        );
      },
      separatorBuilder: (context, index) => const Divider(),
      itemCount: books.length,
    );
  }
}
