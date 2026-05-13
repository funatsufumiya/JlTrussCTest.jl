module JlTrussCTest

using Printf

module TrussC
  using CxxWrap
  @wrapmodule(() -> normpath(joinpath(@__DIR__, "..", "lib","libJlTrussC")))

  function __init__()
    @initcxx
  end
end # module TrussC

f32(d::Float64) = Float32(d)
f32(d::Int64) = Float32(d)
f32(d::Int32) = Float32(d)

function setup()
  println("setup!")
end

function draw()
  TrussC.clear(f32(0.12), f32(1.0))

  # Rotating box
  TrussC.pushMatrix();
  TrussC.noFill();
  TrussC.translate(f32(TrussC.getWindowWidth() / 2), f32(TrussC.getWindowHeight() / 2));
  TrussC.rotate(f32(TrussC.getElapsedTimef() * 0.1), f32(TrussC.getElapsedTimef() * 0.15), f32(0));
  TrussC.drawBox(f32(200.0));
  TrussC.popMatrix();

  # show fps
  TrussC.drawBitmapString(@sprintf("fps: %.1f", TrussC.getFps()), f32(30), f32(30));
end

function keyPressed(key::Cint)
  c = Char(key)
  println("key: ", c, " (", key ,")")
end

function main()
  TrussC.setSetupFn(@cfunction(setup, Cvoid, ()))
  TrussC.setDrawFn(@cfunction(draw, Cvoid, ()))
  TrussC.setKeyPressedFn(@cfunction(keyPressed, Cvoid, (Cint,)))

  # println(TrussC.greet())
  TrussC.runTrusscApp()
end

end # module JlTrussCTest
