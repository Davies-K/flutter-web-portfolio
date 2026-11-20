import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:flutter/widgets.dart';

/// Every piece of copy on the site lives here, so updating the portfolio
/// never means digging through layout code.
class PortfolioData {
  static const name = 'Davies Opoku-Kwarteng';
  static const shortName = 'Kwarteng';
  static const role = 'Snr. Software Engineer';
  static const email = 'john.daves13@gmail.com';
  static const location = 'Berlin, Germany';

  static const githubUrl = 'https://github.com/Davies-K';
  static const twitterUrl = 'https://x.com/SterlinJohn';
  static const linkedInUrl = 'https://www.linkedin.com/in/davies-kwarteng/';
  static const emailUrl = 'mailto:$email?subject=Hello%20Davies';

  static const headline = 'Building digital products, brands, and experience';
  static const headlineUnderlined = 'Building';
  static const intro = 'a Senior Software Engineer in Berlin.\n'
      '8 years building mobile & frontend products with Flutter,\n'
      'NodeJs, and, these days, agentic AI.';

  static const companies = ['ABOUT YOU', 'Qcells', 'Monta', 'Build-Yours'];

  static const services = [
    Service(
      icon: LucideIcons.smartphone,
      title: 'Mobile Apps',
      description:
          'Flutter apps for iOS, Android, web and desktop, architected with BLoC/MVVM, tested, and shipped through CI/CD to both stores.',
      tint: Color(0xFFE9FAFB),
    ),
    Service(
      icon: LucideIcons.monitor,
      title: 'Frontend Platforms',
      description:
          'Next.js & TypeScript products, shared UI libraries and design systems, single sign-on and accessibility built in from day one.',
      tint: Color(0xFFF4F5FC),
    ),
    Service(
      icon: LucideIcons.cpu,
      title: 'AI Integration',
      description:
          'LLM-powered features, MCP integrations and agentic workflows, from speech-to-text pipelines to model-agnostic backends.',
      tint: Color(0xFFFEF1E8),
    ),
  ];

  static const experience = [
    ResumeEntry(
      title: 'ABOUT YOU',
      subtitle: 'Senior Mobile Engineer · Hamburg',
      period: 'August 2025 - September 2026',
      url: 'https://www.aboutyou.de',
    ),
    ResumeEntry(
      title: 'Qcells',
      subtitle: 'Senior Frontend Engineer → Team Lead · Berlin',
      period: 'July 2024 - August 2025',
      url: 'https://www.q-cells.com',
    ),
  ];

  static const previously = [
    ResumeEntry(
      title: 'Monta',
      subtitle: 'Snr. Flutter Engineer · Berlin',
      period: 'July 2022 - July 2024',
      url: 'https://monta.com',
    ),
    ResumeEntry(
      title: 'Build-Yours.De',
      subtitle: 'Lead Mobile Engineer (Part-Time) · Hamburg',
      period: 'July 2022 - June 2024',
      url: 'https://build-yours.de',
    ),
  ];

  static const skills = {
    'Mobile': [
      'Flutter & Dart',
      'BLoC, MVVM, MVC',
      'BLE & MQTT',
      'Device-farm performance testing',
      'Android & SwiftUI',
    ],
    'Frontend & Backend': [
      'Next.js & TypeScript',
      'Angular & Vue',
      'REST, BFF & microservices',
      'SQL, Firebase, Supabase',
      'AWS & Docker',
    ],
    'AI & Craft': [
      'Agentic AI & Claude Code',
      'MCP integrations',
      'LLM pipelines & Whisper',
      'CI/CD, Fastlane, Codemagic',
      'English & German (B1)',
    ],
  };

  static const featured = FeaturedProject(
    title: 'Taskez',
    description:
        'A productivity mobile application UI kit built with Flutter. What started as a design exercise became my most-starred open-source project, used by developers around the world as a reference for clean, animated Flutter UI.',
    image: 'assets/images/phone_screenshot.png',
    url: 'https://github.com/Davies-K/Taskez',
    stat: '970+ stars on GitHub',
  );

  static const projects = [
    Project(
      title: 'WiT Summit Kenya',
      description:
          'The official open-source website for the Women In Tech Summit Kenya 2025, powered by Tambua Women In Tech.',
      tags: ['Next.js', 'TypeScript', 'Community'],
      icon: LucideIcons.users,
      color: Color(0xFFFEF1E8),
      url: 'https://github.com/Tambua-WomenInTech-Blog/witsummitwebsite',
    ),
    Project(
      title: 'Minimap Scrollbar',
      description:
          'A Flutter package on pub.dev that adds a VS Code-style minimap for navigating large scrollable content.',
      tags: ['pub.dev', 'Flutter package'],
      icon: LucideIcons.sidebar,
      color: Color(0xFFF4F5FC),
      url: 'https://pub.dev/packages/minimap_scrollbar',
    ),
    Project(
      title: 'Mini PDF & EPUB Viewer',
      description:
          'A Flutter package on pub.dev for viewing PDF and EPUB documents from assets, files or the network.',
      tags: ['pub.dev', 'Flutter package'],
      icon: LucideIcons.bookOpen,
      color: Color(0xFFE9FAFB),
      url: 'https://pub.dev/packages/mini_pdf_epub_viewer',
    ),
    Project(
      title: 'Incident Responder',
      description:
          'Angular app that uses Mapbox and Firebase for incident responding, tracking and monitoring.',
      tags: ['Angular', 'Mapbox', 'Firebase'],
      icon: LucideIcons.mapPin,
      color: Color(0xFFEAF5EF),
      url: 'https://github.com/Davies-K/angular-mapbox-policeapp',
    ),
  ];
}

class Service {
  const Service({
    required this.icon,
    required this.title,
    required this.description,
    required this.tint,
  });

  final IconData icon;
  final String title;
  final String description;
  final Color tint;
}

class ResumeEntry {
  const ResumeEntry({
    required this.title,
    required this.subtitle,
    required this.period,
    this.url,
  });

  final String title;
  final String subtitle;
  final String period;
  final String? url;
}

class FeaturedProject {
  const FeaturedProject({
    required this.title,
    required this.description,
    required this.image,
    required this.url,
    required this.stat,
  });

  final String title;
  final String description;
  final String image;
  final String url;
  final String stat;
}

class Project {
  const Project({
    required this.title,
    required this.description,
    required this.tags,
    required this.icon,
    required this.color,
    required this.url,
  });

  final String title;
  final String description;
  final List<String> tags;
  final IconData icon;
  final Color color;
  final String url;
}
