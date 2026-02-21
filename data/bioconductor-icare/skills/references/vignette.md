iCARE(Individualized Coherent Absolute Risk
Estimators) Package

October 30, 2025

> library(iCARE)

Example 1.A

Load the breast cancer data.

> data("bc_data", package="iCARE")

In this example, we will estimate the risk of breast cancer in ages 50-80. A
SNP-only model is fit, with no specific genotypes supplied for estimation. The
population disease rates are from SEER.

> res_snps_miss = computeAbsoluteRisk(model.snp.info = bc_72_snps,
+
+
+
+
+

model.disease.incidence.rates = bc_inc,
model.competing.incidence.rates = mort_inc,
apply.age.start = 50,
apply.age.interval.length = 30,
return.refs.risk=TRUE)

Note: You did not provide apply.snp.profile.
If require more, please provide apply.snp.profile input.
[1] "Note: As specified, the model does not adjust SNP imputations for family history."

Will impute SNPs for 10000 people.

user
12.156

system elapsed
12.260

0.101

Compute a summary of the risks and visualize the results

> summary(res_snps_miss$risk)

Risk_Estimate
:0.09601
Min.
1st Qu.:0.09601
Median :0.09601
Mean
:0.09601
3rd Qu.:0.09601
:0.09601
Max.

> summary(res_snps_miss$refs.risk)

1

Min. 1st Qu. Median

Max.
0.05648 0.08654 0.09501 0.09601 0.10433 0.17917

Mean 3rd Qu.

> plot(density(res_snps_miss$risk), lwd=2,
+
+

main="SNP-only Risk Stratification: Ages 50-80",
xlab="Absolute Risk of Breast Cancer")

Example 1.B

In this example, we will again estimate the risk of breast cancer in ages 50-
80. This time however, three specific genotypes are supplied for estimation
(with some missing data). The argument return.refs.risk = TRUE, includes the
referent dataset risks be included in results.

> res_snps_dat = computeAbsoluteRisk(model.snp.info = bc_72_snps,
+
+
+
+
+
+

model.disease.incidence.rates = bc_inc,
model.competing.incidence.rates = mort_inc,
apply.age.start = 50,
apply.age.interval.length = 30,
apply.snp.profile = new_snp_prof,
return.refs.risk = TRUE)

[1] "Note: As specified, the model does not adjust SNP imputations for family history."

user
0.453

system elapsed
0.462

0.007

> names(res_snps_dat)

2

0.060.080.100.120.14051015202530SNP−only Risk Stratification: Ages 50−80Absolute Risk of Breast CancerDensity[1] "risk"

"details"

"beta.used" "refs.risk"

Visualize the Results

main="Referent SNP-only Risk Distribution: Ages 50-80",
xlab="Absolute Risk of Breast Cancer")

