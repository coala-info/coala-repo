# Code example from 'edge' vignette. See references/ for full tutorial.

## ----foo,cache=FALSE,include=FALSE,echo=FALSE----
library(edge)
options(keep.source = TRUE, width = 48)
foo <- packageDescription("edge")

## ----citepackage,cache=FALSE------------------
citation("edge")

## ----help_edge--------------------------------
help(package="edge")

## ----qs_load_data, cache=TRUE-----------------
library(edge)
data(kidney)
age <- kidney$age
sex <- kidney$sex
kidexpr <- kidney$kidexpr

## ----qs_build_study, echo=TRUE, cache=TRUE----
de_obj <- build_study(data = kidexpr, adj.var = sex, tme = age, sampling = "timecourse")
full_model <- fullModel(de_obj)
null_model <- nullModel(de_obj)

## ----qs_build_models, echo=TRUE, cache=TRUE----
library(splines)
cov <- data.frame(sex = sex, age = age)
null_model <- ~sex
full_model <- ~sex + ns(age, df=4)
de_obj <- build_models(data = kidexpr, cov = cov, null.model = null_model, full.model = full_model)

## ----qs_eSet, dependson="qs_build_models", cache=TRUE----
# optimal discovery procedure
de_odp <- odp(de_obj, bs.its = 50, verbose=FALSE)
# likelihood ratio test
de_lrt <- lrt(de_obj)

## ----qs_qval, dependson="qs_eSet", cache=TRUE----
qval_obj <- qvalueObj(de_odp)
qvals <- qval_obj$qvalues
pvals <- qval_obj$pvalues
lfdr <- qval_obj$lfdr
pi0 <- qval_obj$pi0

## ----gibson_import_data-----------------------
data(gibson)
gibexpr <- gibson$gibexpr
batch <- gibson$batch
gender <- gibson$gender
location <- gibson$location

## ----fig.height=4, fig.width=8, echo=FALSE, cache=TRUE, dependson="gibson_import_data"----
library(ggplot2)
gender <- as.factor(as.matrix(gender) )
location = as.factor(as.matrix(location))
batch = as.factor(as.matrix(batch))
qplot(location, gibexpr[1,], geom="point", colour=gender:batch, xlab= "location", ylab="expression")

## ----gibson_build_study, dependson="gibson_import_data", cache=TRUE----
de_obj <- build_study(data = gibexpr, adj.var = cbind(gender, batch), grp = location, sampling = "static")

## ----gibson_build_models, dependson="gibson_import_data", cache=TRUE----
cov <- data.frame(Gender = gender, Batch = batch, Location = location)
null_model <- ~Gender + Batch
null_model <- ~Gender + Batch + Location
de_obj <- build_models(data = gibexpr, cov = cov, full.model = null_model, null.model = null_model)

## ----gibson_deSet_slotNames-------------------
slotNames(de_obj)

## ----gibson_ExpressionSet---------------------
gibexpr <- exprs(de_obj)
cov <- pData(de_obj)

## ----gibson_models, dependson="gibson_build_models"----
fullModel(de_obj)
nullModel(de_obj)

## ----gibson_matrix, eval=TRUE, dependson="gibson_build_models"----
full_matrix <- fullMatrix(de_obj)
null_matrix <- nullMatrix(de_obj)

## ----fig.height=4, fig.width=8, echo=FALSE, cache = TRUE, dependson=c("gibson_import_data")----
library(ggplot2)
library(reshape2)
de_obj <- build_study(data = gibexpr, adj.var = cbind(gender, batch), grp = location, sampling = "static")
ef_obj <- fit_models(de_obj)
fitVals <- fitFull(ef_obj)
fitVals0 <- fitNull(ef_obj)
gender <- as.factor(gender)
location = as.matrix(location)
batch = as.factor(batch)
df <- data.frame(batch = batch, gender = gender, location = location, null.model = fitVals0[1,], full.model = fitVals[1,], raw = exprs(de_obj)[1,])
df <- melt(data = df, id.vars=c("batch", "location", "gender"))
ggplot(df, aes(location, value, color=gender:batch), xlab="location", ylab="expression") + geom_point() + facet_wrap(~variable)

## ----gibson_fit_models, dependson="gibson_build_models"----
ef_obj <- fit_models(de_obj, stat.type="lrt")

## ----gibson_betacoef, eval=FALSE, dependson="gibson_fit_models"----
# betaCoef(ef_obj)

