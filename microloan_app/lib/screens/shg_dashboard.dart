import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../components/button.dart';
import '../components/loan_card.dart';
import '../state/shg_provider.dart';

class SHGDashboard extends ConsumerWidget {
  const SHGDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shgState = ref.watch(shgProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('SHG Dashboard')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Text('Group Savings', style: TextStyle(fontSize: 18)),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _StatItem(
                          label: 'Total Savings',
                          value: '₹${shgState.totalSavings}',
                        ),
                        _StatItem(
                          label: 'Active Loans',
                          value: shgState.activeLoans.toString(),
                        ),
                        _StatItem(
                          label: 'Members',
                          value: shgState.memberCount.toString(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: AppButton(
                    text: 'Add Savings',
                    onPressed: () {},
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: AppButton(
                    text: 'Group Loan',
                    onPressed: () {},
                    type: ButtonType.secondary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('Group Loan Applications', style: TextStyle(fontSize: 16)),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: shgState.groupLoans.isEmpty
                  ? const Center(child: Text('No group loan applications'))
                  : ListView.builder(
                      itemCount: shgState.groupLoans.length,
                      itemBuilder: (context, index) => LoanCard(
                        loanId: shgState.groupLoans[index].id,
                        amount: shgState.groupLoans[index].amount,
                        repaid: shgState.groupLoans[index].repaid,
                        status: shgState.groupLoans[index].status,
                        dueDate: shgState.groupLoans[index].dueDate,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;

  const _StatItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}