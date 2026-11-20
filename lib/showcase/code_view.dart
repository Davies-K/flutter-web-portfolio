import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:portfolio/showcase/showcase_data.dart';
import 'package:portfolio/showcase/syntax_highlighter.dart';
import 'package:portfolio/widgets/custom_cursor.dart';

/// An editor-style viewer for a project's source files.
class CodeView extends StatefulWidget {
  const CodeView({super.key, required this.files});

  final List<CodeFile> files;

  @override
  State<CodeView> createState() => _CodeViewState();
}

class _CodeViewState extends State<CodeView> {
  static final _cache = <String, Future<String>>{};

  int _selected = 0;

  CodeFile get _file => widget.files[_selected];

  Future<String> _load(CodeFile file) =>
      _cache.putIfAbsent(file.asset, () => rootBundle.loadString(file.asset));

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          height: 40,
          decoration: const BoxDecoration(
            color: CodeColors.surface,
            border: Border(bottom: BorderSide(color: CodeColors.border)),
          ),
          child: Row(
            children: [
              Expanded(
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    for (var i = 0; i < widget.files.length; i++)
                      _FileTab(
                        name: widget.files[i].name,
                        selected: i == _selected,
                        onTap: () => setState(() => _selected = i),
                      ),
                  ],
                ),
              ),
              FutureBuilder<String>(
                future: _load(_file),
                builder: (context, snapshot) =>
                    _CopyButton(text: snapshot.data),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 6),
          child: Text(
            _file.path,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.jetBrainsMono(
                fontSize: 11, color: CodeColors.muted),
          ),
        ),
        Expanded(
          child: FutureBuilder<String>(
            future: _load(_file),
            builder: (context, snapshot) {
              final source = snapshot.data;
              if (source == null) return const SizedBox.shrink();
              return _CodeLines(
                key: ValueKey(_file.asset),
                source: source,
                typeScript: _file.isTypeScript,
              );
            },
          ),
        ),
      ],
    );
  }
}

class _FileTab extends StatelessWidget {
  const _FileTab({
    required this.name,
    required this.selected,
    required this.onTap,
  });

  final String name;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Clickable(
      onTap: onTap,
      semanticLabel: name,
      builder: (context, hovered) => AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? CodeColors.background : Colors.transparent,
          border: Border(
            top: BorderSide(
              width: 2,
              color: selected ? CodeColors.keyword : Colors.transparent,
            ),
            right: const BorderSide(color: CodeColors.border),
          ),
        ),
        child: Text(
          name,
          style: GoogleFonts.jetBrainsMono(
            fontSize: 12,
            color: selected || hovered ? CodeColors.text : CodeColors.muted,
          ),
        ),
      ),
    );
  }
}

class _CopyButton extends StatefulWidget {
  const _CopyButton({required this.text});

  final String? text;

  @override
  State<_CopyButton> createState() => _CopyButtonState();
}

class _CopyButtonState extends State<_CopyButton> {
  bool _copied = false;

  Future<void> _copy() async {
    final text = widget.text;
    if (text == null) return;
    await Clipboard.setData(ClipboardData(text: text));
    if (!mounted) return;
    setState(() => _copied = true);
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) setState(() => _copied = false);
  }

  @override
  Widget build(BuildContext context) {
    return Clickable(
      onTap: _copy,
      semanticLabel: 'Copy code',
      builder: (context, hovered) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: Row(
            key: ValueKey(_copied),
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                _copied ? LucideIcons.check : LucideIcons.copy,
                size: 14,
                color: _copied
                    ? CodeColors.string
                    : (hovered ? CodeColors.text : CodeColors.muted),
              ),
              const SizedBox(width: 6),
              Text(
                _copied ? 'Copied' : 'Copy',
                style: GoogleFonts.jetBrainsMono(
                  fontSize: 12,
                  color: _copied
                      ? CodeColors.string
                      : (hovered ? CodeColors.text : CodeColors.muted),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Highlighted source with line numbers; the first screenful cascades in.
class _CodeLines extends StatefulWidget {
  const _CodeLines({super.key, required this.source, required this.typeScript});

  final String source;
  final bool typeScript;

  @override
  State<_CodeLines> createState() => _CodeLinesState();
}

class _CodeLinesState extends State<_CodeLines>
    with SingleTickerProviderStateMixin {
  static const _cascadeLines = 40;

  late final List<List<TextSpan>> _lines;
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 900),
  )..forward();

  @override
  void initState() {
    super.initState();
    final highlighter = SyntaxHighlighter(typeScript: widget.typeScript);
    _lines = widget.source
        .replaceAll('\t', '  ')
        .split('\n')
        .map(highlighter.line)
        .toList();
    if (_lines.isNotEmpty && _lines.last.isEmpty) _lines.removeLast();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final style = GoogleFonts.jetBrainsMono(
      fontSize: 12.5,
      height: 1.7,
      color: CodeColors.text,
    );
    final gutterWidth = '${_lines.length}'.length * 8.0 + 16;

    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 32),
      itemCount: _lines.length,
      itemBuilder: (context, i) {
        final row = Padding(
          padding: const EdgeInsets.only(right: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: gutterWidth,
                child: Text(
                  '${i + 1}',
                  textAlign: TextAlign.right,
                  style: style.copyWith(color: CodeColors.comment),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Text.rich(TextSpan(children: _lines[i]), style: style),
              ),
            ],
          ),
        );
        if (i >= _cascadeLines) return row;
        final start = math.min(i * 0.015, 0.6);
        final animation = CurvedAnimation(
          parent: _controller,
          curve: Interval(start, start + 0.4, curve: Curves.easeOut),
        );
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween(
              begin: const Offset(0.02, 0),
              end: Offset.zero,
            ).animate(animation),
            child: row,
          ),
        );
      },
    );
  }
}
