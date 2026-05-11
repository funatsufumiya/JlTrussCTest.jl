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

function main()
  setupFn = @cfunction(setup, Cvoid, ())
  JlTrussC.setSetupFn(setupFn)
  JlTrussC.callSetupFn()

  # println(JlTrussC.greet())
  JlTrussC.runTrusscTestApp()
end

end # module JlTrussCTest
