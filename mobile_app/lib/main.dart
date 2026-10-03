import 'package:flutter/material.dart';

void main() {
  runApp(const DisasterResponseApp());
}

class DisasterResponseApp extends StatelessWidget {
  const DisasterResponseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Disaster Response',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF080B11),
        fontFamily: 'Arial',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFF5538),
          brightness: Brightness.dark,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedTab = 0;
  bool simulationRunning = false;

  void runSimulation() {
    setState(() {
      simulationRunning = true;
    });

    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;

      setState(() {
        simulationRunning = false;
      });

      showModalBottomSheet(
        context: context,
        backgroundColor: const Color(0xFF121722),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(28),
          ),
        ),
        builder: (context) {
          return const SimulationResult();
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: selectedTab,
          children: [
            buildHome(),
            buildMapScreen(),
            buildCascadeScreen(),
            buildPlansScreen(),
          ],
        ),
      ),
      bottomNavigationBar: buildBottomNav(),
    );
  }

  Widget buildHome() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildHeader(),
          const SizedBox(height: 24),

          const Text(
            'LIVE SITUATION',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.2,
              color: Colors.white70,
            ),
          ),

          const SizedBox(height: 10),

          buildEmergencyCard(),

          const SizedBox(height: 14),

          buildMapCard(),

          const SizedBox(height: 14),

          buildCascadeCard(),

          const SizedBox(height: 14),

          buildStats(),

          const SizedBox(height: 18),

          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton.icon(
              onPressed: simulationRunning ? null : runSimulation,
              icon: simulationRunning
                  ? const SizedBox(
                      width: 19,
                      height: 19,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Icon(Icons.auto_awesome),
              label: Text(
                simulationRunning
                    ? 'ANALYZING IMPACT...'
                    : 'RUN WHAT-IF SIMULATION',
                style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  letterSpacing: .3,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF5538),
                foregroundColor: Colors.white,
                disabledBackgroundColor: const Color(0xFF7A3025),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildHeader() {
    return Row(
      children: [
        Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            color: const Color(0xFFFF5538),
            borderRadius: BorderRadius.circular(15),
          ),
          child: const Icon(
            Icons.shield_rounded,
            color: Colors.white,
            size: 25,
          ),
        ),
        const SizedBox(width: 12),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'DISASTER RESPONSE',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  letterSpacing: .4,
                ),
              ),
              SizedBox(height: 3),
              Text(
                'Intelligence Center',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white54,
                ),
              ),
            ],
          ),
        ),
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: const Color(0xFF141A25),
            borderRadius: BorderRadius.circular(14),
          ),
          child: const Icon(
            Icons.notifications_none_rounded,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget buildEmergencyCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF241A1A),
            Color(0xFF161820),
          ],
        ),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: const Color(0xFFFF5538).withOpacity(.35),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 9,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFFF5538).withOpacity(.14),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  '●  ACTIVE RESPONSE',
                  style: TextStyle(
                    color: Color(0xFFFF6A52),
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              const Spacer(),
              const Text(
                'MUMBAI',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  color: Colors.white54,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          const Text(
            '3 active incidents',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 5),
          const Text(
            '1 critical  •  2 high priority',
            style: TextStyle(
              color: Colors.white54,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(
                Icons.warning_amber_rounded,
                color: Color(0xFFFF5538),
                size: 18,
              ),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  'Andheri Building Collapse',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text('VIEW'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildMapCard() {
    return Container(
      height: 225,
      decoration: BoxDecoration(
        color: const Color(0xFF10151E),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: Colors.white.withOpacity(.05),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          CustomPaint(
            size: Size.infinite,
            painter: MapPainter(),
          ),

          Positioned(
            left: 14,
            top: 14,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 11,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFF090D14).withOpacity(.9),
                borderRadius: BorderRadius.circular(11),
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.location_on,
                    color: Color(0xFFFF5538),
                    size: 16,
                  ),
                  SizedBox(width: 6),
                  Text(
                    'Mumbai Response Grid',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const Positioned(
            left: 48,
            top: 83,
            child: MapPin(
              label: 'A',
              color: Color(0xFFFF4538),
            ),
          ),

          const Positioned(
            right: 78,
            top: 102,
            child: MapPin(
              label: 'K',
              color: Color(0xFFFF9D2E),
            ),
          ),

          const Positioned(
            right: 38,
            top: 135,
            child: MapPin(
              label: 'B',
              color: Color(0xFFFF4538),
            ),
          ),

          Positioned(
            right: 14,
            bottom: 14,
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  selectedTab = 1;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF5538),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 17,
                  vertical: 11,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(13),
                ),
              ),
              child: const Text(
                'OPEN MAP',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCascadeCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF10151E),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: const Color(0xFFFF5538).withOpacity(.16),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: const Color(0xFFFF5538).withOpacity(.13),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.auto_awesome,
                  color: Color(0xFFFF704F),
                  size: 18,
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                'AI CASCADE PREDICTION',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 13,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          const Text(
            'R17 road disruption detected',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w800,
            ),
          ),

          const SizedBox(height: 16),

          const CascadeRow(
            icon: Icons.route_rounded,
            title: 'Ambulance travel time',
            value: '+18 min',
          ),

          const SizedBox(height: 12),

          const CascadeRow(
            icon: Icons.local_hospital_rounded,
            title: 'Hospital pressure',
            value: 'HIGH',
          ),

          const SizedBox(height: 12),

          const CascadeRow(
            icon: Icons.water_drop_rounded,
            title: 'Oxygen demand',
            value: '+24%',
          ),

          const SizedBox(height: 15),

          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFFF5538).withOpacity(.07),
              borderRadius: BorderRadius.circular(13),
            ),
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.info_outline_rounded,
                  color: Color(0xFFFF704F),
                  size: 17,
                ),
                SizedBox(width: 9),
                Expanded(
                  child: Text(
                    'AI predicts increased hospital pressure if the disruption continues.',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildStats() {
    return Row(
      children: [
        Expanded(
          child: StatCard(
            value: '10',
            label: 'Ambulances',
            icon: Icons.emergency,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: StatCard(
            value: '03',
            label: 'Hospitals',
            icon: Icons.local_hospital,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: StatCard(
            value: '05',
            label: 'Relief Hubs',
            icon: Icons.home_work_rounded,
          ),
        ),
      ],
    );
  }

  Widget buildMapScreen() {
    return const Center(
      child: Text(
        'LIVE RESPONSE MAP',
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }

  Widget buildCascadeScreen() {
    return const Center(
      child: Text(
        'CASCADE INTELLIGENCE',
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }

  Widget buildPlansScreen() {
    return Padding(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          const Text(
            'RESPONSE PLANS',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'AI-generated response strategies',
            style: TextStyle(
              color: Colors.white54,
            ),
          ),
          const SizedBox(height: 24),
          planCard(
            'Plan A',
            'Fastest Response',
            'Minimize emergency travel time',
            Icons.bolt_rounded,
          ),
          planCard(
            'Plan B',
            'Balanced Response',
            'Distribute resources efficiently',
            Icons.balance_rounded,
          ),
          planCard(
            'Plan C',
            'Resilient Response',
            'Prepare for another disruption',
            Icons.shield_rounded,
          ),
        ],
      ),
    );
  }

  Widget planCard(
    String tag,
    String title,
    String subtitle,
    IconData icon,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: const Color(0xFF10151E),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.white.withOpacity(.06),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: const Color(0xFFFF5538).withOpacity(.12),
              borderRadius: BorderRadius.circular(13),
            ),
            child: Icon(
              icon,
              color: const Color(0xFFFF704F),
            ),
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tag,
                  style: const TextStyle(
                    color: Color(0xFFFF704F),
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.white54,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.chevron_right_rounded,
            color: Colors.white38,
          ),
        ],
      ),
    );
  }

  Widget buildBottomNav() {
    return NavigationBar(
      backgroundColor: const Color(0xFF0C1017),
      indicatorColor: const Color(0xFFFF5538).withOpacity(.14),
      selectedIndex: selectedTab,
      onDestinationSelected: (index) {
        setState(() {
          selectedTab = index;
        });
      },
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home_rounded),
          label: 'Home',
        ),
        NavigationDestination(
          icon: Icon(Icons.map_outlined),
          selectedIcon: Icon(Icons.map_rounded),
          label: 'Map',
        ),
        NavigationDestination(
          icon: Icon(Icons.auto_awesome_outlined),
          selectedIcon: Icon(Icons.auto_awesome),
          label: 'Impact',
        ),
        NavigationDestination(
          icon: Icon(Icons.assignment_outlined),
          selectedIcon: Icon(Icons.assignment_rounded),
          label: 'Plans',
        ),
      ],
    );
  }
}