## ----gibson_residuals, eval=FALSE, dependson="gibson_fit_models"----
# alt_res <- resFull(ef_obj)
# null_res <- resNull(ef_obj)

## ----gibson_fitted, dependson="gibson_fit_models"----
alt_fitted <- fitFull(ef_obj)
null_fitted <- fitNull(ef_obj)

## ----gibson_lrt, cache=TRUE-------------------
de_lrt <- lrt(de_obj, nullDistn="normal")

## ----gibson_odp, eval=TRUE, cache=TRUE--------
de_odp <- odp(de_obj, bs.its = 50, verbose = FALSE, n.mods = 50)

## ----fig.width=8, fig.height=4, echo=FALSE, dependson="gibson_odp"----
sig_results <- qvalueObj(de_odp)
hist(sig_results)

## ----dependson = "gibson_odp", cache=TRUE-----
summary(de_odp)

## ----gibson_sig, dependson="gibson_odp", cache=TRUE----
sig_results <- qvalueObj(de_odp)

## ---------------------------------------------
names(sig_results)

## ----eval=FALSE-------------------------------
# hist(sig_results)

## ---------------------------------------------
pvalues <- sig_results$pvalues
qvalues <- sig_results$qvalues
lfdr <- sig_results$lfdr
pi0 <- sig_results$pi0

## ----gibGene1, dependson="gibson_sig"---------
qvalues[1]

## ----gibSig, dependson="qvalob2_gib"----------
fdr.level <- 0.01
sigGenes <- qvalues < fdr.level

## ----fig.height=4, fig.width=8, echo=FALSE----
library(ggplot2)
data(kidney)
age <- kidney$age
sex <- kidney$sex
kidexpr <- kidney$kidexpr
qplot(age, kidexpr[5,], geom="point", colour=sex, xlab= "age", ylab="expression")

## ----kidney_import_data-----------------------
data(kidney)
age <- kidney$age
sex <- kidney$sex
kidexpr <- kidney$kidexpr

## ----kidney_build_study, dependson="kidney_variables", cache=TRUE----
de_obj <- build_study(data = kidexpr, adj.var = sex, tme = age, sampling = "timecourse", basis.df = 4)

## ----dependson="kidney_build_study", cache=TRUE----
fullModel(de_obj)
nullModel(de_obj)

## ----kidney_build_models, dependson="import_data_kid", cache=TRUE----
library(splines)
cov <- data.frame(sex = sex, age = age)
null_model <- ~sex
null_model <- ~sex + ns(age, df=4)
de_obj <- build_models(data = kidexpr, cov = cov, full.model = null_model, null.model = null_model)

## ---------------------------------------------
slotNames(de_obj)

## ---------------------------------------------
gibexpr <- exprs(de_obj)
cov <- pData(de_obj)

## ----eval = FALSE, dependson="kidney_build_models"----
# fullModel(de_obj)
# nullModel(de_obj)

## ----eval = FALSE, dependson="kidney_build_models"----
# full_matrix <- fullMatrix(de_obj)
# null_matrix <- nullMatrix(de_obj)

## ----fig.height=4, fig.width=8, echo=FALSE, cache = TRUE, dependson=c("kidney_import_data")----
library(ggplot2)
library(reshape2)
de_obj <- build_study(data = kidexpr, adj.var = sex, tme = age, sampling = "timecourse", basis.df=4)
ef_obj <- fit_models(de_obj)
fitVals <- fitFull(ef_obj)
fitVals0 <- fitNull(ef_obj)


df <- data.frame(age= age, sex=sex, null.model = fitVals0[5,], full.model = fitVals[5,], raw = exprs(de_obj)[5,])
df <- melt(data = df, id.vars=c("age", "sex"))
ggplot(df, aes(age, value, color=sex), xlab="age", ylab="expression") + geom_point() + facet_wrap(~variable)

## ----kidney_fit_models, dependson="kidney_build_models"----
ef_obj <- fit_models(de_obj, stat.type="lrt")

## ----eval=FALSE, dependson="kidney_fit_models"----
# betaCoef(ef_obj)

## ----eval=FALSE, dependson="kidney_fit_models"----
# alt_res <- resFull(ef_obj)
# null_res <- resNull(ef_obj)

## ----eval=FALSE, dependson="kidney_fit_models"----
# alt_fitted <- fitFull(ef_obj)
# null_fitted <- fitNull(ef_obj)

