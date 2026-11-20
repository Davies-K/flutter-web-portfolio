import 'package:flutter/widgets.dart';
import 'package:web/web.dart' as web;

/// Renders [url] at a desktop width and scales it down to fit, so the
/// preview shows the real desktop layout as a live thumbnail.
///
/// Pointer events are disabled on the iframe: it would otherwise swallow
/// mouse input and strand the custom cursor at its edge.
class IframeView extends StatefulWidget {
  const IframeView({super.key, required this.url, this.desktopWidth = 1280});

  final String url;
  final double desktopWidth;

  @override
  State<IframeView> createState() => _IframeViewState();
}

class _IframeViewState extends State<IframeView> {
  web.HTMLIFrameElement? _iframe;
  Size _size = Size.zero;

  void _applySize() {
    final iframe = _iframe;
    if (iframe == null || _size.isEmpty) return;
    final scale = _size.width / widget.desktopWidth;
    iframe.style
      ..width = '${widget.desktopWidth}px'
      ..height = '${_size.height / scale}px'
      ..transform = 'scale($scale)';
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        _size = constraints.biggest;
        WidgetsBinding.instance.addPostFrameCallback((_) => _applySize());
        return HtmlElementView.fromTagName(
          tagName: 'div',
          onElementCreated: (element) {
            final container = element as web.HTMLDivElement;
            container.style
              ..overflow = 'hidden'
              ..width = '100%'
              ..height = '100%';
            final iframe = web.HTMLIFrameElement()
              ..src = widget.url
              ..setAttribute('loading', 'lazy')
              ..setAttribute('tabindex', '-1')
              ..setAttribute('title', 'Live preview of ${widget.url}');
            iframe.style
              ..border = 'none'
              ..pointerEvents = 'none'
              ..transformOrigin = '0 0'
              ..backgroundColor = 'white';
            container.append(iframe);
            _iframe = iframe;
            _applySize();
          },
        );
      },
    );
  }
}
