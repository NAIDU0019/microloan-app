import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../components/loan_card.dart';
import '../components/wallet_connect.dart';
import '../navigation/app_navigator.dart';
import '../routes.dart';
import '../state/loan_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loans = ref.watch(loanProvider).loans;

    return Scaffold(
      appBar: AppBar(
        title: const Text('MicroLoan Dashboard'),
        actions: const [WalletConnectButton(showAddress: true)],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Your Active Loans', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Expanded(
              child: loans.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('No active loans'),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () => AppNavigator.pushNamed(AppRoutes.loanApply),
                            child: const Text('Apply for Loan'),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: loans.length,
                      itemBuilder: (context, index) => LoanCard(
                        loanId: loans[index].id,
                        amount: loans[index].amount,
                        repaid: loans[index].repaid,
                        status: loans[index].status,
                        dueDate: loans[index].dueDate,
                        onTap: () => AppNavigator.pushNamed(
                          AppRoutes.loanStatus,
                          arguments: {'loanId': loans[index].id},
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => AppNavigator.pushNamed(AppRoutes.loanApply),
        child: const Icon(Icons.add),
      ),
    );
  }
}