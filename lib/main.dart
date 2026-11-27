import 'package:flutter/material.dart';
import 'core/theme/darna_colors.dart';
import 'core/theme/darna_theme.dart';
import 'core/user/darna_user.dart';
import 'screens/app_shell.dart';
import 'screens/auth/auth_screens.dart';
import 'widgets/widgets.dart';

void main() {
  runApp(const DarnaApp());
}

enum _AppRoute {
  welcome,
  login,
  register,
  forgotPassword,
  home,
  showcase,
}

class DarnaApp extends StatefulWidget {
  const DarnaApp({super.key});

  @override
  State<DarnaApp> createState() => _DarnaAppState();
}

class _DarnaAppState extends State<DarnaApp> {
  _AppRoute _route = _AppRoute.welcome;
  DarnaUser? _user;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Darna',
      debugShowCheckedModeBanner: false,
      theme: DarnaTheme.light,
      home: switch (_route) {
        _AppRoute.welcome => WelcomeScreen(
            onGetStarted: () => setState(() => _route = _AppRoute.register),
            onLogin: () => setState(() => _route = _AppRoute.login),
          ),
        _AppRoute.login => LoginScreen(
            onBack: () => setState(() => _route = _AppRoute.welcome),
            onForgotPassword: () =>
                setState(() => _route = _AppRoute.forgotPassword),
            onCreateAccount: () => setState(() => _route = _AppRoute.register),
            onLoginSubmit: (email, _) {
              setState(() {
                _user = DarnaUser(
                  name: 'Maya Larbi',
                  email: email,
                  phone: '+213 555 0148',
                );
                _route = _AppRoute.home;
              });
            },
          ),
        _AppRoute.register => RegistrationScreen(
            onBack: () => setState(() => _route = _AppRoute.welcome),
            onLoginTap: () => setState(() => _route = _AppRoute.login),
            onCreateAccount: (name, email, _) {
              setState(() {
                _user = DarnaUser(name: name, email: email);
                _route = _AppRoute.home;
              });
            },
          ),
        _AppRoute.forgotPassword => ForgotPasswordScreen(
            onBack: () => setState(() => _route = _AppRoute.login),
            onBackToLogin: () => setState(() => _route = _AppRoute.login),
            onSendReset: (_) {},
          ),
        _AppRoute.home => AppShell(user: _user),
        _AppRoute.showcase => const DarnaUiKitShowcase(),
      },
    );
  }
}

/// Interactive showcase of all Darna reusable UI kit widgets from Figma.
class DarnaUiKitShowcase extends StatefulWidget {
  const DarnaUiKitShowcase({super.key});

  @override
  State<DarnaUiKitShowcase> createState() => _DarnaUiKitShowcaseState();
}

class _DarnaUiKitShowcaseState extends State<DarnaUiKitShowcase> {
  DarnaNavTab _selectedTab = DarnaNavTab.home;
  bool _billRemindersEnabled = true;
  bool _pantryCompleted = false;
  bool _rentCompleted = true;
  String _selectedMember = 'Omar Hassan';
  DarnaServiceType _selectedService = DarnaServiceType.electricity;

  final _nameController = TextEditingController();
  final _focusController = TextEditingController(text: 'Electricity');
  final _errorController = TextEditingController(text: '-148');
  final _passwordController = TextEditingController(text: 'secret123456');

