import 'package:flutter/material.dart';

void main() =>
    runApp(MaterialApp(debugShowCheckedModeBanner: false, home: LibraryHome()));

// --- الشاشة الأولى: واجهة المكتبة ---
class LibraryHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Digital Library")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.book, size: 100, color: Colors.brown),
            SizedBox(height: 20),
            Text("Welcome to My Library", style: TextStyle(fontSize: 20)),
            SizedBox(height: 30),
            ElevatedButton(
              child: Text("View Books List"),
              onPressed: () {
                // المطلب الأول: انتقال بسيط للقائمة
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BooksList()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// --- الشاشة الثانية: قائمة الكتب ---
class BooksList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Available Books")),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.library_books),
            title: Text("Flutter Programming Guide"),
            subtitle: Text("Click to read details"),
            onTap: () async {
              // المطلب الثاني: إرسال اسم الكتاب وانتظار النتيجة (await)
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      BookDetail(bookTitle: "Flutter Programming Guide"),
                ),
              );

              // عرض النتيجة العائدة من الشاشة الثالثة في SnackBar
              if (result != null) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(result)));
              }
            },
          ),
        ],
      ),
    );
  }
}

// --- الشاشة الثالثة: تفاصيل الكتاب ---
class BookDetail extends StatelessWidget {
  final String bookTitle; // استقبال البيانات عبر الـ Constructor
  BookDetail({required this.bookTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Book Details")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Book: $bookTitle",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Text("Would you like to borrow this book for 7 days?"),
              SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                onPressed: () {
                  // إرجاع قيمة نصية عند العودة (النجاح في الاستعارة)
                  Navigator.pop(
                    context,
                    "You borrowed '$bookTitle' successfully!",
                  );
                },
                child: Text("Borrow Now"),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context), // عودة بدون بيانات
                child: Text("Cancel"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
