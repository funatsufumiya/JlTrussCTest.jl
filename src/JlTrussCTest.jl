module JlTrussCTest

module TrussC
  using CxxWrap
  @wrapmodule(() -> normpath(joinpath(@__DIR__, "..", "lib","libJlTrussC")))

  function __init__()
    @initcxx
  end
end # module TrussC

function setup()
  println("setup!")
end

function draw()
  TrussC.clear(0.12)

  # Rotating box
  TrussC.noFill();
  TrussC.translate(TrussC.getWindowWidth() / 2, TrussC.getWindowHeight() / 2);
  TrussC.rotate(TrussC.getElapsedTimef() * 0.1, TrussC.getElapsedTimef() * 0.15, 0);
  TrussC.drawBox(200.0);
end

function keyPressed(key::Cint)
  c = Char(key)
  println("key: ", c, " (", key ,")")
end

function main()
  TrussC.setSetupFn(@cfunction(setup, Cvoid, ()))
  TrussC.setKeyPressedFn(@cfunction(keyPressed, Cvoid, (Cint,)))

  # println(TrussC.greet())
  TrussC.runTrusscApp()
end

end # module JlTrussCTest
