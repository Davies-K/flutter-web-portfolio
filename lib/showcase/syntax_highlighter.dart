import 'package:flutter/painting.dart';

/// Editor palette: the site's pastels, tuned for a dark background.
class CodeColors {
  static const background = Color(0xFF0F1115);
  static const surface = Color(0xFF161920);
  static const border = Color(0xFF242833);
  static const text = Color(0xFFD7DAE0);
  static const muted = Color(0xFF6B7280);
  static const keyword = Color(0xFFB5C0FD);
  static const string = Color(0xFFA8DCD1);
  static const type = Color(0xFFF3D2BA);
  static const number = Color(0xFFF8B9A8);
  static const comment = Color(0xFF5C6370);
  static const annotation = Color(0xFFE6C07B);
  static const tag = Color(0xFF8FD3E8);
}

/// A small line-based highlighter for Dart and TypeScript/TSX.
///
/// It isn't a full parser, but it handles keywords, strings, comments
/// (including multi-line block comments), numbers, types, annotations
/// and JSX tags, which is plenty for reading code.
class SyntaxHighlighter {
  SyntaxHighlighter({required this.typeScript});

  final bool typeScript;

  static const _dartKeywords = {
    'abstract',
    'as',
    'async',
    'await',
    'break',
    'case',
    'catch',
    'class',
    'const',
    'continue',
    'default',
    'else',
    'enum',
    'extends',
    'false',
    'final',
    'finally',
    'for',
    'get',
    'if',
    'implements',
    'import',
    'in',
    'is',
    'late',
    'mixin',
    'new',
    'null',
    'on',
    'override',
    'part',
    'required',
    'return',
    'sealed',
    'set',
    'static',
    'super',
    'switch',
    'this',
    'throw',
    'true',
    'try',
    'var',
    'void',
    'while',
    'with',
    'yield',
    'export',
    'library',
    'show',
    'hide',
    'typedef',
    'factory',
  };

  static const _tsKeywords = {
    'as',
    'async',
    'await',
    'break',
    'case',
    'catch',
    'class',
    'const',
    'continue',
    'default',
    'else',
    'enum',
    'export',
    'extends',
    'false',
    'for',
    'from',
    'function',
    'if',
    'import',
    'in',
    'interface',
    'let',
    'new',
    'null',
    'of',
    'return',
    'switch',
    'this',
    'throw',
    'true',
    'try',
    'type',
    'typeof',
    'undefined',
    'var',
    'void',
    'while',
    'readonly',
  };

  static final _token = RegExp(
    r'''(//.*$)|(/\*)|("(?:[^"\\]|\\.)*"|'(?:[^'\\]|\\.)*'|`(?:[^`\\]|\\.)*`)|(</?[A-Za-z][\w.]*)|(@\w+)|(\b\d+(?:\.\d+)?\b)|(\b[A-Za-z_$][\w$]*\b)''',
    multiLine: true,
  );

  bool _inBlockComment = false;

  /// Highlights one line, carrying block-comment state to the next call.
  List<TextSpan> line(String source) {
    final spans = <TextSpan>[];
    var index = 0;

    void plain(int end) {
      if (end > index) {
        spans.add(TextSpan(text: source.substring(index, end)));
      }
    }

    while (index < source.length) {
      if (_inBlockComment) {
        final close = source.indexOf('*/', index);
        final end = close == -1 ? source.length : close + 2;
        spans.add(_styled(source.substring(index, end), CodeColors.comment,
            italic: true));
        index = end;
        if (close != -1) _inBlockComment = false;
        continue;
      }

      final match = _token.firstMatch(source.substring(index));
      if (match == null) break;
      final start = index + match.start;
      plain(start);
      final text = match.group(0)!;

      if (match.group(1) != null) {
        spans.add(_styled(text, CodeColors.comment, italic: true));
      } else if (match.group(2) != null) {
        _inBlockComment = true;
        index = start;
        continue;
      } else if (match.group(3) != null) {
        spans.add(_styled(text, CodeColors.string));
      } else if (match.group(4) != null && typeScript) {
        spans.add(_styled(text, CodeColors.tag));
      } else if (match.group(4) != null) {
        // A `<` in Dart is a generic or comparison, not a tag.
        spans.add(
            TextSpan(text: text.substring(0, text.startsWith('</') ? 2 : 1)));
        index = start + (text.startsWith('</') ? 2 : 1);
        continue;
      } else if (match.group(5) != null) {
        spans.add(_styled(text, CodeColors.annotation));
      } else if (match.group(6) != null) {
        spans.add(_styled(text, CodeColors.number));
      } else {
        spans.add(_word(text));
      }
      index = start + text.length;
    }
    plain(source.length);
    return spans;
  }

  TextSpan _word(String word) {
    final keywords = typeScript ? _tsKeywords : _dartKeywords;
    if (keywords.contains(word)) return _styled(word, CodeColors.keyword);
    if (word[0].toUpperCase() == word[0] && word[0] != '_' && word[0] != r'$') {
      return _styled(word, CodeColors.type);
    }
    return TextSpan(text: word);
  }

  TextSpan _styled(String text, Color color, {bool italic = false}) => TextSpan(
        text: text,
        style: TextStyle(
          color: color,
          fontStyle: italic ? FontStyle.italic : FontStyle.normal,
        ),
      );
}
