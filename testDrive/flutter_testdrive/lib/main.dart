import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Night Out',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF00C5D7),
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: const Color(0xFF07131A),
        useMaterial3: true,
      ),
      home: const EventPage(),
    );
  }
}

class EventPage extends StatefulWidget {
  const EventPage({super.key});

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  bool _isFavorite = false;
  String _selectedDrink = 'Cocktails';
  final Map<String, List<String>> _drinksByCategory = {
    'Beer': ['Light Lager', 'IPA', 'Draft Pilsner'],
    'Cocktails': ['Margarita', 'Mojito', 'Old Fashioned'],
    'Shots': ['Tequila', 'Lemon Drop', 'Green Tea'],
    'Non-alcoholic': ['Lemonade', 'Soda', 'Mocktail of the Day'],
  };

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHero(),
              const SizedBox(height: 18),
              const Row(
                children: [
                  Expanded(child: _QuickStat(label: 'VIBE', value: 'Buzzing')),
                  SizedBox(width: 12),
                  Expanded(child: _QuickStat(label: 'UBER THERE', value: '5–6 min')),
                ],
              ),
              const SizedBox(height: 14),
              const Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _Tag(icon: Icons.people_alt_outlined, label: 'No Line'),
                  _Tag(icon: Icons.confirmation_number_outlined, label: 'Free Entry'),
                ],
              ),
              const SizedBox(height: 16),
              _buildHostCard(),
              const SizedBox(height: 14),
              _buildInfoCard(),
              const SizedBox(height: 22),
              const Text(
                'Drink Menu',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                children: ['Beer', 'Cocktails', 'Shots', 'Non-alcoholic']
                    .map(
                      (drink) => ChoiceChip(
                        label: Text(drink),
                        selected: _selectedDrink == drink,
                        onSelected: (_) => setState(() => _selectedDrink = drink),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 14),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start, children: (_drinksByCategory[_selectedDrink] ?? []).map((drink) => ListTile(contentPadding: EdgeInsets.zero,title: Text(drink),)).toList(),),
              const SizedBox(height: 22),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () => _showMessage('Safe ride options are coming up.'),
                  icon: const Icon(Icons.shield_outlined),
                  label: const Text('Find a Safe Ride'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF21D889),
                    side: const BorderSide(color: Color(0xFF21D889)),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildHero() {
    return Container(
      height: 240,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: const LinearGradient(
          colors: [Color(0xFF064A58), Color(0xFF102044), Color(0xFF101522)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: [
          const Positioned(
            right: 22,
            top: 48,
            child: Icon(Icons.graphic_eq, size: 92, color: Color(0x5579E8EE)),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      tooltip: 'Go back',
                      onPressed: () => _showMessage('Event details'),
                      icon: const Icon(Icons.arrow_back),
                    ),
                    IconButton(
                      tooltip: _isFavorite ? 'Remove favorite' : 'Add favorite',
                      onPressed: () => setState(() => _isFavorite = !_isFavorite),
                      icon: Icon(
                        _isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: _isFavorite ? Colors.pinkAccent : Colors.white,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                const Wrap(
                  spacing: 8,
                  children: [
                    _Tag(icon: Icons.star_border, label: 'Event Tonight'),
                    _Tag(icon: Icons.local_bar_outlined, label: 'Happy Hour'),
                  ],
                ),
                const SizedBox(height: 10),
                const Text(
                  "Art Bar's",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 4),
                const Text(
                  '1211 Park St, Columbia, SC 29201',
                  style: TextStyle(color: Color(0xFFD2E5EB), fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHostCard() {
    return _Panel(
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.music_note, color: Color(0xFF00C5D7), size: 28),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('DJ Smooth', style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 3),
                    Text(
                      'Top 40 / Hip-Hop · @djsmooth_cola',
                      style: TextStyle(color: Color(0xFF9BB1BC), fontSize: 12),
                    ),
                  ],
                ),
              ),
              const _Tag(icon: Icons.circle, label: 'LIVE'),
            ],
          ),
          const Divider(height: 24),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Set time', style: TextStyle(color: Color(0xFF9BB1BC))),
              Text('10pm – 2am', style: TextStyle(fontWeight: FontWeight.w600)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard() {
    return const _Panel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'INFO',
                style: TextStyle(
                  color: Color(0xFF9BB1BC),
                  letterSpacing: 2,
                  fontSize: 12,
                ),
              ),
              Text('★★★★★  4.5', style: TextStyle(color: Color(0xFFFFA23A))),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: _InfoField(label: 'Hours', value: '11am – 2am')),
              Expanded(child: _InfoField(label: 'Vibe', value: 'Classic Dive Bar')),
            ],
          ),
          SizedBox(height: 14),
          Row(
            children: [
              Expanded(child: _InfoField(label: 'Distance', value: '0.2 Mi Away')),
              Expanded(child: _InfoField(label: 'Check-ins', value: '22 On BarCast')),
            ],
          ),
        ],
      ),
    );
  }
}

class _Panel extends StatelessWidget {
  const _Panel({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF0C202A),
        border: Border.all(color: const Color(0xFF174253)),
        borderRadius: BorderRadius.circular(15),
      ),
      child: child,
    );
  }
}

class _QuickStat extends StatelessWidget {
  const _QuickStat({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return _Panel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFF7895A3),
              fontSize: 10,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 8),
          Text(value, style: const TextStyle(color: Color(0xFF00C5D7))),
        ],
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  const _Tag({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: const Color(0x3321D889),
        border: Border.all(color: const Color(0x8821D889)),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 13, color: const Color(0xFF21D889)),
            const SizedBox(width: 5),
            Text(
              label,
              style: const TextStyle(color: Color(0xFF21D889), fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoField extends StatelessWidget {
  const _InfoField({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Color(0xFF7895A3), fontSize: 11)),
        const SizedBox(height: 5),
        Text(value, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
      ],
    );
  }
}
