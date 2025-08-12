import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/orders/detail_row.dart';
import '../../dialogs/confirm_order_dialog.dart';
import '../../models/order_item.dart';

class OrderSummaryScreen extends StatefulWidget {
  final String orderNumber;
  final List<OrderItem> initialItems;

  const OrderSummaryScreen({
    Key? key,
    required this.orderNumber,
    required this.initialItems,
  }) : super(key: key);

  @override
  State<OrderSummaryScreen> createState() => _OrderSummaryScreenState();
}

class _OrderSummaryScreenState extends State<OrderSummaryScreen> {
  late List<OrderItem> items;

  @override
  void initState() {
    super.initState();
    items = widget.initialItems.isEmpty
        ? [
            OrderItem(title: 'Деталь №1', qty: 2),
            OrderItem(title: 'Деталь №2', qty: 5),
            OrderItem(title: 'Деталь №3', qty: 10),
            OrderItem(title: 'Деталь №4', qty: 1),
            OrderItem(title: '.....', qty: 0),
          ]
        : List<OrderItem>.from(widget.initialItems);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 16, 8),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new, size: 20, color: AppColors.textDark),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      widget.orderNumber,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textDark),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                itemBuilder: (_, i) => DetailRow(item: items[i]),
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemCount: items.length,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: Column(
                children: [
                  CustomButton(
                    text: 'Продолжить выбор деталей',
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(height: 12),
                  CustomButton(
                    text: 'Сохранить черновик',
                    onPressed: () async {
                      await showDialog(context: context, builder: (_) => ConfirmOrderDialog(orderNumber: widget.orderNumber));
                    },
                    isOutlined: true,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 6),
            NavigationBar(
              backgroundColor: AppColors.white,
              indicatorColor: Colors.transparent,
              selectedIndex: 0,
              destinations: const [
                NavigationDestination(icon: Icon(Icons.menu), label: 'Заказы'),
                NavigationDestination(icon: Icon(Icons.autorenew), label: 'Каталог'),
                NavigationDestination(icon: Icon(Icons.settings), label: 'Клуб'),
                NavigationDestination(icon: Icon(Icons.person), label: 'Профиль'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
