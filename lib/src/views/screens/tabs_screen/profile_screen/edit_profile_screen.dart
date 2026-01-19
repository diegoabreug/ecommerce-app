import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ecommerce_app/src/controllers/user_controller.dart';
import '../../../../models/user_model.dart';

class EditProfileScreen extends StatefulWidget {
  final UserModel user;
  const EditProfileScreen({super.key, required this.user});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final UserController _userController = UserController();

  late TextEditingController _firstNameController;
  late TextEditingController _phoneController;

  XFile? _imageFile;
  bool _isLoading = false;
  final Color accentColor = const Color(0xFFFF9500);

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(text: widget.user.fullName);
    _phoneController = TextEditingController(text: widget.user.phone);
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? selectedImage = await picker.pickImage(source: ImageSource.gallery);
    if (selectedImage != null) {
      setState(() => _imageFile = selectedImage);
    }
  }

  Future<void> _saveProfile() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      try {
        if (_imageFile != null) {
          await _userController.uploadProfileImage(_imageFile!);
        }

        Map<String, dynamic> dataToUpdate = {
          'fullName': _firstNameController.text.trim(),
          'phone': _phoneController.text.trim(),
        };

        await _userController.updateUserData(dataToUpdate);

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('¡Perfil actualizado!')),
          );
          Navigator.of(context).pop();
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: $e')),
          );
        }
      } finally {
        if (mounted) setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: const Text('Mi Información', style: TextStyle(fontWeight: FontWeight.w800)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildImagePicker(),
              const SizedBox(height: 30),
              _inputLabel("Nombre Completo"),
              _buildModernField(_firstNameController, Icons.person_outline),
              const SizedBox(height: 20),
              _inputLabel("Número de Contacto"),
              _buildModernField(_phoneController, Icons.phone_android_outlined, type: TextInputType.phone),
              const SizedBox(height: 30),

              _inputLabel("Tus Categorías Favoritas"),
              const SizedBox(height: 10),
              Wrap(
                spacing: 10,
                children: [
                  _preferenceChip("🍕 Pizza", true),
                  _preferenceChip("🍔 Burgers", false),
                  _preferenceChip("🥗 Saludable", true),
                  _preferenceChip("🍣 Sushi", false),
                ],
              ),

              const SizedBox(height: 50),
              _buildSaveButton(),
            ],
          ),
        ),
      ),
    );
  }

  // --- MÉTODOS DE APOYO (HELPERS) ---

  Widget _buildImagePicker() {
    return Center(
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: accentColor.withOpacity(0.5), width: 2),
            ),
            child: CircleAvatar(
              radius: 60,
              backgroundColor: Colors.grey.shade100,
              backgroundImage: _imageFile != null
                  ? FileImage(File(_imageFile!.path))
                  : (widget.user.profileImageUrl.isNotEmpty
                  ? NetworkImage(widget.user.profileImageUrl)
                  : null) as ImageProvider?,
              child: (_imageFile == null && widget.user.profileImageUrl.isEmpty)
                  ? Icon(Icons.person, size: 60, color: Colors.grey.shade400)
                  : null,
            ),
          ),
          GestureDetector(
            onTap: _pickImage,
            child: CircleAvatar(
              radius: 20,
              backgroundColor: accentColor,
              child: const Icon(Icons.camera_alt_rounded, color: Colors.white, size: 20),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSaveButton() {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _saveProfile,
        style: ElevatedButton.styleFrom(
          backgroundColor: accentColor,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        ),
        child: _isLoading
            ? const SizedBox(
          height: 20,
          width: 20,
          child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
        )
            : const Text(
          "Guardar Cambios",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _inputLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, bottom: 8),
      child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black54)),
    );
  }

  Widget _buildModernField(TextEditingController controller, IconData icon, {TextInputType type = TextInputType.text}) {
    return TextFormField(
      controller: controller,
      keyboardType: type,
      validator: (value) => value!.isEmpty ? 'Requerido' : null,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: accentColor),
        filled: true,
        fillColor: const Color(0xFFF5F5F7),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(18), borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(color: accentColor.withOpacity(0.5), width: 1),
        ),
      ),
    );
  }

  Widget _preferenceChip(String label, bool isSelected) {
    return FilterChip(
      label: Text(label, style: TextStyle(color: isSelected ? accentColor : Colors.black87, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
      selected: isSelected,
      onSelected: (v) {},
      backgroundColor: Colors.grey.shade100,
      selectedColor: accentColor.withOpacity(0.1),
      checkmarkColor: accentColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: BorderSide(color: isSelected ? accentColor : Colors.transparent)),
    );
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }
}