class StatCard extends StatelessWidget {
  final String value;
  final String label;
  final IconData icon;

  const StatCard({
    super.key,
    required this.value,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 14,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF10151E),
        borderRadius: BorderRadius.circular(17),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 18,
            color: const Color(0xFFFF704F),
          ),
          const SizedBox(height: 7),
          Text(
            value,
            style: const TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white54,
              fontSize: 9,
            ),
          ),
        ],
      ),
    );
  }
}

class CascadeRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const CascadeRow({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 18,
          color: Colors.white38,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white60,
              fontSize: 12,
            ),
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            color: Color(0xFFFF704F),
            fontWeight: FontWeight.w900,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

class MapPin extends StatelessWidget {
  final String label;
  final Color color;

  const MapPin({
    super.key,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(.35),
            blurRadius: 14,
          ),
        ],
      ),
      child: Center(
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}

class SimulationResult extends StatelessWidget {
  const SimulationResult({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(
                  Icons.auto_awesome,
                  color: Color(0xFFFF704F),
                ),
                SizedBox(width: 9),
                Text(
                  'WHAT-IF RESULT',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            const Text(
              'R17 remains blocked',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Predicted cascade impact',
              style: TextStyle(
                color: Colors.white54,
              ),
            ),
            const SizedBox(height: 18),
            resultRow('Ambulance delay', '+18 min'),
            resultRow('Hospital pressure', 'HIGH'),
            resultRow('Oxygen demand', '+24%'),
            resultRow('Secondary risk', 'MEDIUM'),
            const SizedBox(height: 18),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF5538),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Text(
                  'VIEW RESPONSE PLANS',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget resultRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white70,
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Color(0xFFFF704F),
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}

class MapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final roadPaint = Paint()
      ..color = const Color(0xFF29303B)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final thinRoadPaint = Paint()
      ..color = const Color(0xFF1D242E)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    final path1 = Path()
      ..moveTo(-20, size.height * .30)
      ..quadraticBezierTo(
        size.width * .35,
        size.height * .18,
        size.width + 20,
        size.height * .32,
      );

    final path2 = Path()
      ..moveTo(size.width * .30, -20)
      ..quadraticBezierTo(
        size.width * .52,
        size.height * .40,
        size.width * .42,
        size.height + 20,
      );

    final path3 = Path()
      ..moveTo(-20, size.height * .65)
      ..quadraticBezierTo(
        size.width * .55,
        size.height * .52,
        size.width + 20,
        size.height * .70,
      );

    canvas.drawPath(path1, roadPaint);
    canvas.drawPath(path2, roadPaint);
    canvas.drawPath(path3, thinRoadPaint);

    for (int i = 1; i < 5; i++) {
      final y = size.height * (i / 6);

      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y + 15),
        thinRoadPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}