import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../components/wallet_connect.dart';
import '../services/polygon_service.dart';
import '../state/wallet_provider.dart';

class WalletScreen extends ConsumerWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final walletState = ref.watch(walletProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Wallet')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (walletState.walletAddress == null) ...[
              const Text('Connect your wallet to view balance and transactions',
                  textAlign: TextAlign.center),
              const SizedBox(height: 24),
              const WalletConnectButton(showAddress: false, iconSize: 48),
            ] else ...[
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      const Text('Your Balance', style: TextStyle(fontSize: 16)),
                      const SizedBox(height: 8),
                      FutureBuilder<double>(
                        future: PolygonService.getBalance(walletState.walletAddress!),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          }
                          return Text(
                            '${snapshot.data?.toStringAsFixed(2) ?? '0.00'} MATIC',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text('Recent Transactions', style: TextStyle(fontSize: 18)),
              const SizedBox(height: 8),
              Expanded(
                child: FutureBuilder<List<Transaction>>(
                  future: PolygonService.getTransactions(walletState.walletAddress!),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    final transactions = snapshot.data ?? [];
                    if (transactions.isEmpty) {
                      return const Center(child: Text('No transactions found'));
                    }
                    return ListView.builder(
                      itemCount: transactions.length,
                      itemBuilder: (context, index) {
                        final tx = transactions[index];
                        return ListTile(
                          leading: Icon(
                            tx.isIncoming ? Icons.arrow_downward : Icons.arrow_upward,
                            color: tx.isIncoming ? Colors.green : Colors.red,
                          ),
                          title: Text(tx.hash.substring(0, 12)),
                          subtitle: Text(tx.timestamp),
                          trailing: Text('${tx.amount} MATIC'),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class Transaction {
  final String hash;
  final String timestamp;
  final double amount;
  final bool isIncoming;

  Transaction({
    required this.hash,
    required this.timestamp,
    required this.amount,
    required this.isIncoming,
  });
}