  @override
  void dispose() {
    _nameController.dispose();
    _focusController.dispose();
    _errorController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text(
              'Darna / Reusable UI kit',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontSize: 26,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              'Reusable local components · state variants · interactive widgets',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 24),
            const _SectionHeader('Buttons / 50 px'),
            const SizedBox(height: 12),
            DarnaPrimaryButton(label: 'Save bill', onPressed: () {}),
            const SizedBox(height: 10),
            DarnaPrimaryButton(
              label: 'Save bill',
              isLoading: true,
              onPressed: () {},
            ),
            const SizedBox(height: 10),
            const DarnaPrimaryButton(
              label: 'Save bill',
              isDisabled: true,
              onPressed: null,
            ),
            const SizedBox(height: 12),
            DarnaSecondaryButton(label: 'View details', onPressed: () {}),
            const SizedBox(height: 10),
            const DarnaSecondaryButton(
              label: 'View details',
              isDisabled: true,
              onPressed: null,
            ),
            const SizedBox(height: 24),
            const _SectionHeader('Inputs / 50 px'),
            const SizedBox(height: 12),
            DarnaTextField(
              label: 'Default',
              hintText: 'Enter bill name',
              controller: _nameController,
            ),
            const SizedBox(height: 12),
            DarnaTextField(
              label: 'Focus',
              controller: _focusController,
            ),
            const SizedBox(height: 12),
            DarnaTextField(
              label: 'Error',
              controller: _errorController,
              errorText: 'Enter an amount greater than 0 DZD.',
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 12),
            DarnaTextField(
              label: 'Password',
              controller: _passwordController,
              isPassword: true,
            ),
            const SizedBox(height: 16),
            DarnaPreferenceSwitch(
              title: 'Bill reminders',
              subtitle: 'Two days before due',
              value: _billRemindersEnabled,
              onChanged: (v) => setState(() => _billRemindersEnabled = v),
            ),
            const SizedBox(height: 24),
            const _SectionHeader('Status & finance'),
            const SizedBox(height: 12),
            const Wrap(
              spacing: 6,
              runSpacing: 6,
              children: [
                DarnaStatusBadge(type: DarnaStatusType.upcoming),
                DarnaStatusBadge(type: DarnaStatusType.paidRecorded),
                DarnaStatusBadge(type: DarnaStatusType.overdue),
                DarnaStatusBadge(type: DarnaStatusType.review),
                DarnaStatusBadge(type: DarnaStatusType.manual),
              ],
            ),
            const SizedBox(height: 16),
            const DarnaFinancialSummaryCard(
              title: 'Remaining unallocated',
              amountText: '3,000 DZD',
              progress: 3500 / 6500,
              footerText: '3,500 DZD allocated of 6,500 DZD',
            ),
            const SizedBox(height: 16),
            const DarnaAlertBanner(
              type: DarnaAlertType.success,
              title: 'Bill saved',
              description: 'Your household can now see this bill.',
            ),
            const SizedBox(height: 24),
            const _SectionHeader('Service objects / Darna sculptural family'),
            const SizedBox(height: 12),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: DarnaServiceType.values.map((service) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: SizedBox(
                      width: 110,
                      child: DarnaServiceTile(
                        service: service,
                        isSelected: _selectedService == service,
                        onTap: () => setState(() => _selectedService = service),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 24),
            const _SectionHeader('Bills / tracked, not paid here'),
            const SizedBox(height: 12),
            const DarnaCard(
              child: Column(
                children: [
                  DarnaBillRow(
                    iconPath: 'assets/icons/zap.svg',
                    title: 'Electricity',
                    subtitle: 'Jun 18 · Omar',
                    amountText: '148 DZD',
                    status: DarnaStatusType.upcoming,
                  ),
                  DarnaBillRow(
                    iconPath: 'assets/icons/key_round.svg',
                    title: 'Rent',
                    subtitle: 'Jun 01 · Maya',
                    amountText: '1,450 DZD',
                    status: DarnaStatusType.paidRecorded,
                  ),
                  DarnaBillRow(
                    iconPath: 'assets/icons/droplet.svg',
                    title: 'Water',
                    subtitle: 'Jun 20 · 3 days late · Maya',
                    amountText: '62 DZD',
                    status: DarnaStatusType.overdue,
                    showDivider: false,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const _SectionHeader('People & shared tasks'),
            const SizedBox(height: 12),
            DarnaCard(
              child: Column(
                children: [
                  DarnaFamilyMemberTile(
                    name: 'Maya Hassan',
                    subtitle: 'Household owner',
                    avatarAsset: 'assets/images/avatar_maya.png',
                    isSelected: _selectedMember == 'Maya Hassan',
                    onTap: () => setState(() => _selectedMember = 'Maya Hassan'),
                  ),
                  const SizedBox(height: 12),
                  DarnaFamilyMemberTile(
                    name: 'Omar Hassan',
                    subtitle: 'Selected assignee',
                    avatarAsset: 'assets/images/avatar_omar.png',
                    isSelected: _selectedMember == 'Omar Hassan',
                    onTap: () => setState(() => _selectedMember = 'Omar Hassan'),
                  ),
                  const SizedBox(height: 12),
                  DarnaTaskRow(
                    title: 'Buy pantry essentials',
                    subtitle: 'Today · Lina',
                    isCompleted: _pantryCompleted,
                    assigneeAvatarAsset: 'assets/images/avatar_lina.png',
                    assigneeName: 'Lina',
                    onToggle: () =>
                        setState(() => _pantryCompleted = !_pantryCompleted),
                  ),
                  DarnaTaskRow(
                    title: 'Upload rent receipt',
                    subtitle: 'Completed Jun 01 · Maya',
                    isCompleted: _rentCompleted,
                    assigneeAvatarAsset: 'assets/images/avatar_maya.png',
                    assigneeName: 'Maya',
                    showDivider: false,
                    onToggle: () =>
                        setState(() => _rentCompleted = !_rentCompleted),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            const DarnaCard(
              child: DarnaReminderRow(
                title: 'Electricity due soon',
                subtitle: 'Jun 18 · 148 DZD',
              ),
            ),
            const SizedBox(height: 24),
            const _SectionHeader('Dialog & alert'),
            const SizedBox(height: 12),
            DarnaConfirmationDialog(
              title: 'Log out of Darna?',
              description:
                  'Your household records are saved. You can log back in any time.',
              primaryLabel: 'Log Out',
              secondaryLabel: 'Stay in Darna',
              onPrimaryPressed: () {},
              onSecondaryPressed: () {},
            ),
            const SizedBox(height: 12),
            const DarnaAlertBanner(
              type: DarnaAlertType.warning,
              title: 'Higher than usual',
              description:
                  'Electricity is 38 DZD above your recent average. This may be expected.',
            ),
            const SizedBox(height: 12),
            const DarnaAlertBanner(
              type: DarnaAlertType.info,
              title: 'Component-based handoff',
              description:
                  'Darna Flow · 430 × 932 mobile system. Reusable buttons, form states, 3D service objects, statuses, bill rows, tasks, dialogs and five-destination navigation.',
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
      bottomNavigationBar: DarnaBottomNavBar(
        selectedTab: _selectedTab,
        onTabSelected: (tab) => setState(() => _selectedTab = tab),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontSize: 19,
            fontWeight: FontWeight.w600,
            color: DarnaColors.textPrimary,
          ),
    );
  }
}
