import 'package:flutter/material.dart';
import '../utils/currency_converter.dart';

class LoanCard extends StatelessWidget {
  final String loanId;
  final double amount;
  final double repaid;
  final String status;
  final DateTime dueDate;
  final VoidCallback? onTap;

  const LoanCard({
    super.key,
    required this.loanId,
    required this.amount,
    required this.repaid,
    required this.status,
    required this.dueDate,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final progress = repaid / amount;
    final daysRemaining = dueDate.difference(DateTime.now()).inDays;

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Loan #${loanId.substring(0, 6)}',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: _getStatusColor(context).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      status.toUpperCase(),
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: _getStatusColor(context),
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _LoanDetailItem(
                      label: 'Amount',
                      value: CurrencyConverter.format(amount),
                    ),
                  ),
                  Expanded(
                    child: _LoanDetailItem(
                      label: 'Repaid',
                      value: CurrencyConverter.format(repaid),
                    ),
                  ),
                  Expanded(
                    child: _LoanDetailItem(
                      label: 'Due In',
                      value: '$daysRemaining days',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              LinearProgressIndicator(
                value: progress > 1 ? 1 : progress,
                backgroundColor: Theme.of(context).dividerColor,
                color: _getProgressColor(context),
                minHeight: 6,
                borderRadius: BorderRadius.circular(3),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getStatusColor(BuildContext context) {
    return switch (status.toLowerCase()) {
      'approved' => Colors.green,
      'pending' => Colors.orange,
      'rejected' => Colors.red,
      'disbursed' => Colors.blue,
      'completed' => Colors.purple,
      _ => Theme.of(context).primaryColor,
    };
  }

  Color _getProgressColor(BuildContext context) {
    if (progress >= 1) return Colors.green;
    if (progress >= 0.75) return Colors.blue;
    if (progress >= 0.5) return Colors.orange;
    return Colors.red;
  }
}

class _LoanDetailItem extends StatelessWidget {
  final String label;
  final String value;

  const _LoanDetailItem({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).hintColor,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }
}