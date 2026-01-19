import 'dart:io';
import 'package:ecommerce_app/src/controllers/user_controller.dart';
import 'package:ecommerce_app/src/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  final UserModel user;
  const EditProfileScreen({super.key, required this.user});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final UserController _userController = UserController();
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _bioController;
  late TextEditingController _phoneController;

  XFile? _imageFile;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(text: widget.user.firstName);
    _lastNameController = TextEditingController(text: widget.user.lastName);
    _bioController = TextEditingController(text: widget.user.bio);
    _phoneController = TextEditingController(text: widget.user.phone);
  }

  // Seleccionar imagen de la galería
  _selectImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _imageFile = image;
      });
    }
  }

  _saveProfile() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      String? imageUrl;

      // 1. Si el usuario eligió una foto nueva, la subimos
      if (_imageFile != null) {
        imageUrl = await _userController.uploadProfileImage(_imageFile!);
      }

      // 2. Actualizamos los datos
      String res = await _userController.updateUserData(
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        bio: _bioController.text,
        phone: _phoneController.text,
        profileImageUrl: imageUrl,
      );

      setState(() => _isLoading = false);

      if (res == 'Success') {
        Navigator.pop(context); // Regresamos al perfil
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Perfil actualizado correctamente")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(res)),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Editar Perfil", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        actions: [
          TextButton(
            onPressed: _saveProfile,
            child: const Text("Guardar", style: TextStyle(fontSize: 16)),
          )
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Área de la Foto
              GestureDetector(
                onTap: _selectImage,
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey.shade200,
                      backgroundImage: _imageFile != null
                          ? FileImage(File(_imageFile!.path)) as ImageProvider
                          : (widget.user.profileImageUrl.isNotEmpty
                          ? NetworkImage(widget.user.profileImageUrl)
                          : const AssetImage('assets/images/user.png')),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: CircleAvatar(
                        radius: 16,
                        backgroundColor: Colors.blue,
                        child: const Icon(Icons.camera_alt, color: Colors.white, size: 16),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              const Text("Cambiar foto", style: TextStyle(color: Colors.blue)),

              const SizedBox(height: 30),

              // Campos de texto
              _buildTextField("Nombre", _firstNameController),
              _buildTextField("Apellido", _lastNameController),
              _buildTextField("Biografía", _bioController, maxLines: 3),
              _buildTextField("Teléfono", _phoneController, isPhone: true),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, {bool isPhone = false, int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        controller: controller,
        keyboardType: isPhone ? TextInputType.phone : TextInputType.text,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ),
      ),
    );
  }
}