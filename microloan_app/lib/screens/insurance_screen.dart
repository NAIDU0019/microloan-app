import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../components/button.dart';
import '../state/insurance_provider.dart';

class InsuranceScreen extends ConsumerWidget {
  const InsuranceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final insuranceState = ref.watch(insuranceProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Loan Insurance')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Text('Loan Protection Plan',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 16),
                    const Text('Coverage for unexpected events during loan tenure'),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('Premium:', style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('1.5% of loan amount per year'),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('Coverage:', style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('Up to ₹2,00,000'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            if (insuranceState.activePolicies.isNotEmpty) ...[
              const Text('Your Active Policies', style: TextStyle(fontSize: 18)),
              const SizedBox(height: 8),
              ...insuranceState.activePolicies.map((policy) => Card(
                child: ListTile(
                  title: Text('Policy #${policy.policyNumber}'),
                  subtitle: Text('Coverage: ₹${policy.coverageAmount}'),
                  trailing: Text('Valid until ${policy.endDate}'),
                ),
              )),
              const SizedBox(height: 24),
            ],
            AppButton(
              text: insuranceState.hasActivePolicy ? 'Manage Policy' : 'Get Insurance',
              onPressed: () => _handleInsuranceAction(ref),
            ),
          ],
        ),
      ),
    );
  }

  void _handleInsuranceAction(WidgetRef ref) {
    final insuranceNotifier = ref.read(insuranceProvider.notifier);
    if (ref.read(insuranceProvider).hasActivePolicy) {
      // Manage existing policy
      insuranceNotifier.viewPolicyDetails();
    } else {
      // Purchase new policy
      insuranceNotifier.purchaseInsurance();
    }
  }
}