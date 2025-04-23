import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../components/button.dart';
import '../services/razorpay_service.dart';
import '../state/loan_provider.dart';

class PaymentScreen extends ConsumerStatefulWidget {
  final String loanId;

  const PaymentScreen({super.key, required this.loanId});

  @override
  ConsumerState<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends ConsumerState<PaymentScreen> {
  final _amountController = TextEditingController();
  String _paymentMethod = 'upi';

  @override
  Widget build(BuildContext context) {
    final loan = ref.watch(loanProvider).getLoanById(widget.loanId);
    final dueAmount = loan?.amount - (loan?.repaid ?? 0);

    return Scaffold(
      appBar: AppBar(title: const Text('Make Payment')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (loan != null) ...[
              Text('Loan #${widget.loanId.substring(0, 6)}',
                  style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              Text('Amount Due: ₹$dueAmount',
                  style: const TextStyle(fontSize: 18)),
              const SizedBox(height: 24),
              TextFormField(
                controller: _amountController,
                decoration: const InputDecoration(
                  labelText: 'Payment Amount',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Enter amount';
                  final amount = double.tryParse(value) ?? 0;
                  if (amount <= 0) return 'Amount must be positive';
                  if (amount > dueAmount) return 'Cannot pay more than due';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              const Text('Payment Method', style: TextStyle(fontWeight: FontWeight.bold)),
              RadioListTile(
                title: const Text('UPI'),
                value: 'upi',
                groupValue: _paymentMethod,
                onChanged: (value) => setState(() => _paymentMethod = value!),
              ),
              RadioListTile(
                title: const Text('Credit/Debit Card'),
                value: 'card',
                groupValue: _paymentMethod,
                onChanged: (value) => setState(() => _paymentMethod = value!),
              ),
              RadioListTile(
                title: const Text('Bank Transfer'),
                value: 'bank',
                groupValue: _paymentMethod,
                onChanged: (value) => setState(() => _paymentMethod = value!),
              ),
              const SizedBox(height: 24),
              AppButton(
                text: 'Proceed to Pay',
                onPressed: _processPayment,
                width: double.infinity,
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _processPayment() {
    final amount = double.tryParse(_amountController.text) ?? 0;
    RazorpayService.initiatePayment(
      context: context,
      amount: amount,
      loanId: widget.loanId,
      onSuccess: () {
        ref.read(loanProvider.notifier).updatePayment(widget.loanId, amount);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Payment successful')),
        );
      },
      onFailure: (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Payment failed: $error')),
        );
      },
    );
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }
}