## ----echo=FALSE-------------------------------
library(splines)

## ----kidney_lrt, eval=TRUE, cache=FALSE, dependson="kidney_build_models"----
de_lrt <- lrt(de_obj, nullDistn="normal")

## ----echo=FALSE-------------------------------
library(splines)

## ----kidney_odp, eval=TRUE, cache=TRUE, dependson="kidney_build_models"----
de_odp <- odp(de_obj, bs.its = 50, verbose = FALSE, n.mods = 50)

## ----dependson = "kidney_odp"-----------------
summary(de_odp)

## ---------------------------------------------
sig_results <- qvalueObj(de_odp)

## ---------------------------------------------
names(sig_results)

## ----eval=FALSE-------------------------------
# hist(sig_results)

## ----fig.width=8, fig.height=4, echo=FALSE, dependson="kidney_sig"----
hist(sig_results)

## ----kidney_extract, dependson="kidney_sig"----
pvalues <- sig_results$pvalues
qvalues <- sig_results$qvalues
lfdr <- sig_results$lfdr
pi0 <- sig_results$pi0

## ----kidneyprint, dependson="kidney_extract"----
qvalues[5]

## ----dependson="kidney_extract"---------------
fdr.level <- 0.1
sigGenes <- qvalues < fdr.level

## ----endotoxin_import_data--------------------
data(endotoxin)
endoexpr <- endotoxin$endoexpr
class <- endotoxin$class
ind <- endotoxin$ind
time <- endotoxin$time

## ----fig.height=4, fig.width=8, echo=FALSE, cache=TRUE, dependson="endotoxin_import_data"----
library(ggplot2)

qplot(time, endoexpr[2,], geom="point", colour=class, xlab= "time (hours)", ylab="expression")

## ----endotoxin_build_study, dependson="endotoxin_import_data", cache=TRUE----
de_obj <- build_study(data = endoexpr, grp = class, tme = time, ind = ind, sampling = "timecourse")

## ----endotoxin_emodels------------------------
fullModel(de_obj)
nullModel(de_obj)

## ----endotoxin_build_models, dependson="endotoxin_import_data"----
cov <- data.frame(ind = ind, tme = time, grp = class)
null_model <- ~grp + ns(tme, df = 2, intercept = FALSE)
null_model <- ~grp + ns(tme, df = 2, intercept = FALSE) + (grp):ns(tme, df = 2, intercept = FALSE)
de_obj <- build_models(data = endoexpr, cov = cov, full.model = null_model, null.model = null_model)

## ----endotoxin_slotNames----------------------
slotNames(de_obj)

## ---------------------------------------------
gibexpr <- exprs(de_obj)
cov <- pData(de_obj)

## ----endotoxin_models, dependson="endotoxin_build_models"----
fullModel(de_obj)
nullModel(de_obj)

## ----endotoxin_matrix, eval=TRUE, dependson="endotoxin_build_models"----
full_matrix <- fullMatrix(de_obj)
null_matrix <- nullMatrix(de_obj)

## ----endotoxin_fit_models, dependson="endotoxin_build_models"----
ef_obj <- fit_models(de_obj, stat.type="lrt")

## ----fig.height=4, fig.width=8, echo=FALSE, cache=TRUE, dependson=c("endotoxin_import_data")----
library(ggplot2)
library(reshape2)
#endoexpr <- endoexpr - rowMeans(endoexpr)
de_obj <- build_study(data = endoexpr, grp = class, tme = time, ind = ind, sampling = "timecourse", basis.df=2)
ef_obj <- fit_models(de_obj)
fitVals <- fitFull(ef_obj)
fitVals0 <- fitNull(ef_obj)

id=2
df <- data.frame(class= class, tme=time, ind=ind, null.model = fitVals0[id,], full.model = fitVals[id,])
df <- melt(data = df, id.vars=c("class", "tme", "ind"))
ggplot(df, aes(tme, value, color=class), xlab="time (hours)", ylab="expression") + geom_smooth(se=FALSE) + facet_wrap(~variable)

## ----eval=FALSE, dependson="endotoxin_fit_models"----
# betaCoef(ef_obj)

## ----eval=FALSE, dependson="endotoxin_fit_models"----
# alt_res <- resFull(ef_obj)
# null_res <- resNull(ef_obj)

## ----dependson="endotoxin_fit_models"---------
alt_fitted <- fitFull(ef_obj)
null_fitted <- fitNull(ef_obj)

