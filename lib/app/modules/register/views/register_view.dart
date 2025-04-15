import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:puskesmas/app/style/app_color.dart';

import '../../widgets/input_text_form_field.dart';
import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pendaftaran'),
        centerTitle: true,
      ),
      body: Form(
        key: controller.formKey, // Tambahkan form key
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Nama Depan
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: InputTextFormField(
                  controller: controller.namaDepanController,
                  hint: 'Nama Depan',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nama depan wajib diisi';
                    }
                    return null;
                  },
                ),
              ),

              // Nama Belakang
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: InputTextFormField(
                  controller: controller.namaBelakangController,
                  hint: 'Nama Belakang',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nama belakang wajib diisi';
                    }
                    return null;
                  },
                ),
              ),

              // Email
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: InputTextFormField(
                  controller: controller.emailController,
                  hint: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email wajib diisi';
                    }
                    if (!value.isEmail) {
                      return 'Email tidak valid';
                    }
                    return null;
                  },
                ),
              ),

              // Password
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: InputTextFormField(
                  isSecureField: true,
                  controller: controller.passwordController,
                  hint: 'Password',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password wajib diisi';
                    }
                    if (value.length < 6) {
                      return 'Password minimal 6 karakter';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: InputTextFormField(
                  controller: controller.tglLahirController,
                  hint: 'Tanggal Lahir (YYYY-MM-DD)',
                  isDateField: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Tanggal lahir wajib diisi';
                    }
                    // Validasi format tanggal
                    if (!RegExp(r'^\d{4}-\d{2}-\d{2}$').hasMatch(value)) {
                      return 'Format tanggal harus YYYY-MM-DD';
                    }
                    return null;
                  },
                ),
              ),
              // Nomor HP
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: InputTextFormField(
                  controller: controller.noHpController,
                  hint: 'Nomor HP',
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nomor HP wajib diisi';
                    }
                    if (!value.isPhoneNumber) {
                      return 'Nomor HP tidak valid';
                    }
                    return null;
                  },
                ),
              ),

              // Jenis Kelamin (Dropdown)
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: DropdownButtonFormField<String>(
                  borderRadius: BorderRadius.circular(12),
                  value: controller.jenisKelaminController.text.isNotEmpty
                      ? controller.jenisKelaminController.text
                      : null,
                  items: ['Laki-laki', 'Perempuan'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    controller.jenisKelaminController.text = value ?? '';
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Jenis kelamin wajib dipilih';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Jenis Kelamin',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Colors.black,
                        width: 1.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Colors.black,
                        width: 1.0,
                      ),
                    ),
                  ),
                ),
              ),
              // Dropdown Provinsi
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Obx(() => DropdownButtonFormField<String>(
                      borderRadius: BorderRadius.circular(12),
                      value: controller.selectedProvinsi.value.isEmpty
                          ? null
                          : controller.selectedProvinsi.value,
                      items: controller.provinsiList.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          controller.updateKotaList(value);
                        }
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Pilih provinsi terlebih dahulu';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Provinsi',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                              const BorderSide(color: Colors.black, width: 1.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                              const BorderSide(color: Colors.black, width: 1.0),
                        ),
                      ),
                    )),
              ),

// Dropdown Kota/Kabupaten
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Obx(() => DropdownButtonFormField<String>(
                      borderRadius: BorderRadius.circular(12),
                      value: controller.selectedKota.value.isEmpty
                          ? null
                          : controller.selectedKota.value,
                      items: controller.kotaList.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          controller.setKota(value);
                        }
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Pilih kota terlebih dahulu';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Kota/Kabupaten',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                              const BorderSide(color: Colors.black, width: 1.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                              const BorderSide(color: Colors.black, width: 1.0),
                        ),
                      ),
                    )),
              ),

              // Alamat
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: InputTextFormField(
                  controller: controller.alamatController,
                  hint: 'Alamat',
                  maxLines: 3,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Alamat wajib diisi';
                    }
                    return null;
                  },
                ),
              ),

// Kode Pos
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: InputTextFormField(
                  controller: controller.kodeposController,
                  hint: 'Kode Pos',
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Kodepos wajib diisi';
                    }
                    if (!value.isNum) {
                      return 'Kodepos tidak valid';
                    }
                    return null;
                  },
                ),
              ),

              // Tombol Daftar
              Obx(() => SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: controller.isLoading.value
                          ? null
                          : () {
                              if (controller.formKey.currentState!.validate()) {
                                controller.register();
                              }
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: controller.isLoading.value
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                              'Daftar',
                              style: TextStyle(
                                  color: Colors.white, fontFamily: 'SemiBold'),
                            ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
