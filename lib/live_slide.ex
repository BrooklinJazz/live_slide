defmodule LiveSlide do
  @moduledoc """
  LiveSlide is a custom slideshow component for Livebook.
  """

  use Kino.JS
  use Kino.JS.Live

  @doc """
  Create a new `LiveSlide` widget.
  """
  @spec new(any) :: Kino.JS.Live.t()
  def new(slides) do
    frame = Kino.Frame.new()
    Kino.render(frame)
    Kino.Frame.render(frame, Enum.at(slides, 0))
    Kino.JS.Live.new(__MODULE__, %{slides: slides, frame: frame})
  end

  @doc """
  Highlight text as an elixir cell in markdown.

  ## Examples

    iex> %Kino.Markdown{} = LiveSlide.elixir("1 + 1")
    iex> %Kino.Markdown{} = LiveSlide.elixir("title", "1 + 1")
  """
  def elixir(title \\ "", string) do
    Kino.Markdown.new("
#{title}
```elixir
#{string}
```
    ")
  end

  @impl true
  def init(%{slides: slides, frame: frame}, ctx) do
    {:ok, assign(ctx, slides: slides, frame: frame)}
  end

  @impl true
  def handle_connect(ctx) do
    {:ok, length(ctx.assigns.slides), ctx}
  end

  @impl true
  def handle_event("render_slide", slide_number, ctx) do
    {:noreply, render_slide(ctx, slide_number)}
  end

  defp render_slide(ctx, slide_number) do
    current_slide = Enum.at(ctx.assigns.slides, slide_number)
    Kino.Frame.render(ctx.assigns.frame, current_slide)
    ctx
  end

  asset "main.js" do
    """

    export function init(ctx, slide_count) {
      ctx.importCSS("main.css");
      ctx.importCSS("/css/app.css");

      for (let i = 0; i < slide_count; i++) {
        ctx.root.innerHTML += `
          <button class="button-base button-gray" id="slide${i}">${i}</button>
          `
      }

      for (let i = 0; i < slide_count; i++) {
        document.getElementById("slide" + i.toString()).addEventListener("click", (event) => {
          ctx.pushEvent("render_slide", i);
        });
      }
    }
    """
  end
end
