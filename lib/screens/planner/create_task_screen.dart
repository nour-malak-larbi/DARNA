import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:darna_app/core/theme/darna_colors.dart';

/// Create Task / Event screen (`07 — Planner / Create Task/Event`).
class CreateTaskScreen extends StatefulWidget {
  const CreateTaskScreen({
    super.key,
    this.onBack,
    this.onSaveTask,
  });

  final VoidCallback? onBack;
  final VoidCallback? onSaveTask;

  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  final _titleController = TextEditingController(text: 'Check meter reading');
  final _typeController = TextEditingController(text: 'Task');
  final _dateController = TextEditingController(text: 'June 17, 2026');
  final _assigneeController = TextEditingController(text: 'Omar');
  final _notesController = TextEditingController(text: '');

  @override
  void dispose() {
    _titleController.dispose();
    _typeController.dispose();
    _dateController.dispose();
    _assigneeController.dispose();
    _notesController.dispose();
    super.dispose();
  }

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
              _buildHeading(),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildFormCard(),
                      const SizedBox(height: 14),
                      _buildInfoAlert(),
                    ],
                  ),
                ),
              ),
              _buildActionFooter(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeading() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 12),
      child: Row(
        children: [
          GestureDetector(
            onTap: widget.onBack,
            behavior: HitTestBehavior.opaque,
            child: SizedBox(
              width: 30,
              height: 40,
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
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'LARBI  HOUSEHOLD · PLANNER',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: DarnaColors.textSecondary,
                    height: 1.5,
                    letterSpacing: 0.5,
                  ),
                ),
                const Text(
                  'Create task',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                    color: DarnaColors.primary,
                    height: 1.18,
                    letterSpacing: -0.8,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: DarnaColors.border),
        boxShadow: DarnaColors.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _formField('Task · event title', _titleController),
          const SizedBox(height: 14),
          _formField('Type', _typeController),
          const SizedBox(height: 14),
          _formField('Date', _dateController),
          const SizedBox(height: 14),
          _formField('Assignee', _assigneeController),
          const SizedBox(height: 14),
          _formField(
            'Notes · optional',
            _notesController,
            maxLines: true,
          ),
        ],
      ),
    );
  }

  Widget _formField(
    String label,
    TextEditingController controller, {
    bool maxLines = false,
  }) {
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
            maxLines: maxLines ? 3 : 1,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: DarnaColors.textPrimary,
              height: 1.5,
            ),
            decoration: const InputDecoration(
              border: InputBorder.none,
              isDense: true,
              contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 13),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoAlert() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: DarnaColors.infoBackground,
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
                  'Household task, not a provider payment',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF345A71),
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Save the task to your household plan. Nothing moves money.',
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

  Widget _buildActionFooter() {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(24, 14, 24, 8),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 50,
            decoration: const BoxDecoration(
              color: DarnaColors.primary,
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            alignment: Alignment.center,
            child: InkWell(
              onTap: widget.onSaveTask,
              child: const Text(
                'Create Task',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: DarnaColors.ivory,
                ),
              ),
            ),
          ),
          Container(
            width: 112,
            height: 4,
            decoration: BoxDecoration(
              color: DarnaColors.textPrimary,
              borderRadius: BorderRadius.all(Radius.circular(100)),
            ),
          ),
        ],
      ),
    );
  }
}
