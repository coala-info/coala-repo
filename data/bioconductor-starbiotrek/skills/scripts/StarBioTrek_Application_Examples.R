# Code example from 'StarBioTrek_Application_Examples' vignette. See references/ for full tutorial.

## ---- echo = TRUE,eval = FALSE-------------------------------------------
#  path_lip<-getKEGGdata(KEGG_path="Lip_met")

## ---- eval = FALSE, echo = FALSE-----------------------------------------
#  knitr::kable(colnames(path_lip), digits = 2,
#               caption = "List of pathways in lipid metabolism",row.names = FALSE)

## ---- echo = TRUE,eval = FALSE-------------------------------------------
#  pathcell_grow_d<-getKEGGdata(KEGG_path="cell_grow_d")

## ---- eval = FALSE, echo = FALSE-----------------------------------------
#  knitr::kable(colnames(pathcell_grow_d), digits = 2,
#               caption = "List of pathways in cellular processes",row.names = FALSE)

## ---- eval = FALSE-------------------------------------------------------
#  score_euc_dist_Lip_met<-dev_std_crtlk(dataFilt=Data_CANCER_normUQ_filt,path_lip)

## ---- eval = FALSE-------------------------------------------------------
#  tumo<-SelectedSample(Dataset=Data_CANCER_normUQ_filt,typesample="tumor")[,1:100]
#  norm<-SelectedSample(Dataset=Data_CANCER_normUQ_filt,typesample="normal")[,1:100]
#  nf <- 60
#  res_class<-svm_classification(TCGA_matrix=score_euc_dist_Lip_met,nfs=nf,
#                                normal=colnames(norm),tumour=colnames(tumo))

## ---- eval = FALSE-------------------------------------------------------
#  better_perf<-select_class(auc.df=res_class,cutoff=0.80)

## ---- eval = FALSE-------------------------------------------------------
#  matrix_best_perf<-process_matrix(measure=score_euc_dist_Lip_met,list_perf=better_perf)
#  tumo_bestlipd<-SelectedSample(Dataset=matrix_best_perf,typesample="tumor")[,1:100]
#  score_bestlipd<-colMeans(tumo_bestlipd)

## ---- eval = FALSE-------------------------------------------------------
#  tumo_cell_grow_d<-SelectedSample(Dataset=Data_CANCER_normUQ_filt,typesample="tumor")[,1:100]
#  score_euc_dist_cell_grow_d<-dev_std_crtlk(dataFilt=tumo_cell_grow_d,pathcell_grow_d)

## ---- eval = FALSE-------------------------------------------------------
#  score__cell_grow_d<-process_matrix_cell_process(score_euc_dist_cell_grow_d)
#   score__cell_grow_d_mean<-colMeans(score__cell_grow_d)

## ---- eval = FALSE-------------------------------------------------------
#  correlazione<-cor(score__cell_grow_d_mean,score_bestlipd)
#  plot_matrix<-cbind(score__cell_grow_d_mean,score_bestlipd)
#  

