module JlTrussCTest

using Printf
using CxxWrap: CxxRef

module TrussC
  using CxxWrap
  @wrapmodule(() -> normpath(joinpath(@__DIR__, "..", "lib","libJlTrussC")))

  function __init__()
    @initcxx
  end

  Vec2Ref = CxxRef{TrussC.Vec2}
  Vec3Ref = CxxRef{TrussC.Vec3}

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

  macro mousePressed(fn)
    return :( TrussC.setMousePressedFn(@cfunction($fn, Cvoid, (TrussC.Vec2Ref, Cint,))) )
  end

  macro mouseReleased(fn)
    return :( TrussC.setMouseReleasedFn(@cfunction($fn, Cvoid, (TrussC.Vec2Ref, Cint,))) )
  end

  macro mouseMoved(fn)
    return :( TrussC.setMouseMovedFn(@cfunction($fn, Cvoid, (TrussC.Vec2Ref,))) )
  end

  macro mouseScrolled(fn)
    return :( TrussC.setMouseScrolledFn(@cfunction($fn, Cvoid, (TrussC.Vec2Ref,))) )
  end

  macro mouseDragged(fn)
    return :( TrussC.setMouseDraggedFn(@cfunction($fn, Cvoid, (TrussC.Vec2Ref, Cint,))) )
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

function mousePressed(pos::TrussC.Vec2Ref, button::Cint)
  println("pos: ", TrussC.x(pos), ", ", TrussC.y(pos), " (", button ,")")
end

function mouseScrolled(delta::TrussC.Vec2Ref)
  println("delta: ", TrussC.x(delta), ", ", TrussC.y(delta))
end

function mouseMoved(pos::TrussC.Vec2Ref)
  println("pos: ", TrussC.x(pos), ", ", TrussC.y(pos))
end

function mouseDragged(pos::TrussC.Vec2Ref, button::Cint)
  println("pos: ", TrussC.x(pos), ", ", TrussC.y(pos), " (", button ,")")
end

function main()
  TrussC.@setup(setup)
  TrussC.@draw(draw)
  TrussC.@keyPressed(keyPressed)
  TrussC.@mousePressed(mousePressed)
  # TrussC.@mouseScrolled(mouseScrolled)
  # TrussC.@mouseMoved(mouseMoved)
  # TrussC.@mouseDragged(mouseDragged)

  # println(TrussC.greet())
  TrussC.runTrusscApp()
end

end # module JlTrussCTest
