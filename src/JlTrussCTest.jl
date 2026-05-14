module JlTrussCTest

using Printf

module TrussC
  using CxxWrap
  @wrapmodule(() -> normpath(joinpath(@__DIR__, "..", "lib","libJlTrussC")))

  function __init__()
    @initcxx
  end

  macro setup(fn)
    return :( TrussC.setSetupFn(@cfunction($fn, Cvoid, ())) )
  end

  macro update(fn)
    return :( TrussC.setUpdateFn(@cfunction($fn, Cvoid, ())) )
  end

  macro draw(fn)
    return :( TrussC.setDrawFn(@cfunction($fn, Cvoid, ())) )
  end

  macro keyPressed(fn)
    return :( TrussC.setKeyPressedFn(@cfunction($fn, Cvoid, (Cint,))) )
  end

  macro keyReleased(fn)
    return :( TrussC.setKeyReleasedFn(@cfunction($fn, Cvoid, (Cint,))) )
  end

end # module TrussC

function setup()
  println("setup!")

  TrussC.setFps(60.0f0)
end

function draw()
  TrussC.clear(0.12f0, 1.0f0)

  # Rotating box
  TrussC.pushMatrix();
  TrussC.noFill();
  TrussC.translate(TrussC.getWindowWidth() / 2.0f0, TrussC.getWindowHeight() / 2.0f0);
  TrussC.rotate(Float32(TrussC.getElapsedTimef() * 0.1f0), Float32(TrussC.getElapsedTimef() * 0.15f0), 0.0f0);
  TrussC.drawBox(200.0f0);
  TrussC.popMatrix();

  # show fps
  TrussC.drawBitmapString(@sprintf("fps: %.1f", TrussC.getFps()), 30f0, 30f0);
end

function keyPressed(key::Cint)
  c = Char(key)
  println("key: ", c, " (", key ,")")
end

function main()
  TrussC.@setup(setup)
  TrussC.@draw(draw)
  TrussC.@keyPressed(keyPressed)

  # println(TrussC.greet())
  TrussC.runTrusscApp()
end

end # module JlTrussCTest
