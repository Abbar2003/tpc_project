// lib/presentation/pages/raw_materials_list_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tcp/core/util/const.dart';
import 'package:tcp/core/widget/appar_widget,.dart'; // تأكد من المسار الصحيح
import 'package:tcp/feutaure/Row_Material/presentation/view/manager/get_raw_material_cubit.dart';
import 'package:tcp/feutaure/Row_Material/presentation/view/manager/get_raw_material_state.dart'; // تأكد من المسار الصحيح للموديل

class RawMaterialsListPage extends StatefulWidget {
  const RawMaterialsListPage({super.key});

  @override
  State<RawMaterialsListPage> createState() => _RawMaterialsListPageState();
}

class _RawMaterialsListPageState extends State<RawMaterialsListPage> {
  @override
  void initState() {
    super.initState();
    // عند تهيئة الصفحة، اطلب من الـ Cubit جلب البيانات
    context.read<GetRawMaterialsCubit>().fetchRawMaterials();
  }

  void _showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Palette.primary : Palette.primary,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppareWidget(
          automaticallyImplyLeading: false,
          title: 'قائمة المواد الخام',
        ),
      ),
      body: BlocConsumer<GetRawMaterialsCubit, GetRawMaterialsState>(
        listener: (context, state) {
          if (state is GetRawMaterialsError) {
            _showSnackBar(state.message, isError: true);
          }
        },
        builder: (context, state) {
          if (state is GetRawMaterialsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GetRawMaterialsSuccess) {
            if (state.rawMaterials.isEmpty) {
              return const Center(child: Text('لا توجد مواد خام لعرضها.'));
            }
            return ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: state.rawMaterials.length,
              itemBuilder: (context, index) {
                final rawMaterial = state.rawMaterials[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          rawMaterial.name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Palette.primaryDark,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          rawMaterial.description,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[700],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'السعر: \$${rawMaterial.price.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              'الحالة: ${rawMaterial.status}',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: rawMaterial.status == 'used'
                                    ? Colors.orange
                                    : Colors.green,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'تنبيه المخزون الأدنى: ${rawMaterial.minimumStockAlert}',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Palette.primary, // يمكن استخدام لون تحذيري
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'تاريخ الإنشاء: ${rawMaterial.createdAt.toLocal().toString().split(' ')[0]}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (state is GetRawMaterialsError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline,
                      color: Palette.primary, size: 50),
                  const SizedBox(height: 10),
                  Text(
                    'فشل تحميل البيانات: ${state.message}',
                    textAlign: TextAlign.center,
                    style:
                        const TextStyle(fontSize: 16, color: Palette.primary),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: () {
                      context.read<GetRawMaterialsCubit>().fetchRawMaterials();
                    },
                    icon: const Icon(Icons.refresh),
                    label: const Text('إعادة المحاولة'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Palette.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return const Center(child: Text('ابدأ بجلب المواد الخام.'));
        },
      ),
    );
  }
}
