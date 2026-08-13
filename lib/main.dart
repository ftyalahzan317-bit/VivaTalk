
import 'package:flutter/material.dart';

void main() => runApp(const VivaTalkApp());

class VivaTalkApp extends StatelessWidget {
  const VivaTalkApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'VivaTalk',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF09090D),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFD51BFF),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;

  final pages = const [
    LiveFeedPage(),
    RoomsPage(),
    CreatePage(),
    NotificationsPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[index],
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        backgroundColor: const Color(0xFF101016),
        indicatorColor: const Color(0xFF7C18A8),
        onDestinationSelected: (i) => setState(() => index = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'الرئيسية'),
          NavigationDestination(icon: Icon(Icons.mic_none), selectedIcon: Icon(Icons.mic), label: 'غرف صوتية'),
          NavigationDestination(icon: Icon(Icons.add_circle_outline, size: 32), selectedIcon: Icon(Icons.add_circle, size: 32), label: 'إنشاء'),
          NavigationDestination(icon: Icon(Icons.notifications_none), selectedIcon: Icon(Icons.notifications), label: 'الإشعارات'),
          NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'حسابي'),
        ],
      ),
    );
  }
}

class LiveFeedPage extends StatelessWidget {
  const LiveFeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          PageView.builder(
            scrollDirection: Axis.vertical,
            itemCount: 6,
            itemBuilder: (_, i) => LiveCard(index: i),
          ),
          Positioned(
            top: 12, left: 16, right: 16,
            child: Row(
              children: [
                const Text('VivaTalk', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                const Spacer(),
                IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class LiveCard extends StatelessWidget {
  final int index;
  const LiveCard({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFF32133E).withOpacity(.95),
            const Color(0xFF0A0A0F),
          ],
        ),
      ),
      child: Stack(
        children: [
          const Center(
            child: Icon(Icons.videocam, size: 90, color: Colors.white24),
          ),
          Positioned(
            top: 62, left: 14,
            child: Chip(
              label: const Text('LIVE'),
              backgroundColor: Colors.red,
              labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          Positioned(
            left: 16, right: 85, bottom: 24,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('سارة', style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold)),
                const SizedBox(height: 6),
                const Text('مساء الخير للجميع ❤️', style: TextStyle(fontSize: 16)),
                const SizedBox(height: 10),
                Row(children: [
                  FilledButton.icon(
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LiveRoomPage())),
                    icon: const Icon(Icons.login),
                    label: const Text('دخول اللايف'),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.people_outline),
                  const SizedBox(width: 4),
                  const Text('2.4K'),
                ]),
              ],
            ),
          ),
          Positioned(
            right: 12, bottom: 25,
            child: Column(
              children: [
                ActionButton(icon: Icons.favorite, text: '12.4K'),
                ActionButton(icon: Icons.chat_bubble, text: '532'),
                ActionButton(icon: Icons.card_giftcard, text: '1.2K'),
                ActionButton(icon: Icons.share, text: '287'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  final IconData icon;
  final String text;
  const ActionButton({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 14),
    child: Column(children: [
      Icon(icon, size: 28),
      Text(text, style: const TextStyle(fontSize: 12)),
    ]),
  );
}

class RoomsPage extends StatelessWidget {
  const RoomsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final rooms = ['سهرة الأصدقاء', 'شعر وخواطر', 'قيمرز العرب', 'كفي ونقاش'];
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('غرف صوتية', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          for (final room in rooms)
            Card(
              child: ListTile(
                leading: const CircleAvatar(child: Icon(Icons.mic)),
                title: Text(room),
                subtitle: const Text('دردشة صوتية • 12 / 20'),
                trailing: FilledButton(
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const VoiceRoomPage())),
                  child: const Text('دخول'),
                ),
              ),
            ),
          const SizedBox(height: 12),
          FilledButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.add),
            label: const Text('إنشاء غرفة جديدة'),
          ),
        ],
      ),
    );
  }
}

class CreatePage extends StatelessWidget {
  const CreatePage({super.key});

  @override
  Widget build(BuildContext context) => SafeArea(
    child: ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text('إنشاء', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
        const SizedBox(height: 24),
        _CreateTile(icon: Icons.videocam, title: 'ابدأ لايف فيديو', onTap: () {}),
        _CreateTile(icon: Icons.mic, title: 'أنشئ غرفة صوتية', onTap: () {}),
        _CreateTile(icon: Icons.photo_camera, title: 'انشر محتوى', onTap: () {}),
      ],
    ),
  );
}

class _CreateTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  const _CreateTile({required this.icon, required this.title, required this.onTap});
  @override
  Widget build(BuildContext context) => Card(
    child: ListTile(
      contentPadding: const EdgeInsets.all(16),
      leading: Icon(icon, size: 34),
      title: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    ),
  );
}

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});
  @override
  Widget build(BuildContext context) => const SafeArea(
    child: Center(child: Text('الإشعارات', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold))),
  );
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) => SafeArea(
    child: ListView(
      padding: const EdgeInsets.all(20),
      children: const [
        CircleAvatar(radius: 48, child: Icon(Icons.person, size: 50)),
        SizedBox(height: 12),
        Center(child: Text('سارة', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
        SizedBox(height: 6),
        Center(child: Text('120 متابع • 15.6K متابعهم • 362K إعجاب')),
      ],
    ),
  );
}

class LiveRoomPage extends StatelessWidget {
  const LiveRoomPage({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('اللايف')),
    body: Stack(
      children: [
        const Center(child: Icon(Icons.videocam, size: 100, color: Colors.white24)),
        const Positioned(left: 16, bottom: 110, child: Text('سارة: أهلاً بالجميع ❤️', style: TextStyle(fontSize: 17))),
        Positioned(
          left: 12, right: 12, bottom: 20,
          child: Row(children: [
            const Expanded(child: TextField(decoration: InputDecoration(hintText: 'اكتب تعليقك...', filled: true))),
            IconButton(onPressed: () {}, icon: const Icon(Icons.card_giftcard)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.favorite)),
          ]),
        ),
      ],
    ),
  );
}

class VoiceRoomPage extends StatelessWidget {
  const VoiceRoomPage({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('سهرة الأصدقاء')),
    body: Column(
      children: [
        const SizedBox(height: 24),
        const Text('12 / 20 متحدث ومستمع', style: TextStyle(fontSize: 16)),
        const SizedBox(height: 20),
        Expanded(
          child: GridView.count(
            crossAxisCount: 4,
            padding: const EdgeInsets.all(16),
            children: List.generate(12, (i) => const Column(
              children: [
                CircleAvatar(radius: 27, child: Icon(Icons.person)),
                SizedBox(height: 5),
                Text('عضو'),
              ],
            )),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.mic_off, size: 30)),
              FloatingActionButton(onPressed: () {}, child: const Icon(Icons.mic)),
              IconButton(onPressed: () {}, icon: const Icon(Icons.card_giftcard, size: 30)),
              IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz, size: 30)),
            ],
          ),
        ),
      ],
    ),
  );
}
