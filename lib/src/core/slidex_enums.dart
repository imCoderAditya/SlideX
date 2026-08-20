/// Core Enums for SlideX Motion Engine.
library;

/// Scroll direction axis.
enum SlideXAxis {
  horizontal,
  vertical,
}

/// Built-in 2D animation effect types.
enum SlideX2DEffectType {
  slide,
  fade,
  zoom,
  scale,
  blur,
  overlay,
  flip,
  stretch,
  reveal,
  liquid,
  parallax,
  elastic,
  bounce,
  curtain,
  morph,
}

/// Built-in 3D perspective animation effect types.
enum SlideX3DEffectType {
  coverflow,
  cube,
  wheel,
  cylinder,
  sphere,
  ring,
  orbit,
  helix,
  stack3d,
  perspective,
  tunnel,
  infinityLoop,
}

/// Indicator types supported by SlideX.
enum SlideXIndicatorType {
  none,
  dot,
  worm,
  expandingDot,
  scale,
  slide,
  number,
  progressLine,
  custom,
}

/// Loop modes for infinite carousels.
enum SlideXLoopMode {
  none,
  infinite,
  rewind,
}

/// Story status states for SlideX.story.
enum SlideXStoryState {
  initial,
  playing,
  paused,
  completed,
}
