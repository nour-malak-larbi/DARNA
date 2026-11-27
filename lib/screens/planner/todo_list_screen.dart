import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:darna_app/core/theme/darna_colors.dart';
import 'package:darna_app/widgets/widgets.dart';

/// To-do List screen (`07 — Planner / 13 To-do List`).
class TodoListScreen extends StatefulWidget {
  const TodoListScreen({
    super.key,
    this.onTabSelected,
    this.onAddTask,
  });

  final ValueChanged<DarnaNavTab>? onTabSelected;
  final VoidCallback? onAddTask;

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  static const List<String> _filters = ['Everyone', 'Mine'];
  int _selectedFilter = 0;

  final Set<String> _completed = <String>{
    'Compare electricity statements',
    'Upload rent receipt',
  };

  DarnaNavTab _tab = DarnaNavTab.planner;

  static const List<_TaskData> _todayTasks = [
    _TaskData(
      title: 'Pick up pantry essentials',
      subtitle: 'Today · shopping task · Lina',
      avatar: 'assets/images/todo_list/member_avatar.png',
      assignee: 'Lina',
    ),
  ];

  static const List<_TaskData> _upcomingTasks = [
    _TaskData(
      title: 'Check meter reading',
      subtitle: 'Jun 17 · electricity review · Omar',
      avatar: 'assets/images/todo_list/member_avatar_1.png',
      assignee: 'Omar',
    ),
    _TaskData(
      title: 'Prepare building documents',
      subtitle: 'Jun 19 · home task · Maya',
      avatar: 'assets/images/todo_list/member_avatar_2.png',
      assignee: 'Maya',
    ),
  ];

  static const List<_TaskData> _completedTasks = [
    _TaskData(
      title: 'Compare electricity statements',
      subtitle: 'Completed Jun 12 · Omar',
      avatar: 'assets/images/todo_list/member_avatar_1.png',
      assignee: 'Omar',
    ),
    _TaskData(
      title: 'Upload rent receipt',
      subtitle: 'Completed Jun 01 · Maya',
      avatar: 'assets/images/todo_list/member_avatar_2.png',
      assignee: 'Maya',
    ),
  ];

  void _toggle(String title) {
    setState(() {
      if (_completed.contains(title)) {
        _completed.remove(title);
      } else {
        _completed.add(title);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(24, 4, 24, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildPageHeading(),
                      const SizedBox(height: 8),
                      const Text(
                        'Three things to do. Many hands to help.',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF626B64),
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 12),
                      _buildFilterTabs(),
                      const SizedBox(height: 4),
                      _buildSection(
                        title: 'Today · June 16',
                        tasks: _todayTasks,
                      ),
                      _buildSection(
                        title: 'Upcoming',
                        tasks: _upcomingTasks,
                      ),
                      _buildSection(
                        title: 'Completed',
                        tasks: _completedTasks,
                      ),
                      const SizedBox(height: 4),
                      _buildWinsCard(),
                      const SizedBox(height: 16),
                      _buildAddTaskButton(),
                    ],
                  ),
                ),
              ),
              DarnaBottomNavBar(
                selectedTab: _tab,
                onTabSelected: (t) {
                  setState(() => _tab = t);
                  widget.onTabSelected?.call(t);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPageHeading() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'HOUSEHOLD TO-DO LIST',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF626B64),
                      height: 1.5,
                      letterSpacing: 0.5,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'The little things',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF0F4D46),
                      height: 1.18,
                      letterSpacing: -1,
                    ),
                  ),
                ],
              ),
            ),
            SvgPicture.asset(
              'assets/icons/todo_vector.svg',
              width: 12,
              height: 12,
            ),
          ],
        ),
        Positioned(
          right: 0,
          top: 8,
          child: Image.asset(
            'assets/images/todo_list/artwork_gentle_reminder.png',
            width: 62,
            height: 76,
            fit: BoxFit.contain,
          ),
        ),
      ],
    );
  }

  Widget _buildFilterTabs() {
    return Row(
      children: List.generate(_filters.length, (index) {
        final selected = index == _selectedFilter;
        return Expanded(
          child: GestureDetector(
            onTap: () => setState(() => _selectedFilter = index),
            child: Container(
              height: 38,
              margin: EdgeInsets.only(right: index == _filters.length - 1 ? 0 : 8),
              decoration: BoxDecoration(
                color: selected ? const Color(0xFF0F4D46) : Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: selected ? null : Border.all(color: DarnaColors.border),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x1A062924),
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                  BoxShadow(
                    color: Color(0x38062924),
                    blurRadius: 0,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: Text(
                _filters[index],
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: selected ? FontWeight.w700 : FontWeight.w600,
                  color: selected ? Colors.white : const Color(0xFF626B64),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildSection({
    required String title,
    required List<_TaskData> tasks,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 4),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w700,
              color: Color(0xFF0F4D46),
              height: 1.0,
            ),
          ),
        ),
        ...tasks.map((task) {
          final isLast = task == tasks.last;
          return DarnaTaskRow(
            title: task.title,
            subtitle: task.subtitle,
            isCompleted: _completed.contains(task.title),
            assigneeAvatarAsset: task.avatar,
            assigneeName: task.assignee,
            showDivider: !isLast,
            onToggle: () => _toggle(task.title),
          );
        }),
      ],
    );
  }

  Widget _buildWinsCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0x99FFFFFF)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: const Color(0xFFD4AF37),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  'Small wins count.',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0F4D46),
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          const Text(
            '2 household tasks completed this month. Thanks for keeping things moving.',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: Color(0xFF2E6F63),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddTaskButton() {
    return GestureDetector(
      onTap: widget.onAddTask,
      child: Container(
        height: 52,
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xFF0F4D46),
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Color(0x3B062924),
              blurRadius: 12,
              offset: Offset(0, 8),
            ),
            BoxShadow(
              color: Color(0xF2062924),
              blurRadius: 0,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/icons/plus.svg',
              width: 18,
              height: 18,
              colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
            ),
            const SizedBox(width: 8),
            const Text(
              'Add Task',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TaskData {
  const _TaskData({
    required this.title,
    required this.subtitle,
    required this.avatar,
    required this.assignee,
  });

  final String title;
  final String subtitle;
  final String avatar;
  final String assignee;
}
