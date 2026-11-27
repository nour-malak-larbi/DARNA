import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:darna_app/core/theme/darna_colors.dart';

/// Choose Service screen (`05 — Bills & Services / 07 Choose Service`).
class ChooseServiceScreen extends StatelessWidget {
  const ChooseServiceScreen({super.key, this.onBack, this.onServiceSelect});

  final VoidCallback? onBack;
  final ValueChanged<String>? onServiceSelect;

  static const _services = <_ServiceOption>[
    _ServiceOption(
      name: 'Electricity',
      subtitle: 'Variable amount · recurring or one-off',
      kind: 'Variable amount',
      icon: 'assets/images/home/electricity_3d.png',
    ),
    _ServiceOption(
      name: 'Water',
      subtitle: 'Variable amount · recurring or one-off',
      kind: 'Variable amount',
      icon: 'assets/images/home/water_3d.png',
    ),
    _ServiceOption(
      name: 'Gas',
      subtitle: 'Variable amount · recurring or one-off',
      kind: 'Variable amount',
      icon: 'assets/images/home/gas_3d.png',
    ),
    _ServiceOption(
      name: 'Rent',
      subtitle: 'Fixed amount · recurring',
      kind: 'Fixed amount',
      icon: 'assets/images/home/rent_3d.png',
    ),
    _ServiceOption(
      name: 'Housing installments',
      subtitle: 'Fixed amount · payment plan',
      kind: 'Fixed amount',
      icon: 'assets/images/home/housing_3d.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFC7E4DB),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFC7E4DB), Colors.white],
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 8, 24, 0),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: onBack,
                      behavior: HitTestBehavior.opaque,
                      child: SizedBox(
                        width: 30,
                        height: 36,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: SvgPicture.asset(
                            'assets/icons/arrow_left_dark.svg',
                            width: 22,
                            height: 22,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'ADD AN OBLIGATION · 1 OF 2',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF2E6F63),
                              height: 1.5,
                              letterSpacing: 0.6,
                            ),
                          ),
                          Text(
                            'What are we adding?',
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w700,
                              color: DarnaColors.primary,
                              height: 1.15,
                              letterSpacing: -0.8,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(24, 16, 24, 0),
                        child: Text(
                          'Choose a service. We\'ll keep only the details that matter for it.',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: DarnaColors.textSecondary,
                            height: 1.5,
                          ),
                        ),
                      ),
                      const Divider(color: DarnaColors.border, height: 1),
                      ...[
                        for (final s in _services)
                          _ServiceRow(
                            service: s,
                            onTap: () => onServiceSelect?.call(s.name),
                          ),
                      ],
                      const Divider(color: DarnaColors.border, height: 1),
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: DarnaColors.ivory,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: DarnaColors.border),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SvgPicture.asset(
                              'assets/icons/info.svg',
                              width: 18,
                              height: 18,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Made for your household',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: DarnaColors.primary,
                                      height: 1.4,
                                    ),
                                  ),
                                  const SizedBox(height: 3),
                                  const Text(
                                    'Adding a service creates a tracking record only. No account connection or payment is required.',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: DarnaColors.textSecondary,
                                      height: 1.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ServiceOption {
  const _ServiceOption({
    required this.name,
    required this.subtitle,
    required this.kind,
    required this.icon,
  });

  final String name;
  final String subtitle;
  final String kind;
  final String icon;
}

class _ServiceRow extends StatelessWidget {
  const _ServiceRow({required this.service, required this.onTap});

  final _ServiceOption service;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: DarnaColors.border),
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 14,
        ),
        dense: true,
        visualDensity: VisualDensity.standard,
        onTap: onTap,
        leading: Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xFFEAF2EA),
          ),
          child: Image.asset(service.icon, fit: BoxFit.contain),
        ),
        title: Text(
          service.name,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: DarnaColors.primary,
            height: 1.4,
          ),
        ),
        subtitle: Text(
          service.subtitle,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: DarnaColors.textSecondary,
            height: 1.5,
          ),
        ),
        trailing: const Icon(
          Icons.chevron_right,
          size: 18,
          color: DarnaColors.textSecondary,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
      ),
    );
  }
}
