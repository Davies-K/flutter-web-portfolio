import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:portfolio/showcase/code_view.dart';
import 'package:portfolio/showcase/previews.dart';
import 'package:portfolio/showcase/showcase_data.dart';
import 'package:portfolio/showcase/syntax_highlighter.dart';
import 'package:portfolio/utils/url_utils.dart';
import 'package:portfolio/widgets/custom_cursor.dart';

/// Opens and closes the "Show me the code" panel from anywhere on the page.
class ShowcaseController {
  ShowcaseController._();
  static final instance = ShowcaseController._();

  /// The open project's index, or null while the panel is closed.
  final ValueNotifier<int?> project = ValueNotifier(null);

  void open([int index = 0]) => project.value = index;
  void close() => project.value = null;
}

/// A side panel listing top projects, each with a live preview and its code.
class CodePanel extends StatefulWidget {
  const CodePanel({super.key});

  @override
  State<CodePanel> createState() => _CodePanelState();
}

class _CodePanelState extends State<CodePanel>
    with SingleTickerProviderStateMixin {
  final _controller = ShowcaseController.instance;
  late final AnimationController _animation = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 450),
    reverseDuration: const Duration(milliseconds: 300),
  );
  late final Animation<double> _curve = CurvedAnimation(
    parent: _animation,
    curve: Curves.easeOutCubic,
    reverseCurve: Curves.easeInCubic,
  );
  final _focusNode = FocusNode();

  int _project = 0;
  bool _showCode = false;

  @override
  void initState() {
    super.initState();
    _controller.project.addListener(_onChange);
  }

  @override
  void dispose() {
    _controller.project.removeListener(_onChange);
    _animation.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onChange() {
    final index = _controller.project.value;
    if (index == null) {
      CursorController.instance.onDark.value = false;
      _animation.reverse();
    } else {
      setState(() => _project = index);
      _animation.forward();
      _focusNode.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, _) {
        if (_animation.isDismissed) return const SizedBox.shrink();
        final screen = MediaQuery.sizeOf(context);
        final width = screen.width < 760 ? screen.width : 720.0;
        return KeyboardListener(
          focusNode: _focusNode,
          onKeyEvent: (event) {
            if (event is KeyDownEvent &&
                event.logicalKey == LogicalKeyboardKey.escape) {
              _controller.close();
            }
          },
          child: Stack(
            children: [
              Positioned.fill(
                child: GestureDetector(
                  onTap: _controller.close,
                  child: FadeTransition(
                    opacity: _curve,
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                      child: ColoredBox(
                        color: Colors.black.withValues(alpha: 0.35),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 0,
                bottom: 0,
                right: 0,
                width: width,
                child: SlideTransition(
                  position: Tween(
                    begin: const Offset(1, 0),
                    end: Offset.zero,
                  ).animate(_curve),
                  child: MouseRegion(
                    onEnter: (_) =>
                        CursorController.instance.onDark.value = true,
                    onExit: (_) =>
                        CursorController.instance.onDark.value = false,
                    child: _panel(),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _panel() {
    final project = ShowcaseData.projects[_project];
    return Material(
      color: CodeColors.background,
      elevation: 24,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _header(),
            _projectTabs(),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 16),
              child: Wrap(
                alignment: WrapAlignment.spaceBetween,
                crossAxisAlignment: WrapCrossAlignment.center,
                runSpacing: 12,
                spacing: 12,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        project.name,
                        style: GoogleFonts.roboto(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        project.tagline,
                        style: GoogleFonts.lato(
                            fontSize: 13, color: CodeColors.muted),
                      ),
                    ],
                  ),
                  _ModeToggle(
                    showCode: _showCode,
                    onChanged: (code) => setState(() => _showCode = code),
                  ),
                ],
              ),
            ),
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (child, animation) => FadeTransition(
                  opacity: animation,
                  child: SlideTransition(
                    position: Tween(
                      begin: const Offset(0, 0.02),
                      end: Offset.zero,
                    ).animate(animation),
                    child: child,
                  ),
                ),
                child: KeyedSubtree(
                  key: ValueKey('$_project-$_showCode'),
                  child: _showCode
                      ? CodeView(files: project.files)
                      : ShowcasePreviewView(preview: project.preview),
                ),
              ),
            ),
            _links(project),
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return Container(
      height: 52,
      padding: const EdgeInsets.only(left: 20, right: 8),
      decoration: const BoxDecoration(
        color: CodeColors.surface,
        border: Border(bottom: BorderSide(color: CodeColors.border)),
      ),
      child: Row(
        children: [
          for (final color in const [
            Color(0xFFFF5F57),
            Color(0xFFFEBC2E),
            Color(0xFF28C840),
          ])
            Container(
              width: 12,
              height: 12,
              margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              '~/davies/show-me-the-code',
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.jetBrainsMono(
                  fontSize: 12, color: CodeColors.muted),
            ),
          ),
          Clickable(
            onTap: _controller.close,
            semanticLabel: 'Close',
            builder: (context, hovered) => AnimatedRotation(
              turns: hovered ? 0.25 : 0,
              duration: const Duration(milliseconds: 250),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Icon(
                  LucideIcons.x,
                  size: 18,
                  color: hovered ? Colors.white : CodeColors.muted,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _projectTabs() {
    return Container(
      height: 56,
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: CodeColors.border)),
      ),
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        children: [
          for (var i = 0; i < ShowcaseData.projects.length; i++)
            Clickable(
              onTap: () => setState(() => _project = i),
              semanticLabel: ShowcaseData.projects[i].name,
              builder: (context, hovered) {
                final selected = i == _project;
                final color = selected
                    ? Colors.white
                    : (hovered ? CodeColors.text : CodeColors.muted);
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(),
                      Row(
                        children: [
                          Icon(ShowcaseData.projects[i].icon,
                              size: 14, color: color),
                          const SizedBox(width: 8),
                          Text(
                            ShowcaseData.projects[i].name,
                            style: GoogleFonts.lato(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: color,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.easeOutCubic,
                        height: 2,
                        width: selected ? 32 : 0,
                        color: CodeColors.keyword,
                      ),
                    ],
                  ),
                );
              },
            ),
        ],
      ),
    );
  }

  Widget _links(ShowcaseProject project) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: CodeColors.border)),
      ),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          for (final link in project.links)
            Clickable(
              onTap: () => openUrl(link.url),
              semanticLabel: link.label,
              builder: (context, hovered) => AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: hovered ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                      color: hovered ? Colors.white : CodeColors.border),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      link.label,
                      style: GoogleFonts.lato(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color:
                            hovered ? CodeColors.background : CodeColors.text,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Icon(
                      LucideIcons.arrowUpRight,
                      size: 14,
                      color: hovered ? CodeColors.background : CodeColors.text,
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// A two-option segmented control with a sliding highlight.
class _ModeToggle extends StatelessWidget {
  const _ModeToggle({required this.showCode, required this.onChanged});

  final bool showCode;
  final ValueChanged<bool> onChanged;

  static const _segment = 96.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      width: _segment * 2 + 10,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: CodeColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: CodeColors.border),
      ),
      child: Stack(
        children: [
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutCubic,
            left: showCode ? _segment : 0,
            top: 0,
            bottom: 0,
            width: _segment,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),
          Row(
            children: [
              _option('Preview', LucideIcons.eye, !showCode, false),
              _option('Code', LucideIcons.code, showCode, true),
            ],
          ),
        ],
      ),
    );
  }

  Widget _option(String label, IconData icon, bool selected, bool code) {
    final color = selected ? CodeColors.background : CodeColors.muted;
    return SizedBox(
      width: _segment,
      child: Clickable(
        onTap: () => onChanged(code),
        semanticLabel: label,
        builder: (context, _) => FittedBox(
          fit: BoxFit.scaleDown,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 14, color: color),
              const SizedBox(width: 6),
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                style: GoogleFonts.lato(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: color,
                ),
                child: Text(label),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// "Show me the code →" as an inline link, used in the hero and work section.
class ShowMeTheCodeLink extends StatelessWidget {
  const ShowMeTheCodeLink({super.key, this.prefix, this.color});

  final String? prefix;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final base = GoogleFonts.lato(fontSize: 15, color: color ?? Colors.black87);
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (prefix != null) Text(prefix!, style: base),
        Clickable(
          onTap: ShowcaseController.instance.open,
          semanticLabel: 'Show me the code',
          builder: (context, hovered) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Show me the code',
                      style: base.copyWith(fontWeight: FontWeight.w900)),
                  AnimatedPadding(
                    duration: const Duration(milliseconds: 200),
                    padding: EdgeInsets.only(left: hovered ? 10 : 6),
                    child:
                        Icon(Icons.arrow_forward, size: 16, color: base.color),
                  ),
                ],
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeOutCubic,
                height: 1.5,
                width: hovered ? 132 : 0,
                color: base.color,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// A floating pill that opens the panel, shown once the hero scrolls away.
class ShowMeTheCodeFab extends StatelessWidget {
  const ShowMeTheCodeFab({super.key, required this.visible});

  final bool visible;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int?>(
      valueListenable: ShowcaseController.instance.project,
      builder: (context, open, _) {
        final show = visible && open == null;
        return AnimatedSlide(
          offset: show ? Offset.zero : const Offset(0, 2),
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOutCubic,
          child: AnimatedOpacity(
            opacity: show ? 1 : 0,
            duration: const Duration(milliseconds: 300),
            child: IgnorePointer(
              ignoring: !show,
              child: Clickable(
                onTap: ShowcaseController.instance.open,
                semanticLabel: 'Show me the code',
                builder: (context, hovered) => AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black
                            .withValues(alpha: hovered ? 0.35 : 0.2),
                        blurRadius: hovered ? 28 : 18,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AnimatedRotation(
                        turns: hovered ? -0.08 : 0,
                        duration: const Duration(milliseconds: 250),
                        child: const Icon(LucideIcons.codeXml,
                            size: 18, color: Colors.white),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Show me the code',
                        style: GoogleFonts.lato(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
