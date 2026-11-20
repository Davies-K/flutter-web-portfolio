import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:flutter/widgets.dart';

/// Projects shown in the "Show me the code" panel, each with a preview and
/// a few real source files from its repository (bundled under assets/code).
class ShowcaseData {
  static const projects = [
    ShowcaseProject(
      name: 'Taskez',
      tagline: 'Productivity app UI kit · 970+ stars',
      icon: LucideIcons.layoutDashboard,
      preview: PhonePreview('assets/images/phone_screenshot.png'),
      links: [
        ShowcaseLink('GitHub', 'https://github.com/Davies-K/Taskez'),
      ],
      files: [
        CodeFile('lib/Screens/Dashboard/dashboard.dart',
            'assets/code/taskez_dashboard.dart'),
        CodeFile('lib/Screens/Dashboard/DashboardTabScreens/overview.dart',
            'assets/code/taskez_overview.dart'),
      ],
    ),
    ShowcaseProject(
      name: 'WiT Summit Kenya',
      tagline: 'Event platform · Next.js & TypeScript',
      icon: LucideIcons.users,
      preview: WebPreview('https://summit.womenintechblog.dev'),
      links: [
        ShowcaseLink('Live site', 'https://summit.womenintechblog.dev'),
        ShowcaseLink('GitHub',
            'https://github.com/Tambua-WomenInTech-Blog/witsummitwebsite'),
      ],
      files: [
        CodeFile('src/app/components/promo-card.tsx',
            'assets/code/wit_promo_card.tsx'),
        CodeFile('src/app/components/reserve-marquee.tsx',
            'assets/code/wit_marquee.tsx'),
      ],
    ),
    ShowcaseProject(
      name: 'Minimap Scrollbar',
      tagline: 'Flutter package on pub.dev · live demo',
      icon: LucideIcons.sidebar,
      preview: LivePreview.minimap,
      links: [
        ShowcaseLink('pub.dev', 'https://pub.dev/packages/minimap_scrollbar'),
        ShowcaseLink('GitHub', 'https://github.com/Davies-K/minimap_scrollbar'),
      ],
      files: [
        CodeFile('lib/src/widgets/minimap_scrollbar_widget.dart',
            'assets/code/minimap_widget.dart'),
        CodeFile('lib/src/resources/minimap_image_painter.dart',
            'assets/code/minimap_painter.dart'),
      ],
    ),
    ShowcaseProject(
      name: 'Mini PDF & EPUB Viewer',
      tagline: 'Flutter package on pub.dev',
      icon: LucideIcons.bookOpen,
      preview: PhonePreview(
        'https://raw.githubusercontent.com/Davies-K/mini_pdf_epub_viewer/main/doc/src/assets/example/light_mobile.png',
      ),
      links: [
        ShowcaseLink(
            'pub.dev', 'https://pub.dev/packages/mini_pdf_epub_viewer'),
        ShowcaseLink(
            'GitHub', 'https://github.com/Davies-K/mini_pdf_epub_viewer'),
      ],
      files: [
        CodeFile('example/lib/main.dart', 'assets/code/pdf_example.dart'),
        CodeFile('lib/src/models/document_source.dart',
            'assets/code/pdf_source.dart'),
      ],
    ),
  ];
}

class ShowcaseProject {
  const ShowcaseProject({
    required this.name,
    required this.tagline,
    required this.icon,
    required this.preview,
    required this.links,
    required this.files,
  });

  final String name;
  final String tagline;
  final IconData icon;
  final ShowcasePreview preview;
  final List<ShowcaseLink> links;
  final List<CodeFile> files;
}

class ShowcaseLink {
  const ShowcaseLink(this.label, this.url);

  final String label;
  final String url;
}

class CodeFile {
  const CodeFile(this.path, this.asset);

  final String path;
  final String asset;

  String get name => path.split('/').last;
  bool get isTypeScript => path.endsWith('.ts') || path.endsWith('.tsx');
}

sealed class ShowcasePreview {
  const ShowcasePreview();
}

/// A screenshot inside a phone frame. [image] is an asset path or URL.
class PhonePreview extends ShowcasePreview {
  const PhonePreview(this.image);

  final String image;
}

/// A live website rendered in a browser frame.
class WebPreview extends ShowcasePreview {
  const WebPreview(this.url);

  final String url;
}

/// A live, interactive Flutter demo.
enum LivePreview implements ShowcasePreview { minimap }
