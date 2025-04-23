import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../components/button.dart';
import '../navigation/app_navigator.dart';
import '../routes.dart';
import '../state/loan_provider.dart';

class LoanStatusScreen extends ConsumerWidget {
  final String loanId;

  const LoanStatusScreen({super.key, required this.loanId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loan = ref.watch(loanProvider).getLoanById(loanId);

    return Scaffold(
      appBar: AppBar(title: Text('Loan #${loanId.substring(0, 6)}')),
      body: loan == null
          ? const Center(child: Text('Loan not found'))
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _LoanDetailItem(label: 'Status', value: loan.status),
                  _LoanDetailItem(label: 'Amount', value: '₹${loan.amount}'),
                  _LoanDetailItem(label: 'Interest Rate', value: '${loan.interestRate}%'),
                  _LoanDetailItem(label: 'Disbursed On', value: loan.disbursementDate),
                  _LoanDetailItem(label: 'Due Date', value: loan.dueDate),
                  _LoanDetailItem(label: 'Amount Repaid', value: '₹${loan.repaid}'),
                  const SizedBox(height: 24),
                  if (loan.status == 'approved')
                    AppButton(
                      text: 'Make Payment',
                      onPressed: () => AppNavigator.pushNamed(
                        AppRoutes.payment,
                        arguments: {'loanId': loanId},
                      ),
                      width: double.infinity,
                    ),
                ],
              ),
            ),
    );
  }
}

class _LoanDetailItem extends StatelessWidget {
  final String label;
  final String value;

  const _LoanDetailItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(value),
        ],
      ),
    );
  }
}