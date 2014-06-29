import MathProgBase.Solution # and EcosSolution, when it lives in its own package
export PrimalDualSolution

Float64OrNothing = Union(Float64,Nothing)

type PrimalDualSolution{T<:FloatingPoint}
  primal::Array{T, 1}
  dual::Array{T, 1} # with indices that correspond to cones in original problem
  status::ASCIIString
  optval::Float64OrNothing
  attrs
end

function PrimalDualSolution(s::Solution)
  attrs = s.attrs
  if :lambda in keys(attrs)  
    attrs[:dual] = true
  else
  	attrs[:dual] = false
  end
  return PrimalDualSolution(s.sol, s.attrs[:lambda], s.status, s.objval, s.attrs)
end

function PrimalDualSolution(s::EcosSolution)
  attrs = {:dual => true}
  return PrimalDualSolution(s.x, vcat(s.y,s.z), s.status, s.optval, attrs)
end