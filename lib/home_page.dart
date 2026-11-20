import 'package:flutter/material.dart';
import 'package:portfolio/sections/contact_section.dart';
import 'package:portfolio/sections/featured_section.dart';
import 'package:portfolio/sections/header_section.dart';
import 'package:portfolio/sections/nav_bar.dart';
import 'package:portfolio/sections/projects_section.dart';
import 'package:portfolio/sections/resume_section.dart';
import 'package:portfolio/sections/services_section.dart';
import 'package:portfolio/showcase/code_panel.dart';
import 'package:portfolio/utils/responsive.dart';
import 'package:portfolio/widgets/app_drawer.dart';
import 'package:portfolio/widgets/footer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const _navItems = ['Portfolio', 'Services', 'Resume', 'Contact Me'];

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _scrollController = ScrollController();
  final _sectionKeys = List.generate(_navItems.length, (_) => GlobalKey());

  int _selected = 0;
  bool _scrolled = false;
  bool _pastHero = false;

  /// Set while a nav tap is animating, so the scroll spy doesn't flicker
  /// through every section on the way.
  bool _navigating = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final scrolled = _scrollController.offset > 8;
    if (scrolled != _scrolled) setState(() => _scrolled = scrolled);
    final pastHero = _scrollController.offset > 700;
    if (pastHero != _pastHero) setState(() => _pastHero = pastHero);
    if (_navigating) return;

    final position = _scrollController.position;
    var active = 0;
    if (position.pixels >= position.maxScrollExtent - 4) {
      active = _navItems.length - 1;
    } else {
      final threshold = MediaQuery.sizeOf(context).height * 0.35;
      for (var i = 0; i < _sectionKeys.length; i++) {
        final box =
            _sectionKeys[i].currentContext?.findRenderObject() as RenderBox?;
        if (box != null && box.localToGlobal(Offset.zero).dy <= threshold) {
          active = i;
        }
      }
    }
    if (active != _selected) setState(() => _selected = active);
  }

  Future<void> _scrollTo(int index) async {
    final target = _sectionKeys[index].currentContext;
    if (target == null) return;
    setState(() {
      _selected = index;
      _navigating = true;
    });
    await Scrollable.ensureVisible(
      target,
      duration: const Duration(milliseconds: 900),
      curve: Curves.easeInOutCubic,
    );
    _navigating = false;
  }

  @override
  Widget build(BuildContext context) {
    final mobile = Responsive.isMobile(context);
    final spacing = SizedBox(height: mobile ? 96 : 160);

    return Scaffold(
      key: _scaffoldKey,
      drawer: mobile
          ? AppDrawer(
              items: _navItems,
              selected: _selected,
              onSelect: _scrollTo,
            )
          : null,
      body: Stack(
        children: [
          Column(
            children: [
              NavBar(
                items: _navItems,
                selected: _selected,
                elevated: _scrolled,
                onSelect: _scrollTo,
                onMenu: () => _scaffoldKey.currentState?.openDrawer(),
              ),
              Expanded(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    children: [
                      HeaderSection(key: _sectionKeys[0]),
                      spacing,
                      ServicesSection(key: _sectionKeys[1]),
                      spacing,
                      ResumeSection(key: _sectionKeys[2]),
                      spacing,
                      const FeaturedSection(),
                      spacing,
                      const ProjectsSection(),
                      SizedBox(height: mobile ? 48 : 80),
                      ContactSection(key: _sectionKeys[3]),
                      const ContentBox(child: Footer()),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            right: mobile ? 16 : 32,
            bottom: mobile ? 16 : 32,
            child: ShowMeTheCodeFab(visible: _pastHero),
          ),
          const Positioned.fill(child: CodePanel()),
        ],
      ),
    );
  }
}
