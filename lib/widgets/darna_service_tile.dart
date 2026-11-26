import 'package:flutter/material.dart';
import '../core/theme/darna_colors.dart';

enum DarnaServiceType {
  electricity,
  water,
  gas,
  rent,
  housingInstallments,
}

/// Sculptural 3D service object tile (Electricity, Water, Gas, Rent, Housing installments).
class DarnaServiceTile extends StatelessWidget {
  const DarnaServiceTile({
    super.key,
    required this.service,
    this.onTap,
    this.isSelected = false,
  });

  final DarnaServiceType service;
  final VoidCallback? onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final config = _configFor(service);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        constraints: const BoxConstraints(minHeight: 112),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? DarnaColors.sageTint : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              config.imagePath,
              width: 48,
              height: 48,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 8),
            Text(
              config.label,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: DarnaColors.textPrimary,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  _ServiceTileConfig _configFor(DarnaServiceType service) {
    switch (service) {
      case DarnaServiceType.electricity:
        return const _ServiceTileConfig(
          label: 'Electricity',
          imagePath: 'assets/images/service_electricity.png',
        );
      case DarnaServiceType.water:
        return const _ServiceTileConfig(
          label: 'Water',
          imagePath: 'assets/images/service_water.png',
        );
      case DarnaServiceType.gas:
        return const _ServiceTileConfig(
          label: 'Gas',
          imagePath: 'assets/images/service_gas.png',
        );
      case DarnaServiceType.rent:
        return const _ServiceTileConfig(
          label: 'Rent',
          imagePath: 'assets/images/service_rent.png',
        );
      case DarnaServiceType.housingInstallments:
        return const _ServiceTileConfig(
          label: 'Housing installments',
          imagePath: 'assets/images/service_housing_installments.png',
        );
    }
  }
}

class _ServiceTileConfig {
  const _ServiceTileConfig({
    required this.label,
    required this.imagePath,
  });

  final String label;
  final String imagePath;
}
