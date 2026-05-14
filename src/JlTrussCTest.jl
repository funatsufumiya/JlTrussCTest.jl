module JlTrussCTest

using Printf
using CxxWrap: CxxRef, StdVector

module TrussC
  using CxxWrap
  @wrapmodule(() -> normpath(joinpath(@__DIR__, "..", "lib","libJlTrussC")))

  function __init__()
    @initcxx
  end

  Vec2Ref = CxxRef{TrussC.Vec2}
  Vec3Ref = CxxRef{TrussC.Vec3}
  FilesRef = CxxRef{StdVector{StdString}}

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

  macro windowResized(fn)
    return :( TrussC.setWindowResizedFn(@cfunction($fn, Cvoid, (Cint, Cint,))) )
  end

  macro filesDropped(fn)
    return :( TrussC.setFilesDroppedFn(@cfunction($fn, Cvoid, (TrussC.FilesRef,))) )
  end

  macro exit(fn)
    return :( TrussC.setExitFn(@cfunction($fn, Cvoid, ())) )
  end

end # module TrussC

Base.:+(x::TrussC.Vec2, y::TrussC.Vec2) = TrussC.add(x, y)
Base.:*(x::TrussC.Vec2, y::TrussC.Vec2) = TrussC.mul(x, y)
Base.:/(x::TrussC.Vec2, y::TrussC.Vec2) = TrussC.div(x, y)
Base.:-(x::TrussC.Vec2, y::TrussC.Vec2) = TrussC.sub(x, y)
Base.:(==)(x::TrussC.Vec2, y::TrussC.Vec2) = TrussC.eq(x, y)
Base.:+(x::TrussC.Vec2, y::Number) = TrussC.add(x, y)
Base.:*(x::TrussC.Vec2, y::Number) = TrussC.mul(x, y)
Base.:/(x::TrussC.Vec2, y::Number) = TrussC.div(x, y)
Base.:-(x::TrussC.Vec2, y::Number) = TrussC.sub(x, y)
Base.:+(y::Number, x::TrussC.Vec2) = TrussC.add(x, y)
Base.:*(y::Number, x::TrussC.Vec2) = TrussC.mul(x, y)

Base.:+(x::TrussC.Vec3, y::TrussC.Vec3) = TrussC.add(x, y)
Base.:*(x::TrussC.Vec3, y::TrussC.Vec3) = TrussC.mul(x, y)
Base.:/(x::TrussC.Vec3, y::TrussC.Vec3) = TrussC.div(x, y)
Base.:-(x::TrussC.Vec3, y::TrussC.Vec3) = TrussC.sub(x, y)
Base.:(==)(x::TrussC.Vec3, y::TrussC.Vec3) = TrussC.eq(x, y)
Base.:+(x::TrussC.Vec3, y::Number) = TrussC.add(x, y)
Base.:*(x::TrussC.Vec3, y::Number) = TrussC.mul(x, y)
Base.:/(x::TrussC.Vec3, y::Number) = TrussC.div(x, y)
Base.:-(x::TrussC.Vec3, y::Number) = TrussC.sub(x, y)
Base.:+(y::Number, x::TrussC.Vec3) = TrussC.add(x, y)
Base.:*(y::Number, x::TrussC.Vec3) = TrussC.mul(x, y)

Base.:+(x::TrussC.Vec4, y::TrussC.Vec4) = TrussC.add(x, y)
Base.:-(x::TrussC.Vec4, y::TrussC.Vec4) = TrussC.sub(x, y)
Base.:(==)(x::TrussC.Vec4, y::TrussC.Vec4) = TrussC.eq(x, y)
Base.:+(x::TrussC.Vec4, y::Number) = TrussC.add(x, y)
Base.:*(x::TrussC.Vec4, y::Number) = TrussC.mul(x, y)
Base.:/(x::TrussC.Vec4, y::Number) = TrussC.div(x, y)
Base.:-(x::TrussC.Vec4, y::Number) = TrussC.sub(x, y)
Base.:+(y::Number, x::TrussC.Vec4) = TrussC.add(x, y)
Base.:*(y::Number, x::TrussC.Vec4) = TrussC.mul(x, y)

Base.:*(x::TrussC.Mat4, y::TrussC.Mat4) = TrussC.mul(x, y)
Base.:*(x::TrussC.Mat4, y::TrussC.Vec4) = TrussC.mul(x, y)
Base.:*(x::TrussC.Mat4, y::TrussC.Vec3) = TrussC.mul(x, y)
Base.:(==)(x::TrussC.Mat4, y::TrussC.Mat4) = TrussC.eq(x, y)

Base.:(==)(x::TrussC.Quaternion, y::TrussC.Quaternion) = TrussC.eq(x, y)

Base.show(io::IO, v::TrussC.Vec2) = print(io, "Vec2(",TrussC.x(v),", ",TrussC.y(v),")")
Base.show(io::IO, v::TrussC.Vec3) = print(io, "Vec3(",TrussC.x(v),", ",TrussC.y(v),", ",TrussC.z(v),")")
Base.show(io::IO, v::TrussC.Vec4) = print(io, "Vec4(",TrussC.x(v),", ",TrussC.y(v),", ",TrussC.z(v),", ",TrussC.w(v),")")
Base.show(io::IO, v::TrussC.Quaternion) = print(io, "Quaternion(",TrussC.w(v),", ",TrussC.x(v),", ",TrussC.y(v),", ",TrussC.z(v),")")
Base.show(io::IO, v::TrussC.Color) = print(io, "Color(",TrussC.r(v),", ",TrussC.g(v),", ",TrussC.b(v),", ",TrussC.a(v),")")

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

function windowResized(width::Cint, height::Cint)
  println("window resized: ", width, ", ", height)
end

function filesDropped(files::TrussC.FilesRef)
  println("files dropped length: ", length(files))
  for file in files
    println("file: ", file)
  end
end

function main()
  TrussC.@setup(setup)
  TrussC.@draw(draw)
  TrussC.@keyPressed(keyPressed)
  TrussC.@mousePressed(mousePressed)
  # TrussC.@mouseScrolled(mouseScrolled)
  # TrussC.@mouseMoved(mouseMoved)
  # TrussC.@mouseDragged(mouseDragged)
  TrussC.@windowResized(windowResized)
  TrussC.@filesDropped(filesDropped)

  # println(TrussC.greet())
  TrussC.runTrusscApp()
end

end # module JlTrussCTest
