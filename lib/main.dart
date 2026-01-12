import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:video_player/video_player.dart';
import 'dart:async';
import 'dart:math';

void main() => runApp(QuizQuikApp());

class QuizQuikApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(textTheme: GoogleFonts.poppinsTextTheme()),
      home: EarnPointsScreen(),
    );
  }
}

class VideoPlayerDialog extends StatefulWidget {
  final VoidCallback onFinished;
  VideoPlayerDialog({required this.onFinished});

  @override
  _VideoPlayerDialogState createState() => _VideoPlayerDialogState();
}

class _VideoPlayerDialogState extends State<VideoPlayerDialog> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    // Gunakan URL video contoh
    _controller =
        VideoPlayerController.networkUrl(
            Uri.parse(
              'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
            ),
          )
          ..initialize().then((_) {
            setState(() {});
            _controller.play();
          });

    _controller.addListener(() {
      if (_controller.value.position == _controller.value.duration) {
        widget.onFinished(); // Panggil fungsi selesai jika video habis
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.black,
      content: _controller.value.isInitialized
          ? AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            )
          : Container(
              height: 200,
              child: Center(child: CircularProgressIndicator()),
            ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text("Batal", style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}

class EarnPointsScreen extends StatefulWidget {
  @override
  _EarnPointsScreenState createState() => _EarnPointsScreenState();
}

class _EarnPointsScreenState extends State<EarnPointsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _totalPoints = 0; // Variabel penyimpan poin
  int _remainingSpins = 3;

  // Di dalam class _EarnPointsScreenState
  void _redeemPoints(int cost, String itemName) {
    if (_totalPoints >= cost) {
      setState(() {
        _totalPoints -= cost; // Kurangi poin
      });

      // Notifikasi Berhasil
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Berhasil menukar $itemName! Sisa poin: $_totalPoints"),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      // Notifikasi Gagal
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Poin tidak cukup untuk membeli $itemName!"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _updatePoints(int earned) {
    setState(() {
      _totalPoints += earned;
    });
    // Tampilkan notifikasi sukses
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Selamat! Kamu dapat $earned poin!"),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF3E5F5), // Light purple background
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Icon(Icons.arrow_back, color: Colors.white),
        title: Row(
          children: [
            Text(
              "Earn Points",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(), // Memberi jarak agar poin berada di kanan
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Icon(Icons.diamond, color: Colors.blueAccent, size: 20),
                  SizedBox(width: 5),
                  Text(
                    "$_totalPoints", // DI SINI VARIABEL DIGUNAKAN
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),

        flexibleSpace: Container(
          decoration: BoxDecoration(
            color: Color(0xFFB39DDB),
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          // Custom TabBar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              height: 45,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
              ),
              child: TabBar(
                controller: _tabController,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Color(0xFF9575CD),
                ),
                labelColor: Colors.white,
                unselectedLabelColor: Colors.black54,
                tabs: [
                  Tab(text: "Watch Video"),
                  Tab(text: "Spin & Win"),
                  Tab(text: "Shop & Earn"),
                ],
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                WatchVideoScreen(onVideoFinished: _updatePoints),
                SpinWheelScreen(
                  remainingSpins: _remainingSpins,
                  onUseSpin: () {
                    setState(() {
                      _remainingSpins--;
                    });
                  },
                  onSpinFinished: (points) {
                    _updatePoints(
                      points,
                    ); // Gunakan fungsi yang sama dengan video
                  },
                ),

                ShopEarnScreen(onRedeem: _redeemPoints),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// --- SCREEN 1: SHOP & EARN ---
class ShopEarnScreen extends StatelessWidget {
  final Function(int, String) onRedeem;

  ShopEarnScreen({required this.onRedeem});

  // UPDATE 1: Tambahkan path gambar ke dalam data produk
  final List<Map<String, dynamic>> products = [
    {
      "name": "Tommy Watch for Men",
      "price": "\$19.99",
      "points": 2800,
      "image":
          "assets/images/—Pngtree—a black and gold rolex_20925413.png", // Path gambar
    },
    {
      "name": "Man running shoe",
      "price": "\$19.99",
      "points": 600,
      "image": "assets/images/—Pngtree—sports shoes_15910407.png",
    },
    {
      "name": "Redwolf sleeve Jacket",
      "price": "\$19.99",
      "points": 2560,
      "image": "assets/images/pngimg.com - fur_coat_PNG12.png",
    },
    {
      "name": "Sleeve T-Shirt",
      "price": "\$19.99",
      "points": 2800,
      "image": "assets/images/pngimg.com - tshirt_PNG5437.png",
    },
    // Duplikasi data untuk mengisi grid (agar terlihat penuh seperti desain)
    {
      "name": "Redwolf sleeve Jacket",
      "price": "\$19.99",
      "points": 2560,
      "image": "assets/images/pngimg.com - fur_coat_PNG12.png",
    },
    {
      "name": "Sleeve T-Shirt",
      "price": "\$19.99",
      "points": 2800,
      "image": "assets/images/pngimg.com - tshirt_PNG5437.png",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(20),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return InkWell(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text("Konfirmasi Tukar"),
                content: Text(
                  "Tukar ${product['points']} poin untuk ${product['name']}?",
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text("Batal"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      onRedeem(product['points'], product['name']);
                    },
                    child: Text("Tukar"),
                  ),
                ],
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // UPDATE 2: Ganti Icon dengan Image.asset
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(
                      15.0,
                    ), // Padding agar gambar tidak terlalu mepet
                    child: Center(
                      child: Image.asset(
                        product['image'], // Memanggil file dari assets
                        fit: BoxFit.contain, // Agar gambar pas di dalam kotak
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product['name'],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 5),
                      // Menambahkan Rating Star (Hardcoded sesuai desain)
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.amber, size: 12),
                          Text(
                            " 4.8 (452)",
                            style: TextStyle(fontSize: 10, color: Colors.grey),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            product['price'],
                            style: TextStyle(
                              color: Colors.deepPurple,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(Icons.diamond, color: Colors.blue, size: 14),
                              Text(
                                " ${product['points']}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// --- SCREEN 2: SPIN & WIN ---
class SpinWheelScreen extends StatefulWidget {
  final Function(int) onSpinFinished;
  final int remainingSpins;
  final Function() onUseSpin;

  SpinWheelScreen({
    required this.onSpinFinished,
    required this.remainingSpins,
    required this.onUseSpin,
  });

  @override
  _SpinWheelScreenState createState() => _SpinWheelScreenState();
}

class _SpinWheelScreenState extends State<SpinWheelScreen> {
  // Controller untuk menggerakkan roda
  StreamController<int> selected = StreamController<int>();

  // Nilai pada roda sesuai urutan di gambar
  final List<int> items = [100, 50, 60, 10, 40, 80, 20, 100, 40, 20, 100, 50];

  bool isSpinning = false;

  @override
  void dispose() {
    selected.close();
    super.dispose();
  }

  void _startSpin() {
    if (widget.remainingSpins > 0 && !isSpinning) {
      setState(() {
        isSpinning = true;
      });

      // Pilih index secara acak
      int nextIndex = Random().nextInt(items.length);
      selected.add(nextIndex);

      // Kurangi jatah spin di state utama
      widget.onUseSpin();

      // Tunggu animasi putaran selesai (default flutter_fortune_wheel sekitar 4-5 detik)
      Future.delayed(Duration(seconds: 5), () {
        int pointGained = items[nextIndex];
        widget.onSpinFinished(pointGained);
        setState(() {
          isSpinning = false;
        });
      });
    } else if (widget.remainingSpins <= 0) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Jatah spin harian sudah habis!")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 30),
        Text(
          "Spin the Wheel",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF673AB7),
          ),
        ),
        Text(
          "Add more points to your wallet",
          style: TextStyle(color: Colors.grey),
        ),
        SizedBox(height: 10),

        // Indikator Sisa Spin
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.orangeAccent,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Text(
            "Daily spin remaining: ${widget.remainingSpins}",
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),

        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Stack(
              alignment: Alignment.center,
              children: [
                FortuneWheel(
                  selected: selected.stream,
                  animateFirst: false,
                  items: [
                    for (var value in items)
                      FortuneItem(
                        child: Text(
                          value.toString(),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        style: FortuneItemStyle(
                          color: items.indexOf(value) % 2 == 0
                              ? Color(0xFF9575CD)
                              : Color(0xFFD1C4E9),
                          borderColor: Colors.white,
                          borderWidth: 2,
                        ),
                      ),
                  ],
                ),
                // Tombol di tengah roda (seperti di desain)
                GestureDetector(
                  onTap: _startSpin,
                  child: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 4),
                      boxShadow: [
                        BoxShadow(color: Colors.black26, blurRadius: 10),
                      ],
                    ),
                    child: Icon(
                      isSpinning ? Icons.autorenew : Icons.play_arrow,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Tombol Tambahan di Bawah
        Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: ElevatedButton(
            onPressed: isSpinning ? null : _startSpin,
            child: Text(isSpinning ? "Spinning..." : "SPIN NOW"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF9575CD),
              padding: EdgeInsets.symmetric(horizontal: 60, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// --- SCREEN 3: WATCH VIDEO ---
class WatchVideoScreen extends StatelessWidget {
  final Function(int) onVideoFinished; // Callback untuk tambah poin

  WatchVideoScreen({required this.onVideoFinished});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Watch Videos",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF673AB7),
          ),
        ),
        Text(
          "Add more points to your wallet",
          style: TextStyle(color: Colors.grey),
        ),
        SizedBox(height: 40),
        // Ilustrasi Tombol Play
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.purple.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
            ),
            Icon(Icons.play_circle_fill, size: 100, color: Colors.deepPurple),
          ],
        ),
        SizedBox(height: 40),
        ElevatedButton.icon(
          onPressed: () {
            // Tampilkan Dialog Video saat diklik
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => VideoPlayerDialog(
                onFinished: () {
                  Navigator.pop(context); // Tutup video
                  onVideoFinished(100); // Beri 100 poin
                },
              ),
            );
          },
          icon: Icon(Icons.video_library),
          label: Text("Watch Now"),
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF9575CD),
            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
      ],
    );
  }
}
