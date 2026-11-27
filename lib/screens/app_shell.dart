import 'package:flutter/material.dart';
import 'package:darna_app/core/user/darna_user.dart';
import 'package:darna_app/widgets/widgets.dart';
import 'bills/bills_screens.dart';
import 'dashboard/dashboard_screens.dart';
import 'family/family_screens.dart';
import 'home/home_screen.dart';
import 'planner/planner_screens.dart';
import 'profile/profile_screens.dart';
import 'salary/salary_screens.dart';

/// Root shell that switches between the five primary destinations.
class AppShell extends StatefulWidget {
  const AppShell({super.key, this.user});

  final DarnaUser? user;

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  DarnaNavTab _tab = DarnaNavTab.home;

  void _select(DarnaNavTab tab) {
    if (tab == _tab) return;
    setState(() => _tab = tab);
  }

  void _editIncome() {
    _push(
      SalaryDistributionScreen(
        onBack: () => Navigator.of(context).pop(),
        onEditIncome: _editIncome,
        onEditAllocation: _editAllocation,
        onEditAll: _editAll,
      ),
    );
  }

  void _editAllocation() {
    _push(
      SalaryDistributionScreen(
        onBack: () => Navigator.of(context).pop(),
        onEditIncome: _editIncome,
        onEditAllocation: _editAllocation,
        onEditAll: _editAll,
      ),
    );
  }

  void _editAll() {
    _push(
      SalaryDistributionScreen(
        onBack: () => Navigator.of(context).pop(),
        onEditIncome: _editIncome,
        onEditAllocation: _editAllocation,
        onEditAll: _editAll,
      ),
    );
  }

  Future<void> _push(Widget screen) {
    return Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => screen),
    );
  }

  void _openAllBills() {
    _push(
      AllBillsScreen(
        onBack: () => Navigator.of(context).pop(),
        onBillTap: () => _push(
          BillDetailsScreen(onBack: () => Navigator.of(context).pop()),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return switch (_tab) {
      DarnaNavTab.home => HomeScreen(
          onTabSelected: _select,
          onAllBills: _openAllBills,
          onAddObligation: _openAllBills,
          onReviewBill: () => _push(
            BillDetailsScreen(onBack: () => Navigator.of(context).pop()),
          ),
          onOpenPlanner: () => _select(DarnaNavTab.planner),
          onOpenFamilySpace: () => _select(DarnaNavTab.family),
          onOpenTodoList: () => _select(DarnaNavTab.planner),
          onOpenSalary: () => _push(
            SalaryDistributionScreen(
              onBack: () => Navigator.of(context).pop(),
              onEditIncome: _editIncome,
              onEditAllocation: _editAllocation,
              onEditAll: _editAll,
            ),
          ),
        ),
      DarnaNavTab.dashboard => DashboardScreen(
          onTabSelected: _select,
          onAllBills: _openAllBills,
          onViewFinancialDetails: () => _push(
            FinancialDetailsScreen(
              onBack: () => Navigator.of(context).pop(),
              onViewAllBills: _openAllBills,
              onSalaryDistribution: () => _push(
                SalaryDistributionScreen(
                  onBack: () => Navigator.of(context).pop(),
                ),
              ),
            ),
          ),
        ),
      DarnaNavTab.family => FamilySpaceScreen(
          onTabSelected: _select,
          onAllBills: _openAllBills,
          onTodoList: () => _select(DarnaNavTab.planner),
        ),
      DarnaNavTab.planner => TodoListScreen(
          onTabSelected: _select,
          onAddTask: () => _push(
            CreateTaskScreen(
              onBack: () => Navigator.of(context).pop(),
              onSaveTask: () => _push(
                TaskCreatedScreen(
                  onBack: () => Navigator.of(context).pop(),
                  onBackToTodoList: () => Navigator.of(context).pop(),
                ),
              ),
            ),
          ),
        ),
      DarnaNavTab.profile => ProfileScreen(
          user: widget.user,
          onTabSelected: _select,
          onOpenFamilySpace: () => _select(DarnaNavTab.family),
          onSettings: () => _push(
            SettingsScreen(onBack: () => Navigator.of(context).pop()),
          ),
        ),
    };
  }
}