## ----endotoxin_lrt, eval=TRUE, cache=FALSE, dependson="endotoxin_build_models"----
de_lrt <- lrt(de_obj, nullDistn="normal")

## ----endotoxin_odp, eval=TRUE, cache=TRUE, dependson="endotoxin_build_models"----
de_odp <- odp(de_obj, bs.its = 50, verbose = FALSE, n.mods = 50)

## ----dependson = "endotoxin_odp"--------------
summary(de_odp)

## ----endotoxin_sig----------------------------
sig_results <- qvalueObj(de_odp)

## ----endotoxin_sigNames-----------------------
names(sig_results)

## ----fig.width=8, fig.height=4, echo=FALSE, dependson="endotoxin_sig"----
hist(sig_results)

## ----endotoxin_hist,eval=FALSE----------------
# hist(sig_results)

## ----endotoxin_extract, dependson="endotoxin_sig"----
pvalues <- sig_results$pvalues
qvalues <- sig_results$qvalues
lfdr <- sig_results$lfdr
pi0 <- sig_results$pi0

## ----endotoxinprint, dependson="endotoxin_extract"----
qvalues[2]

## ----endotoxin_sigList, dependson="endotoxin_extract"----
fdr.level <- 0.1
sigGenes <- qvalues < fdr.level

## ----build_models_kidsva, dependson="import_data_kidney", cache=TRUE----
library(splines)
cov <- data.frame(sex = sex, age = age)
null_model <- ~sex
full_model <- ~sex + ns(age, df=4)
de_obj <- build_models(data = kidexpr, cov = cov, full.model = full_model, null.model = null_model)

## ----sva, dependson="build_models_kidsva"-----
de_sva <- apply_sva(de_obj, n.sv = 3, B = 10)

## ----sva_terms, dependson="sva"---------------
fullModel(de_sva)
nullModel(de_sva)

## ----sva_accessSV-----------------------------
cov <- pData(de_sva)
names(cov)
surrogate.vars <- cov[, 3:ncol(cov)]

## ----sva_odp, dependson="sva"-----------------
de_odp <- odp(de_sva, bs.its = 50, verbose = FALSE)
de_lrt <- lrt(de_sva, verbose = FALSE)
summary(de_odp)

## ----sva_eres---------------------------------
qval_obj <- qvalueObj(de_odp)
qvals <- qval_obj$qvalues
lfdr <- qval_obj$lfdr
pvals <- qval_obj$pvalues
pi0 <- qval_obj$pi0

## ----build_study_kidqval, dependson="import_data_kidney", cache=TRUE----
# create models
library(splines)
cov <- data.frame(sex = sex, age = age)
null_model <- ~sex
full_model <- ~sex + ns(age, df=4)
de_obj <- build_models(data = kidexpr, cov = cov, full.model = full_model, null.model = null_model)
# run significance analysis
de_obj <- odp(de_obj, bs.its = 50, verbose = FALSE)

## ----qvalChange, dependson="build_study_kidqval"----
old_pi0est <- qvalueObj(de_obj)$pi0
de_obj <- apply_qvalue(de_obj, pi0.method = "bootstrap")
new_pi0est <- qvalueObj(de_obj)$pi0

## ----qvalueChangePrint, echo=FALSE------------
print(data.frame(old_pi0est = old_pi0est, new_pi0est = new_pi0est))

## ----kidney_expSet, tidy=FALSE, eval=TRUE, cache=TRUE, dependson=c("kidney_import_data")----
library(edge)
anon_df <- as(data.frame(age=age, sex=sex), "AnnotatedDataFrame")
exp_set <- ExpressionSet(assayData = kidexpr, phenoData = anon_df)

## ----kidneyModel------------------------------
library(splines)
null_model <- ~1 + sex
full_model <- ~1 + sex + ns(age, intercept = FALSE, df = 4)

## ----cr_deSet, dependson=c("kidney_expSet")----
de_obj <- deSet(exp_set, full.model = full_model, null.model = null_model)
slotNames(de_obj)

## ----aODP-------------------------------------
de_odp <- odp(de_obj, bs.its = 50, verbose=FALSE)
de_lrt <- lrt(de_obj)
summary(de_odp)

## ----snm_eres---------------------------------
qval_obj <- qvalueObj(de_odp)
qvals <- qval_obj$qvalues
lfdr <- qval_obj$lfdr
pvals <- qval_obj$pvalues
pi0 <- qval_obj$pi0

