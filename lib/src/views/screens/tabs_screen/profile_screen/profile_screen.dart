import 'package:flutter/material.dart';
import 'package:ecommerce_app/src/controllers/user_controller.dart'; // Asegúrate que la ruta sea correcta
import '../../../../models/user_model.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Configuración de colores para el diseño "Premium Foodie"
  final Color accentColor = const Color(0xFFFF9500);
  final Color bgColor = const Color(0xFFFBFBFF);

  // Instancia del controlador
  final UserController _userController = UserController();

  // Variable para el stream (evita reinicios infinitos)
  late Stream<UserModel> _userStream;

  @override
  void initState() {
    super.initState();
    // Inicializamos el stream una sola vez al cargar la pantalla
    _userStream = _userController.getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: StreamBuilder<UserModel>(
        stream: _userStream,
        builder: (context, snapshot) {
          // 1. Estado de carga
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Color(0xFFFF9500)));
          }

          // 2. Estado de error
          if (snapshot.hasError) {
            return Center(child: Text("Error al cargar perfil: ${snapshot.error}"));
          }

          // 3. Si no hay datos
          if (!snapshot.hasData) {
            return const Center(child: Text("No se encontró información del usuario"));
          }

          final user = snapshot.data!;

          // 4. UI con datos reales
          return SingleChildScrollView(
            child: Column(
              children: [
                _buildHeader(context, user),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      const SizedBox(height: 25),
                      _buildLoyaltyCard(),
                      const SizedBox(height: 25),
                      _buildQuickActions(),
                      const SizedBox(height: 30),
                      _buildMenuSection(context, user),
                      const SizedBox(height: 40),
                      _buildLogoutButton(),
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
            user.fullName.isNotEmpty ? user.fullName : "Usuario",
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w800, letterSpacing: -0.5),
          ),
          Text(
            _userController.auth.currentUser?.email ?? "Sin correo registrado",
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
              Text("Nivel Foodie Oro", style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500)),
              SizedBox(height: 5),
              Text("2,450 pts", style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w900)),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(15)),
            child: const Text("Canjear", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _actionSquare(Icons.confirmation_number_outlined, "Cupones", "3 disp."),
        _actionSquare(Icons.favorite_border_rounded, "Favoritos", "12 items"),
        _actionSquare(Icons.location_on_outlined, "Direcciones", "2 activas"),
      ],
    );
  }

  Widget _actionSquare(IconData icon, String title, String sub) {
    return Container(
      width: 105,
      padding: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10)],
      ),
      child: Column(
        children: [
          Icon(icon, color: accentColor, size: 28),
          const SizedBox(height: 8),
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
          Text(sub, style: const TextStyle(color: Colors.grey, fontSize: 11)),
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
          _menuTile(Icons.person_outline, "Editar mi perfil", () {
            // NAVEGACIÓN CORREGIDA:
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EditProfileScreen(user: user))
            );
          }),
          _menuTile(Icons.history_rounded, "Historial de pedidos", () {}),
          _menuTile(Icons.payment_outlined, "Métodos de pago", () {}),
          _menuTile(Icons.headset_mic_outlined, "Soporte y ayuda", () {}),
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

  Widget _buildLogoutButton() {
    return TextButton(
      onPressed: () {
        // Lógica para cerrar sesión aquí
      },
      child: const Text("Cerrar Sesión", style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold, fontSize: 16)),
    );
  }
}