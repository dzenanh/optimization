library(lpSolve)

# Koeffizienten der Zielfunktion
obj <- c(1600,900,700)

# Nebenbedingungen

# Altpapierbeschränkung
lhs <- matrix(c(0.2,0.4,0.9),nrow=1)
rhs <- 12
dir <- "<="

# Walzstrasse-Zeitbeschränkung
lhs <- rbind(lhs,c(6,3,1.75))
rhs <- c(rhs,48)
dir <- c(dir,"<=")


# berechne die Lösung
sol <- lp("max",obj,lhs,dir,rhs,compute.sens=T)

cat("\n\noptimaler Produktionsplan\n")
temp <- matrix(sol$solution)
rownames(temp) <- c("Fein","Mittel","Grob")
colnames(temp) <- "Anzahl"
print(temp)
cat("\nmax. Zielfunktion:",sol$objval,"\n\n")

cat("duale Variablen der Nebenbedingunge (Schattenpreise):\n")
temp <- matrix(sol$duals[1:nrow(lhs)])
rownames(temp) <- paste("g",1:nrow(lhs),sep="")
colnames(temp) <- "lambda"
print(temp)


cat("\nduale Variablen der Variablen (relative Deckungsbeiträge):\n")
temp <- matrix(sol$duals[1:ncol(lhs)+nrow(lhs)])
rownames(temp) <- paste("x",1:ncol(lhs),sep="")
colnames(temp) <- "rel. Deckungsbeitrag"
print(temp)