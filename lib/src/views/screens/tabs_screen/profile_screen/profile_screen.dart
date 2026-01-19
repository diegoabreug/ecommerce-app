import 'package:flutter/material.dart';
import 'package:ecommerce_app/src/controllers/user_controller.dart';
import 'package:ecommerce_app/src/models/user_model.dart';
import 'package:ecommerce_app/src/views/screens/tabs_screen/profile_screen/edit_profile_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final UserController _userController = UserController();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Mi Cuenta",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined, color: Colors.black),
            onPressed: () {
              // Aquí podrías ir a ajustes generales de la app
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

          if (!snapshot.hasData) {
            return const Center(child: Text("No se encontraron datos"));
          }

          UserModel user = snapshot.data!;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // 1. Foto de Perfil
                Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 55,
                        backgroundColor: Colors.grey.shade200,
                        backgroundImage: user.profileImageUrl.isNotEmpty
                            ? NetworkImage(user.profileImageUrl)
                            : const AssetImage('assets/images/user.png') as ImageProvider,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 35,
                          width: 35,
                          decoration: BoxDecoration(
                            color: Colors.blue, // Color primario de tu app
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            icon: const Icon(Icons.edit, color: Colors.white, size: 20),
                            onPressed: () {
                              _navigateToEdit(context, user);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),

                // 2. Nombre Completo
                Text(
                  user.fullName.isNotEmpty ? user.fullName : "Usuario",
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),

                // 3. Biografía corta
                if (user.bio.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      user.bio,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                  ),

                const SizedBox(height: 30),

                // 4. Botón grande de Editar
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () => _navigateToEdit(context, user),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text("Editar Perfil", style: TextStyle(color: Colors.white)),
                  ),
                ),

                const SizedBox(height: 30),
                const Divider(),
                const SizedBox(height: 10),

                // 5. Detalles de Contacto (Estilo lista)
                _buildProfileOption(Icons.person_outline, "Nombre", user.firstName),
                _buildProfileOption(Icons.person_outline, "Apellido", user.lastName),
                _buildProfileOption(Icons.phone_outlined, "Teléfono", user.phone),
                // Aquí podrías agregar Email (traído desde Auth) o Dirección
              ],
            ),
          );
        },
      ),
    );
  }

  void _navigateToEdit(BuildContext context, UserModel user) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditProfileScreen(user: user)),
    );
  }

  Widget _buildProfileOption(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: Colors.grey.shade700),
          ),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(color: Colors.grey.shade500, fontSize: 12)),
              const SizedBox(height: 2),
              Text(
                value.isNotEmpty ? value : "No especificado",
                style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
            ],
          ),
        ],
      ),
    );
  }
}