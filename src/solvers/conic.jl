import MathProgBase.coneprog

export 
    solve 

function solve(cp::ConicProblem, method)
  coneprog(cp, method)
end