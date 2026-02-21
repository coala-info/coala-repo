# Code example from 'ggcyto.flowSet' vignette. See references/ for full tutorial.

## ----echo=FALSE---------------------------------------------------------------
knitr::opts_chunk$set(message = FALSE, warning = FALSE)

## -----------------------------------------------------------------------------
library(ggcyto)
data(GvHD)
fs <- GvHD[subset(pData(GvHD), Patient %in%5:7 & Visit %in% c(5:6))[["name"]]]
fr <- fs[[1]]

## -----------------------------------------------------------------------------
p <- ggcyto(fs, aes(x = `FSC-H`)) 
class(p)
is(p, "ggplot")

## -----------------------------------------------------------------------------
p1 <- p + geom_histogram() 
p1

## -----------------------------------------------------------------------------
pData(fs)
p1 + facet_grid(Patient~Visit)

## -----------------------------------------------------------------------------
p + geom_density()

## -----------------------------------------------------------------------------
p + geom_density(fill = "black")

## -----------------------------------------------------------------------------
ggcyto(fs, aes(x = `FSC-H`, fill = name)) + geom_density(alpha = 0.2)

## -----------------------------------------------------------------------------
ggplot(fs, aes(x = `FSC-H`, fill = name)) + geom_density(alpha = 0.2)

## -----------------------------------------------------------------------------
#you can use ggridges package to display stacked density plot
require(ggridges)
#stack by fcs file ('name')
p + geom_density_ridges(aes(y = name)) + facet_null() #facet_null is used to remove the default facet_wrap (by 'name' column)
#or to stack by Visit and facet by patient
p + geom_density_ridges(aes(y = Visit)) + facet_grid(~Patient)

## -----------------------------------------------------------------------------
# 2d hex
p <- ggcyto(fs, aes(x = `FSC-H`, y =  `SSC-H`))
p <- p + geom_hex(bins = 128)
p

## -----------------------------------------------------------------------------
p <- p + ylim(c(10,9e2)) + xlim(c(10,9e2))   
p

## -----------------------------------------------------------------------------
p + scale_fill_gradientn(colours = rainbow(7), trans = "sqrt")

p + scale_fill_gradient(trans = "sqrt", low = "gray", high = "black")


## -----------------------------------------------------------------------------
# estimate a lymphGate (which is an ellipsoidGate) for each sample
lg <- flowStats::lymphGate(fs, channels=c("FSC-H", "SSC-H"),scale=0.6)
# apply the ellipsoidGates to their corresponding samples
fres <- filter(fs, lg)

## -----------------------------------------------------------------------------
p + geom_gate(lg)

## -----------------------------------------------------------------------------
rect.g <- rectangleGate(list("FSC-H" =  c(300,500), "SSC-H" = c(50,200)))
rect.gates <- sapply(sampleNames(fs), function(sn)rect.g)

## -----------------------------------------------------------------------------
p + geom_gate(rect.gates)

## -----------------------------------------------------------------------------
p + geom_gate(rect.gates) + geom_stats(size = 3)

## -----------------------------------------------------------------------------
den.gates.x <- fsApply(fs, openCyto::gate_mindensity, channel = "FSC-H", gate_range = c(100, 300), adjust = 1)
p + geom_gate(den.gates.x) + geom_stats()

## -----------------------------------------------------------------------------
den.gates.y <- fsApply(fs, openCyto::gate_mindensity, channel = "SSC-H", gate_range = c(100, 500), adjust = 1, positive = FALSE)

p + geom_gate(den.gates.y) + geom_stats(value = lapply(rect.gates, function(g)0.1))

## -----------------------------------------------------------------------------
ggcyto(fs, aes(x = `FSC-H`)) + geom_density(fill = "black", aes(y = ..scaled..)) + geom_gate(den.gates.x)  + geom_stats(type = "count")

## -----------------------------------------------------------------------------
p + geom_gate(lg) + geom_gate(rect.gates) + geom_stats(size = 3)

## -----------------------------------------------------------------------------
p + geom_gate(lg) + geom_gate(rect.gates) + geom_stats(gate = lg, size = 3)

## -----------------------------------------------------------------------------
class(p)
class(p$data)

## -----------------------------------------------------------------------------
p <- as.ggplot(p)

class(p)
class(p$data)

