import 'package:flutter/material.dart';
import 'package:darna_app/core/theme/darna_colors.dart';

/// Invite Member screen (`06 — Family Space / Invite Member`).
class InviteMemberScreen extends StatelessWidget {
  const InviteMemberScreen({super.key, this.onBack, this.onSendInvitation});

  final VoidCallback? onBack;
  final VoidCallback? onSendInvitation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F3E9),
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
              _buildHero(),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Invite someone you trust to see shared bills, plans and household responsibilities.',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: DarnaColors.textSecondary,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 14),
                      _field('Member\'s name', TextEditingController(text: 'Samira Larbi')),
                      const SizedBox(height: 14),
                      _field(
                        'Email address',
                        TextEditingController(text: 'samira.larbi@example.com'),
                        suffixIcon: Icons.mail_outline,
                      ),
                      const SizedBox(height: 14),
                      _field(
                        'Role',
                        TextEditingController(text: 'Household member'),
                        suffixIcon: Icons.chevron_right,
                      ),
                      const SizedBox(height: 14),
                      _whatTheySeeAlert(),
                      const SizedBox(height: 16),
                      _sendButton(onTap: onSendInvitation),
                      const SizedBox(height: 10),
                      const _InvitationSentState(),
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

  Widget _buildHero() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Invite to Larbi Household',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: Color(0xFFA8C5B8),
              height: 1.5,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 2),
          const Text(
            'Home is better shared',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: DarnaColors.ivory,
              height: 1.13,
              letterSpacing: -0.8,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            height: 120,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF0F4D46), Color(0xFF2E6F63)],
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  left: -40,
                  top: -60,
                  child: Container(
                    width: 260,
                    height: 200,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFD4AF37),
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 2,
                      width: double.infinity,
                      color: const Color(0xFFD4AF37),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 24, bottom: 16),
                    child: SizedBox(
                      width: 80,
                      height: 60,
                      child: Image.asset(
                        'assets/images/member_avatar.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: -40,
                  top: -60,
                  child: Container(
                    width: 260,
                    height: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFFD4AF37).withValues(alpha: 0.12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _field(String label, TextEditingController controller, {IconData? suffixIcon}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: DarnaColors.textPrimary,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: DarnaColors.border),
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextField(
            controller: controller,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: DarnaColors.textPrimary,
              height: 1.5,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              suffixIcon: suffixIcon == null
                  ? null
                  : Icon(suffixIcon, size: 18, color: DarnaColors.textSecondary),
            ),
          ),
        ),
      ],
    );
  }

  Widget _whatTheySeeAlert() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: const BoxDecoration(
        color: Color(0xFFEAF0F4),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.info_outline, size: 20, color: Color(0xFF345A71)),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'What they can see',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF345A71),
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Members can view shared household records, add tasks and record external payments. No banking information is connected.',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: DarnaColors.textPrimary,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _sendButton({VoidCallback? onTap}) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: const BoxDecoration(
        color: DarnaColors.primary,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1A6358), Color(0xFF0F4D46)],
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x330F4D46),
            blurRadius: 7,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Center(
        child: const Text(
          'Send Invitation',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class _InvitationSentState extends StatelessWidget {
  const _InvitationSentState();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: DarnaColors.border),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0F09351B),
            blurRadius: 18,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: const BoxDecoration(
              color: Color(0xFFEAF2EA),
              borderRadius: BorderRadius.all(Radius.circular(6)),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.check, size: 12, color: Color(0xFF245D40)),
                SizedBox(width: 4),
                Text(
                  'Invitation sent',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF245D40),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 20,
                  backgroundColor: Color(0xFFDCE7D8),
                  child: Icon(Icons.person, size: 18, color: Color(0xFF254C3B)),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Samira Larbi',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: DarnaColors.textPrimary,
                          height: 1.4,
                        ),
                      ),
                      const Text(
                        'Pending acceptance',
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
                const Icon(Icons.chevron_right, size: 18, color: DarnaColors.textSecondary),
              ],
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'A place at home for Samira.',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: DarnaColors.textPrimary,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Invitation sent to samira.larbi@example.com. She\'ll appear in Family Space after accepting.',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: DarnaColors.textSecondary,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Invitation status',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: DarnaColors.textSecondary,
                    height: 1.5,
                  ),
                ),
              ),
              Text(
                'Pending acceptance',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: DarnaColors.textPrimary,
                  height: 1.0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
