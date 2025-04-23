import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/polygon_service.dart';
import '../state/wallet_provider.dart';

class WalletConnectButton extends ConsumerWidget {
  final bool showAddress;
  final double iconSize;
  final bool showDisconnect;

  const WalletConnectButton({
    super.key,
    this.showAddress = true,
    this.iconSize = 24,
    this.showDisconnect = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final walletState = ref.watch(walletProvider);
    final walletNotifier = ref.read(walletProvider.notifier);

    return walletState.walletAddress != null
        ? Row(
            children: [
              if (showAddress) ...[
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceVariant,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/polygon_logo.png',
                        width: iconSize - 4,
                        height: iconSize - 4,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${walletState.walletAddress!.substring(0, 6)}...${walletState.walletAddress!.substring(walletState.walletAddress!.length - 4)}',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
                if (showDisconnect) const SizedBox(width: 8),
              ],
              if (showDisconnect)
                IconButton(
                  icon: Icon(Icons.logout, size: iconSize),
                  onPressed: () => walletNotifier.disconnectWallet(),
                  tooltip: 'Disconnect Wallet',
                ),
            ],
          )
        : ElevatedButton.icon(
            icon: Image.asset(
              'assets/polygon_logo.png',
              width: iconSize,
              height: iconSize,
            ),
            label: const Text('Connect Wallet'),
            onPressed: () async {
              try {
                final address = await PolygonService.connectWallet();
                if (address != null) {
                  walletNotifier.setWalletAddress(address);
                }
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error connecting wallet: $e')),
                );
              }
            },
          );
  }
}