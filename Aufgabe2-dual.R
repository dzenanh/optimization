library(lpSolve)

obj <- c(12,48)

lhs <- matrix(c(0.2,0.4,0.9,6,3,1), nrow=3)
rhs <- c(1600,900,700)
dir <- c(">=",">=",">=")

# berechne die Lösung
sol <- lp("min",obj,lhs,dir,rhs,compute.sens=T)

sol$duals

sol$objval

sol$solution