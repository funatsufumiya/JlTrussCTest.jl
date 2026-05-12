module JlTrussCTest

module JlTrussC
  using CxxWrap
  @wrapmodule(() -> normpath(joinpath(@__DIR__, "..", "lib","libJlTrussC")))

  function __init__()
    @initcxx
  end
end

function setup()
  println("setup!")
end

function keyPressed(key::Cint)
  c = Char(key)
  println("key: ", c, " (", key ,")")
end

function main()
  JlTrussC.setSetupFn(@cfunction(setup, Cvoid, ()))
  JlTrussC.setKeyPressedFn(@cfunction(keyPressed, Cvoid, (Cint,)))

  # println(JlTrussC.greet())
  JlTrussC.runTrusscApp()
end

end # module JlTrussCTest
