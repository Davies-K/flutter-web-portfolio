import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:minimap_scrollbar/minimap_scrollbar.dart';
import 'package:portfolio/showcase/iframe_view.dart';
import 'package:portfolio/showcase/showcase_data.dart';
import 'package:portfolio/showcase/syntax_highlighter.dart';

class ShowcasePreviewView extends StatelessWidget {
  const ShowcasePreviewView({super.key, required this.preview});

  final ShowcasePreview preview;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: switch (preview) {
        PhonePreview(:final image) => _PhoneFrame(image: image),
        WebPreview(:final url) => _BrowserFrame(
            url: url,
            child: IframeView(url: url),
          ),
        LivePreview.minimap => const _BrowserFrame(
            url: 'minimap_scrollbar · live demo',
            child: _MinimapDemo(),
          ),
      },
    );
  }
}

class _PhoneFrame extends StatelessWidget {
  const _PhoneFrame({required this.image});

  final String image;

  @override
  Widget build(BuildContext context) {
    final isNetwork = image.startsWith('http');
    return Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(36),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.5),
              blurRadius: 40,
              offset: const Offset(0, 20),
            ),
          ],
        ),
        child: isNetwork
            ? ClipRRect(
                borderRadius: BorderRadius.circular(28),
                child: Image.network(
                  image,
                  fit: BoxFit.contain,
                  loadingBuilder: (context, child, progress) => progress == null
                      ? child
                      : const SizedBox(
                          width: 220,
                          height: 440,
                          child: Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: CodeColors.muted,
                            ),
                          ),
                        ),
                ),
              )
            : Image.asset(image, fit: BoxFit.contain),
      ),
    );
  }
}

class _BrowserFrame extends StatelessWidget {
  const _BrowserFrame({required this.url, required this.child});

  final String url;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: CodeColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: CodeColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.4),
            blurRadius: 30,
            offset: const Offset(0, 16),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Container(
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Row(
              children: [
                const Icon(LucideIcons.lock, size: 12, color: CodeColors.muted),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    url.replaceFirst('https://', ''),
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.jetBrainsMono(
                      fontSize: 12,
                      color: CodeColors.muted,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: CodeColors.border),
          Expanded(child: child),
        ],
      ),
    );
  }
}

/// A real [MinimapScrollbarWidget] from the package, scrolling a mock article.
class _MinimapDemo extends StatelessWidget {
  const _MinimapDemo();

  static const _tints = [
    Color(0xFFE9FAFB),
    Color(0xFFF4F5FC),
    Color(0xFFFEF1E8),
    Color(0xFFEAF5EF),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // The widget sizes its viewport from the screen size, so give it a
        // MediaQuery that matches this preview box instead.
        final media = MediaQuery.of(context);
        return MediaQuery(
          data: media.copyWith(size: constraints.biggest),
          child: ColoredBox(
            color: Colors.white,
            child: MinimapScrollbarWidget(
              headrHeight: 0,
              miniSize: 72,
              highlightColor: const Color(0xFF6C7CF5),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (var i = 0; i < 14; i++) _section(i),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _section(int i) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Section ${i + 1}',
            style: GoogleFonts.roboto(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF1A1A1A),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            height: 70.0 + (i % 3) * 40,
            decoration: BoxDecoration(
              color: _tints[i % _tints.length],
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          const SizedBox(height: 10),
          for (var line = 0; line < 3; line++)
            Container(
              margin: const EdgeInsets.only(bottom: 6),
              height: 8,
              width: line == 2 ? 140 : double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFFE5E6EB),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
        ],
      ),
    );
  }
}
