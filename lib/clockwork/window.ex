defmodule Clockwork.Window do
  @moduledoc """
  From https://wtfleming.github.io/2016/01/06/getting-started-opengl-elixir/
  """

  @behaviour :wx_object

  use Bitwise

  @title 'Clockwork'
  @size {600, 600}

  def start_link() do
    :wx_object.start_link(__MODULE__, [], [])
  end

  def init(config) do
    wx = :wx.new(config)
    frame = :wxFrame.new(wx, :wx_const.wx_id_any(), @title, [{:size, @size}])
    :wxWindow.connect(frame, :close_window)
    :wxFrame.show(frame)

    opts = [{:size, @size}]

    gl_attrib = [
      {:attribList,
       [
         :wx_const.wx_gl_rgba(),
         :wx_const.wx_gl_doublebuffer(),
         :wx_const.wx_gl_min_red(),
         8,
         :wx_const.wx_gl_min_green(),
         8,
         :wx_const.wx_gl_min_blue(),
         8,
         :wx_const.wx_gl_depth_size(),
         24,
         0
       ]}
    ]
    canvas = :wxGLCanvas.new(frame, opts ++ gl_attrib)

    :wxGLCanvas.connect(canvas, :size)
    :wxWindow.reparent(canvas, frame)
    :wxGLCanvas.setCurrent(canvas)
    setup_gl(canvas)

    timer = :timer.send_interval(20, self(), :update)

    {frame, %{canvas: canvas, timer: timer}}
  end

  def code_change(_, _, _state) do
    {:error, :not_implemented}
  end

  def handle_cast(msg, state) do
    IO.inspect(msg, label: "Cast:")
    {:noreply, state}
  end

  def handle_call(msg, _from, state) do
    IO.inspect(msg, label: "Call:")
    {:reply, :ok, state}
  end

  def handle_info(:stop, state) do
    :timer.cancel(state.timer.timer.timer.timer)
    :wxGLCanvas.destroy(state.canvas)
    {:stop, :normal, state}
  end

  def handle_info(:update, state) do
    :wx.batch(fn -> render(state) end)
    {:noreply, state}
  end

  # unhandled info
  # {:_egl_error_, 5088, :no_gl_context}

  # Example input:
  # {:wx, -2006, {:wx_ref, 35, :wxFrame, []}, [], {:wxClose, :close_window}}
  def handle_event({:wx, _, _, _, {:wxClose, :close_window}}, state) do
    {:stop, :normal, state}
  end

  def handle_event({:wx, _, _, _, {:wxSize, :size, {width, height}, _}}, state) do
    if width != 0 and height != 0 do
      resize_gl_scene(width, height)
    end
    {:noreply, state}
  end

  def terminate(_reason, state) do
    :wxGLCanvas.destroy(state.canvas)
    :timer.cancel(state.timer)
    :timer.sleep(300)
  end

  defp setup_gl(win) do
    {w, h} = :wxWindow.getClientSize(win)
    resize_gl_scene(w, h)
    :gl.shadeModel(:gl_const.gl_smooth())
    :gl.clearColor(0.0, 0.0, 0.0, 0.0)
    :gl.clearDepth(1.0)
    :gl.enable(:gl_const.gl_depth_test())
    :gl.depthFunc(:gl_const.gl_lequal())
    :gl.hint(:gl_const.gl_perspective_correction_hint(), :gl_const.gl_nicest())
    :ok
  end

  defp resize_gl_scene(width, height) do
    :gl.viewport(0, 0, width, height)
    :gl.matrixMode(:gl_const.gl_projection())
    :gl.loadIdentity()
    :glu.perspective(45.0, width / height, 0.1, 100.0)
    :gl.matrixMode(:gl_const.gl_modelview())
    :gl.loadIdentity()
    :ok
  end

  defp draw() do
    now = :os.system_time(:millisecond) / 500
    offset = :math.sin(now)

    :gl.clear(Bitwise.bor(:gl_const.gl_color_buffer_bit(), :gl_const.gl_depth_buffer_bit()))
    :gl.loadIdentity()
    :gl.translatef(-1.5, 0.0, -6.0)
    :gl.begin(:gl_const.gl_triangles())
    :gl.vertex3f(0.0, 1.0 + offset, 0.0)
    :gl.vertex3f(-1.0, -1.0 + offset, 0.0)
    :gl.vertex3f(1.0, -1.0 + offset, 0.0)
    :gl.end()
    :ok
  end

  defp render(%{canvas: canvas} = _state) do
    draw()
    :wxGLCanvas.swapBuffers(canvas)
    :ok
  end
end