> plot(density(res_snps_dat$refs.risk), lwd=2,
+
+
> abline(v=res_snps_dat$risk, col="red")
> legend("topright", legend="New Profiles", col="red", lwd=1)

Example 2

In this example, we will estimate the risk of breast cancer in ages 50-80 by fitting
a model with 13 risk factors and 72 SNPs.

> res_covs_snps = computeAbsoluteRisk(model.formula=bc_model_formula,
+
+
+
+
+
+
+
+
+
+

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

3

0.060.080.100.120.140.160.18051015202530Referent SNP−only Risk Distribution: Ages 50−80Absolute Risk of Breast CancerDensityNew Profiles+
+

apply.snp.profile=new_snp_prof,
return.refs.risk=TRUE)

user
1.158

system elapsed
1.469

0.311

Display details of the fit

> print(res_covs_snps$details)

1
2
3

1
2
3

1
2
3

1
2
3

1
2
3

1
2
3

1
2
3

1
2
3

1
2
3

1
2
3

Int_Start Int_End Risk_Estimate rs616488 rs11552449 rs11249433 rs12405132
NA
NA
1

0.10288235
0.09009057
0.16856731

NA
NA
1

NA
0
0

NA
2
2

80
80
80

50
50
50

rs12048493 rs6678914 rs4245739 rs72755295 rs12710696 rs4849887 rs2016394
0
0
0

0
NA
1

NA
NA
1

0
NA
1

0
NA
0

0
1
2

0
1
0

rs1550623 rs16857609 rs6762644 rs4973768 rs12493607 rs6796502 rs9790517
1
2
1

0
2
0

0
0
0

0
1
0

1
1
2

1
1
1

0
1
0

rs6828523 rs10069690 rs13162653 rs2012709 rs10941679 rs10472076 rs1353747
0
1
1

1
0
0

0
0
0

2
1
1

0
0
0

0
0
0

2
1
0

rs7707921 rs1432679 rs11242675 rs204247 rs9257408 rs4593472 rs720475
1
0
0

1
0
2

0
0
1

0
2
2

2
1
1

0
1
1

1
1
1

rs9693444 rs13365225 rs6472903 rs2943559 rs13267382 rs11780156 rs1011970
0
1
0

1
0
1

1
0
1

0
0
0

1
1
0

0
2
1

0
1
0

rs10759243 rs2380205 rs7072776 rs11814448 rs7904519 rs11199914 rs554219
1
0
1

2
0
1

0
1
1

2
0
1

0
0
2

0
0
0

1
0
0

rs75915166 rs11820646 rs12422552 rs17356907 rs1292011 rs11571833 rs2236007
1
0
0

1
0
1

0
0
0

1
0
1

1
0
2

0
0
0

0
0
0

rs2588809 rs999737 rs941764 rs11627032 rs17817449 rs11075995 rs13329835
1
0
1

0
0
0

0
1
0

1
0
1

1
1
0

0
1
0

1
1
1

rs146699004 rs745570 rs527616 rs1436904 rs6507583 rs4808801 rs3760982
0
1
1

0
0
1
rs2284378 rs2823093 rs17879961 rs132390 rs6001930 famhist menarche_dec parity

0
2
2

0
1
1

0
0
1

0
0
0

1
1
1

4

1
2
3

1
2
3

1
2
3

1
1
0

1
0
0

0
0
0

0
0
0

0
0
0

0
0
0

8
10
1

0
0
0

birth_dec agemeno_dec height_dec bmi_dec rd_menohrt rd2_everhrt_e
0
0
0

10
4
10

1
1
1

2
1
7

2
2
1

6
6
1

rd2_everhrt_c rd2_currhrt alcoholdweek_dec ever_smoke
1
0
1

0
0
0

0
0
0

1
6
1

Session Information

> sessionInfo()

R version 4.5.1 Patched (2025-08-23 r88802)
Platform: x86_64-pc-linux-gnu
Running under: Ubuntu 24.04.3 LTS

Matrix products: default
BLAS:
LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0

/home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so

LAPACK version 3.12.0

locale:

[1] LC_CTYPE=en_US.UTF-8
[3] LC_TIME=en_GB
[5] LC_MONETARY=en_US.UTF-8
[7] LC_PAPER=en_US.UTF-8
[9] LC_ADDRESS=C

LC_NUMERIC=C
LC_COLLATE=C
LC_MESSAGES=en_US.UTF-8
LC_NAME=C
LC_TELEPHONE=C

[11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C

time zone: America/New_York
tzcode source: system (glibc)

attached base packages:
[1] stats

graphics

grDevices utils

datasets

methods

base

other attached packages:
[1] iCARE_1.38.0 Hmisc_5.2-4

gtools_3.9.5

plotrix_3.8-4

loaded via a namespace (and not attached):

[1] gtable_0.3.6
[5] tidyselect_1.2.1
[9] gridExtra_2.3
[13] ggplot2_4.0.0
[17] knitr_1.50
[21] tibble_3.3.0
[25] rlang_1.1.6

dplyr_1.1.4
htmlTable_2.4.3
cluster_2.1.8.1
R6_2.6.1
htmlwidgets_1.6.4
nnet_7.3-20
stringi_1.8.7

compiler_4.5.1
stringr_1.5.2
scales_1.4.0
generics_0.1.4
backports_1.5.0
pillar_1.11.1
xfun_0.53

rpart_4.1.24
dichromat_2.0-0.1
fastmap_1.2.0
Formula_1.2-5
checkmate_2.3.3
RColorBrewer_1.1-3
S7_0.2.0

5

[29] cli_3.6.5
[33] rstudioapi_0.17.1
[37] data.table_1.17.8
[41] colorspace_2.1-2
[45] pkgconfig_2.0.3

magrittr_2.0.4
base64enc_0.1-3
evaluate_1.0.5
rmarkdown_2.30
htmltools_0.5.8.1

digest_0.6.37
lifecycle_1.0.4
glue_1.8.0
foreign_0.8-90

grid_4.5.1
vctrs_0.6.5
farver_2.1.2
tools_4.5.1

6

