// lib/src/views/screens/profile_screen.dart

import 'package:flutter/material.dart';
import 'package:ecommerce_app/src/controllers/user_controller.dart';
import '../../../../models/user_model.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final UserController _userController = UserController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Fondo blanco estilo Instagram
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Mi Perfil',
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.redAccent),
            onPressed: () {
              // Lógica para cerrar sesión
            },
          ),
        ],
      ),
      body: StreamBuilder<UserModel>(
        stream: _userController.getUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData) {
            return const Center(child: Text('Usuario no encontrado.'));
          }

          final user = snapshot.data!;

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Column(
              children: [
                const SizedBox(height: 10),
                // 1. Avatar Central
                _buildAvatar(user),

                const SizedBox(height: 15),

                // 2. Nombre y Bio Centralizados
                Text(
                  user.fullName,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 22,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  user.bio.isNotEmpty ? user.bio : 'Sin biografía',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.black54,
                    height: 1.4,
                  ),
                ),

                const SizedBox(height: 20),

                // 3. Botón de Editar (Estilo Instagram)
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => EditProfileScreen(user: user),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.shade200, // Gris claro
                      elevation: 0,
                      foregroundColor: Colors.black, // Texto negro
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Editar perfil',
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // Divisor sutil
                Divider(color: Colors.grey.shade200, thickness: 1),

                const SizedBox(height: 10),

                // 4. Lista de Información (Estilo Settings limpio)
                _buildInfoItem(
                  icon: Icons.phone_iphone,
                  label: "Teléfono",
                  value: user.phone.isNotEmpty ? user.phone : "No agregado",
                ),

                // Aquí podrías agregar más campos si tu modelo crece (Email, Ubicación, etc.)
                // Ejemplo:
                // _buildInfoItem(icon: Icons.email_outlined, label: "Correo", value: "usuario@email.com"),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildAvatar(UserModel user) {
    return Container(
      padding: const EdgeInsets.all(3), // Borde blanco simulado
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey.shade300, width: 2),
      ),
      child: CircleAvatar(
        radius: 60, // Avatar grande y central
        backgroundColor: Colors.grey.shade100,
        backgroundImage: user.profileImageUrl.isNotEmpty
            ? NetworkImage(user.profileImageUrl)
            : null,
        child: user.profileImageUrl.isEmpty
            ? Icon(Icons.person, size: 60, color: Colors.grey.shade400)
            : null,
      ),
    );
  }

  Widget _buildInfoItem({required IconData icon, required String label, required String value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: Colors.black87, size: 22),
          ),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w500
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                    fontWeight: FontWeight.w500
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}