import 'package:flutter/material.dart';
import 'package:ecommerce_app/src/controllers/user_controller.dart';
import '../../../../models/user_model.dart';
import 'edit_profile_screen.dart';
import '../../auth_screen/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Configuración de colores
  final Color accentColor = const Color(0xFFFF9500);
  final Color bgColor = const Color(0xFFFBFBFF);

  // Instancia del controlador
  final UserController _userController = UserController();

  // Variable para el stream
  late Stream<UserModel> _userStream;

  @override
  void initState() {
    super.initState();
    _userStream = _userController.getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: StreamBuilder<UserModel>(
        stream: _userStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Color(0xFFFF9500)));
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error loading profile: ${snapshot.error}"));
          }

          if (!snapshot.hasData) {
            return const Center(child: Text("User information not found"));
          }

          final user = snapshot.data!;

          return SingleChildScrollView(
            child: Column(
              children: [
                _buildHeader(context, user),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      const SizedBox(height: 25),
                      // Tarjeta modificada (ahora es Coupons)
                      _buildLoyaltyCard(),

                      // Se eliminó _buildQuickActions() aquí

                      const SizedBox(height: 30),
                      _buildMenuSection(context, user),
                      const SizedBox(height: 40),
                      _buildLogoutButton(context),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader(BuildContext context, UserModel user) {
    return Container(
      height: 280,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(40)),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 20, offset: const Offset(0, 10))
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 40),
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: accentColor, width: 2)
                ),
                child: CircleAvatar(
                  radius: 55,
                  backgroundColor: Colors.grey.shade100,
                  backgroundImage: user.profileImageUrl.isNotEmpty
                      ? NetworkImage(user.profileImageUrl)
                      : null,
                  child: user.profileImageUrl.isEmpty
                      ? Icon(Icons.person, size: 55, color: Colors.grey.shade400)
                      : null,
                ),
              ),
              CircleAvatar(
                radius: 18,
                backgroundColor: accentColor,
                child: const Icon(Icons.star, color: Colors.white, size: 18),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Text(
            user.fullName.isNotEmpty ? user.fullName : "User",
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w800, letterSpacing: -0.5),
          ),
          Text(
            _userController.auth.currentUser?.email ?? "No email registered",
            style: const TextStyle(color: Colors.grey, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildLoyaltyCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [accentColor, const Color(0xFFFFB74D)]),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(color: accentColor.withOpacity(0.3), blurRadius: 15, offset: const Offset(0, 8))
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              // CAMBIO: Título actualizado a "Coupons"
              Text("Coupons", style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500)),
              SizedBox(height: 5),
              Text("2,450 pts", style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w900)),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(15)),
            child: const Text("Redeem", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }

  Widget _buildMenuSection(BuildContext context, UserModel user) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        children: [
          _menuTile(Icons.person_outline, "Edit Profile", () {
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EditProfileScreen(user: user))
            );
          }),
          _menuTile(Icons.history_rounded, "Order History", () {}),
          _menuTile(Icons.payment_outlined, "Payment Methods", () {}),
          _menuTile(Icons.headset_mic_outlined, "Help & Support", () {}),
        ],
      ),
    );
  }

  Widget _menuTile(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.black87),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: onTap,
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return TextButton(
      onPressed: () async {
        await _userController.auth.signOut();

        if (context.mounted) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false,
          );
        }
      },
      child: const Text("Log Out", style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold, fontSize: 16)),
    );
  }
}