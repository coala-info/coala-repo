# Code example from 'PSEA' vignette. See references/ for full tutorial.

### R code from vignette source 'PSEA.Rnw'

###################################################
### code chunk number 1: style-Sweave
###################################################
BiocStyle::latex()


###################################################
### code chunk number 2: PSEA.Rnw:23-24
###################################################
library(PSEA)


###################################################
### code chunk number 3: PSEA.Rnw:27-28
###################################################
data(example)


###################################################
### code chunk number 4: PSEA.Rnw:31-33
###################################################
expression[1:5,1:3]
groups


###################################################
### code chunk number 5: PSEA.Rnw:38-40
###################################################
neuron_probesets <- list(c("221805_at", "221801_x_at", "221916_at"), "201313_at",
				"210040_at", "205737_at", "210432_s_at")


###################################################
### code chunk number 6: PSEA.Rnw:43-44
###################################################
neuron_reference <- marker(expression, neuron_probesets)


###################################################
### code chunk number 7: PSEA.Rnw:47-54
###################################################
astro_probesets <- list("203540_at", c("210068_s_at", "210906_x_at"), "201667_at")
astro_reference <- marker(expression, astro_probesets)
oligo_probesets <- list(c("211836_s_at", "214650_x_at"), "216617_s_at", "207659_s_at",
			c("207323_s_at", "209072_at"))
oligo_reference <- marker(expression, oligo_probesets)
micro_probesets <- list("204192_at", "203416_at")
micro_reference <- marker(expression, micro_probesets)


###################################################
### code chunk number 8: PSEA.Rnw:57-58
###################################################
groups


###################################################
### code chunk number 9: PSEA.Rnw:61-62
###################################################
neuron_difference <- groups * neuron_reference


###################################################
### code chunk number 10: PSEA.Rnw:65-68
###################################################
astro_difference <- groups * astro_reference
oligo_difference <- groups * oligo_reference
micro_difference <- groups * micro_reference


###################################################
### code chunk number 11: PSEA.Rnw:73-75
###################################################
model1 <- lm(expression["202429_s_at",] ~ neuron_reference + astro_reference +
		oligo_reference + micro_reference, subset=which(groups==0))


###################################################
### code chunk number 12: figModel1
###################################################
par(mfrow=c(2,2), mex=0.8)
crplot(model1, "neuron_reference", newplot=FALSE)
crplot(model1, "astro_reference", newplot=FALSE)
crplot(model1, "oligo_reference", newplot=FALSE)
crplot(model1, "micro_reference", newplot=FALSE)


###################################################
### code chunk number 13: PSEA.Rnw:88-89
###################################################
summary(model1)


###################################################
### code chunk number 14: PSEA.Rnw:94-95
###################################################
model2 <- lm(expression["202429_s_at",] ~ neuron_reference + neuron_difference)


###################################################
### code chunk number 15: figModel2
###################################################
crplot(model2, "neuron_reference", g="neuron_difference", newplot=FALSE)


###################################################
### code chunk number 16: PSEA.Rnw:101-102 (eval = FALSE)
###################################################
## crplot(model2, "neuron_reference", g="neuron_difference")


###################################################
### code chunk number 17: PSEA.Rnw:107-108
###################################################
summary(model2)


###################################################
### code chunk number 18: PSEA.Rnw:111-112
###################################################
foldchange <- (model2$coefficients[2] + model2$coefficients[3]) / model2$coefficients[2]


###################################################
### code chunk number 19: PSEA.Rnw:124-126
###################################################
model_matrix <- fmm(cbind(neuron_reference, astro_reference,	
			oligo_reference, micro_reference), groups)


###################################################
### code chunk number 20: PSEA.Rnw:129-130
###################################################
model_subset <- em_quantvg(c(2,3,4,5), tnv=4, ng=2)


###################################################
### code chunk number 21: PSEA.Rnw:133-134
###################################################
model_subset[[17]]


###################################################
### code chunk number 22: PSEA.Rnw:139-140
###################################################
models <- lmfitst(t(expression), model_matrix, model_subset)


###################################################
### code chunk number 23: PSEA.Rnw:143-144
###################################################
summary(models[[2]][["202429_s_at"]])


###################################################
### code chunk number 24: PSEA.Rnw:147-152
###################################################
regressor_names <- as.character(1:9)
coefficients <- coefmat(models[[2]], regressor_names)
pvalues <- pvalmat(models[[2]], regressor_names)
models_summary <- lapply(models[[2]], summary)
adjusted_R2 <- slt(models_summary, 'adj.r.squared')


###################################################
### code chunk number 25: PSEA.Rnw:155-157
###################################################
average_expression <- apply(expression, 1, mean)
filter <- adjusted_R2 > 0.6 & coefficients[,1] / average_expression < 0.5


###################################################
### code chunk number 26: PSEA.Rnw:160-164
###################################################
filter[match(unlist(c(neuron_probesets, astro_probesets, oligo_probesets, micro_probesets)),
	rownames(expression))] <- FALSE
select <- which(filter & pvalues[, 4] < 0.05)
coefficients[select,]


###################################################
### code chunk number 27: PSEA.Rnw:170-171
###################################################
sessionInfo()


