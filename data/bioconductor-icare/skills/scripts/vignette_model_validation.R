# Code example from 'vignette_model_validation' vignette. See references/ for full tutorial.

### R code from vignette source 'vignette_model_validation.Rnw'

###################################################
### code chunk number 1: start
###################################################
library(iCARE)


###################################################
### code chunk number 2: load-data
###################################################
data("bc_data", package="iCARE")
set.seed(50)


###################################################
### code chunk number 3: model-1a
###################################################
res_snps_miss = computeAbsoluteRisk(model.snp.info = bc_72_snps,
                       model.disease.incidence.rates = bc_inc,
                       model.competing.incidence.rates = mort_inc,
                       apply.age.start = 50, apply.age.interval.length = 30,
                       return.refs.risk = TRUE)


###################################################
### code chunk number 4: summary-1a
###################################################
summary(res_snps_miss$refs.risk)


###################################################
### code chunk number 5: model 1b
###################################################
res_snps_dat = computeAbsoluteRisk(model.snp.info = bc_72_snps,
                     model.disease.incidence.rates = bc_inc,
                     model.competing.incidence.rates = mort_inc,
                     apply.age.start = 50, apply.age.interval.length = 30,
                     apply.snp.profile = new_snp_prof,
                     return.refs.risk = TRUE)
names(res_snps_dat)


###################################################
### code chunk number 6: plot-1b
###################################################
plot(density(res_snps_dat$refs.risk),
           xlim = c(0.04,0.18), xlab = "Absolute Risk of Breast Cancer",
           main = "Referent SNP-only Risk Distribution: Ages 50-80 years")
abline(v = res_snps_dat$risk, col = "red")
legend("topright", legend = "New profiles", col = "red", lwd = 1)


###################################################
### code chunk number 7: ex-2
###################################################
res_covs_snps = computeAbsoluteRisk(model.formula = bc_model_formula,
                                model.cov.info = bc_model_cov_info,
                                model.snp.info = bc_72_snps,
                                model.log.RR = bc_model_log_or,
                                model.ref.dataset = ref_cov_dat,
                                model.disease.incidence.rates = bc_inc,
                                model.competing.incidence.rates = mort_inc,
                                model.bin.fh.name = "famhist",
                                apply.age.start = 50,
                                apply.age.interval.length = 30,
                                apply.cov.profile = new_cov_prof,
                                apply.snp.profile = new_snp_prof,
                                return.refs.risk = TRUE)


###################################################
### code chunk number 8: fit-2
###################################################
print(res_covs_snps$details)


###################################################
### code chunk number 9: sampling-weights
###################################################
validation.cohort.data$inclusion = 0
subjects_included = intersect(validation.cohort.data$id,
                            validation.nested.case.control.data$id)
validation.cohort.data$inclusion[subjects_included] = 1

validation.cohort.data$observed.followup =
                        validation.cohort.data$study.exit.age -
                            validation.cohort.data$study.entry.age

selection.model = glm(inclusion ~ observed.outcome
                       * (study.entry.age + observed.followup),
                              data = validation.cohort.data,
                              family = binomial(link = "logit"))
validation.nested.case.control.data$sampling.weights =
        selection.model$fitted.values[validation.cohort.data$inclusion == 1]


###################################################
### code chunk number 10: model-validation
###################################################
data = validation.nested.case.control.data
risk.model = list(model.formula = bc_model_formula,
                   model.cov.info = bc_model_cov_info,
                   model.snp.info = bc_72_snps,
                   model.log.RR = bc_model_log_or,
                   model.ref.dataset = ref_cov_dat,
                   model.ref.dataset.weights = NULL,
                   model.disease.incidence.rates = bc_inc,
                   model.competing.incidence.rates = mort_inc,
                   model.bin.fh.name = "famhist",
                   apply.cov.profile = data[,all.vars(bc_model_formula)[-1]],
                   apply.snp.profile = data[,bc_72_snps$snp.name],
                   n.imp = 5, use.c.code = 1, return.lp = TRUE,
                   return.refs.risk = TRUE)

output = ModelValidation(study.data = data,
                         total.followup.validation = TRUE,
                         predicted.risk.interval = NULL,
                         iCARE.model.object = risk.model,
                         number.of.percentiles = 10)


###################################################
### code chunk number 11: plot-model-validation
###################################################
plotModelValidation(study.data = data,validation.results = output)


###################################################
### code chunk number 12: sessionInfo
###################################################
sessionInfo()


