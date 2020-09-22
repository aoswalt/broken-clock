-module(gl_const).
-compile(export_all).

-include_lib("wx/include/gl.hrl").

gl_smooth() ->
  ?GL_SMOOTH.

gl_depth_test() ->
  ?GL_DEPTH_TEST.

gl_lequal() ->
  ?GL_LEQUAL.

gl_perspective_correction_hint() ->
  ?GL_PERSPECTIVE_CORRECTION_HINT.

gl_nicest() ->
  ?GL_NICEST.

gl_color_buffer_bit() ->
  ?GL_COLOR_BUFFER_BIT.

gl_depth_buffer_bit() ->
  ?GL_DEPTH_BUFFER_BIT.

gl_triangles() ->
  ?GL_TRIANGLES.

gl_quads() ->
  ?GL_QUADS.

gl_projection() ->
  ?GL_PROJECTION.

gl_modelview() ->
  ?GL_MODELVIEW.

gl_texture_2d() ->
  ?GL_TEXTURE_2D.

gl_texture_mag_filter() ->
  ?GL_TEXTURE_MAG_FILTER.

gl_texture_min_filter() ->
  ?GL_TEXTURE_MIN_FILTER.

gl_nearest() ->
  ?GL_NEAREST.

gl_clamp() ->
  ?GL_CLAMP.

gl_texture_wrap_s() ->
  ?GL_TEXTURE_WRAP_S.

gl_texture_wrap_t() ->
  ?GL_TEXTURE_WRAP_T.

gl_texture_env() ->
  ?GL_TEXTURE_ENV.

gl_texture_env_mode() ->
  ?GL_TEXTURE_ENV_MODE.

gl_modulate() ->
  ?GL_MODULATE.

gl_rgba() ->
  ?GL_RGBA.

gl_unsigned_byte() ->
  ?GL_UNSIGNED_BYTE.

gl_blend() ->
  ?GL_BLEND.

gl_src_alpha() ->
  ?GL_SRC_ALPHA.

gl_one_minus_src_alpha() ->
  ?GL_ONE_MINUS_SRC_ALPHA.
