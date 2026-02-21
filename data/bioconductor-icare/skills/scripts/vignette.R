# Code example from 'vignette' vignette. See references/ for full tutorial.

### R code from vignette source 'vignette.Rnw'

###################################################
### code chunk number 1: start
###################################################
library(iCARE)


###################################################
### code chunk number 2: load-data
###################################################
data("bc_data", package="iCARE")


###################################################
### code chunk number 3: model-1a
###################################################
res_snps_miss = computeAbsoluteRisk(model.snp.info = bc_72_snps, 
                      model.disease.incidence.rates = bc_inc,
                      model.competing.incidence.rates = mort_inc, 
                      apply.age.start = 50, 
                      apply.age.interval.length = 30,
                      return.refs.risk=TRUE)


###################################################
### code chunk number 4: summary-1a
###################################################
summary(res_snps_miss$risk)
summary(res_snps_miss$refs.risk)
plot(density(res_snps_miss$risk), lwd=2, 
  main="SNP-only Risk Stratification: Ages 50-80", 
  xlab="Absolute Risk of Breast Cancer")


###################################################
### code chunk number 5: model 1b
###################################################
res_snps_dat = computeAbsoluteRisk(model.snp.info = bc_72_snps, 
                                model.disease.incidence.rates = bc_inc,
                                model.competing.incidence.rates = mort_inc, 
                                apply.age.start = 50, 
                                apply.age.interval.length = 30, 
                                apply.snp.profile = new_snp_prof, 
                                return.refs.risk = TRUE)
names(res_snps_dat)


###################################################
### code chunk number 6: plot-1b
###################################################
plot(density(res_snps_dat$refs.risk), lwd=2, 
   main="Referent SNP-only Risk Distribution: Ages 50-80",
   xlab="Absolute Risk of Breast Cancer")
abline(v=res_snps_dat$risk, col="red")
legend("topright", legend="New Profiles", col="red", lwd=1)


###################################################
### code chunk number 7: fit-2
###################################################
res_covs_snps = computeAbsoluteRisk(model.formula=bc_model_formula, 
                                         model.cov.info=bc_model_cov_info,
                                         model.snp.info=bc_72_snps,
                                         model.log.RR=bc_model_log_or,
                                         model.ref.dataset=ref_cov_dat,
                                         model.disease.incidence.rates=bc_inc,
                                         model.competing.incidence.rates=mort_inc, 
                                         model.bin.fh.name="famhist",
                                         apply.age.start=50, 
                                         apply.age.interval.length=30,
                                         apply.cov.profile=new_cov_prof,
                                         apply.snp.profile=new_snp_prof, 
                                         return.refs.risk=TRUE)


###################################################
### code chunk number 8: fit-2
###################################################
print(res_covs_snps$details)


###################################################
### code chunk number 9: sessionInfo
###################################################
sessionInfo()


