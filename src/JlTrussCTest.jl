module JlTrussCTest

module JlTrussC
  using CxxWrap
  @wrapmodule(() -> normpath(joinpath(@__DIR__, "..", "lib","libJlTrussC")))

  function __init__()
    @initcxx
  end
end

function main()
    println(JlTrussC.greet())
end

end # module JlTrussCTest
