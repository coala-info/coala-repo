# Code example from 'flowGraph' vignette. See references/ for full tutorial.

## ----style, echo=FALSE, results='asis'----------------------------------------
BiocStyle::markdown()

## ----eval=FALSE, label=library1, warning=FALSE, message=FALSE, echo=TRUE, fig=FALSE, results='hide'----
# if (!require("BiocManager")) install.packages('BiocManager')
# BiocManager::install("aya49/flowGraph")

## ----label=library2, warning=FALSE, message=FALSE, echo=TRUE, fig=FALSE, message=FALSE----
library(flowGraph)

## ----message=FALSE------------------------------------------------------------
no_cores <- 1
data(fg_data_pos2)

meta_cell <- get_phen_meta(colnames(fg_data_pos2$count))
suppressWarnings({ pccell <- flowGraph:::get_phen_list(meta_cell, no_cores) })
gr <- set_layout_graph(list(e=pccell$edf, v=meta_cell)) # layout cell hierarchy

gr <- ggdf(gr)
gr$v$colour <- ifelse(!grepl("[-]",gr$v$phenotype), 1,0)
                     # "nodes with only marker conditions", "other nodes")
gr$v$label <- gr$v$phenotype
gr$v$v_ind <- gr$v$label_ind <- TRUE
gr$e$e_ind <- !grepl("[-]",gr$e$from) & !grepl("[-]",gr$e$to)

## ----fig.wide=TRUE------------------------------------------------------------
knitr::opts_template$set(figure1=list(fig.height=9, fig.width=9))
plot_gr(gr, main="Example cell hierarchy with markers A, B, C, D")

## ----eval=FALSE---------------------------------------------------------------
# no_cores <- 1 # number of cores to parallelize on.
# data(fg_data_pos2)
# fg <- flowGraph(
#     fg_data_pos2$count, # sample x cell population matrix
#     meta=fg_data_pos2$meta, # a data frame with each sample's meta data
#     path="flowGraph_example", # a directory for flowGraph to output results to
#     no_cores=no_cores) # number of cores to use, typically 1 for small data

## ----eval=FALSE---------------------------------------------------------------
# fg <- fg_load("flowGraph_example")

## ----label=Load_Data, fig=FALSE, message=FALSE--------------------------------
# data(fg_data_fca)
data(fg_data_pos2)
# data(fg_data_pos30)

# ?fg_data_fca
# ?fg_data_pos2
# ?fg_data_pos30

## ----message=FALSE------------------------------------------------------------
# no_cores <- 1 # number of cores to parallelize on.
data(fg_data_pos2)
fg <- flowGraph(fg_data_pos2$count, meta=fg_data_pos2$meta, no_cores=no_cores)


## -----------------------------------------------------------------------------
meta <- fg_get_meta(fg)
head(meta)

mcount <- fg_get_feature(fg, "node", "count")
head(rownames(mcount))

## -----------------------------------------------------------------------------
# get feature descriptions
fg_get_summary_desc(fg)
# get a summary statistic
fg_sum <- fg_get_summary(fg, type="node", summary_meta=list(
    node_feature="SpecEnr", 
    test_name="t_diminish", 
    class="class", 
    labels=c("exp","control"))
)
# fg_sum <- fg_get_summary(fg, type="node", index=1) # same as above

# list most significant cell populations
p <- fg_sum$values # p values
head(sort(p),30)

## ----eval=FALSE---------------------------------------------------------------
# fg_save(fg, "path/to/user/specified/folder/directory") # save flowGraph object
# fg <- fg_load("path/to/user/specified/folder/directory") # load flowGraph object

## -----------------------------------------------------------------------------
show(fg)

## -----------------------------------------------------------------------------
# get sample meta data
head(fg_get_meta(fg))

# modify sample meta data
meta_new <- fg_get_meta(fg)
meta_new$id[1] <- "new_sample_id1"
fg <- fg_replace_meta(fg, meta_new)

## -----------------------------------------------------------------------------
# get cell population meta data
gr <- fg_get_graph(fg)
head(gr$v)
head(gr$e)

## -----------------------------------------------------------------------------
# get feature descriptions
fg_get_feature_desc(fg)
# get count node feature
mc <- fg_get_feature(fg, type="node", feature="count")
dim(mc)

## -----------------------------------------------------------------------------
# add a new feature; 
# input matrix must contain the same row and column names as existing features;
# we recommend users stick with default feature generation methods 
# that start with fg_feat_
fg <- fg_add_feature(fg, type="node", feature="count_copy", m=mc)
fg_get_feature_desc(fg)

## -----------------------------------------------------------------------------
# remove a feature; note, the count node feature cannot be removed
fg <- fg_rm_feature(fg, type="node", feature="count_copy")
fg_get_feature_desc(fg)

## -----------------------------------------------------------------------------
fg_get_summary_desc(fg)

# calculate summary statistic
fg <- fg_summary(fg, no_cores=no_cores, class="class", label1="control",
                 node_features="count", edge_features="NONE",
                 overwrite=FALSE, test_name="t", diminish=FALSE)
fg_get_summary_desc(fg)

## -----------------------------------------------------------------------------
# get a summary statistic
fg_sum1 <- fg_get_summary(fg, type="node",  summary_meta=list(
    feature="count", test_name="t", 
    class="class", label1="control", label2="exp"))
names(fg_sum1)

## -----------------------------------------------------------------------------
# remove a summary statistic
fg <- fg_rm_summary(fg, type="node", summary_meta=list(
    feature="count", test_name="t", 
    class="class", label1="control", label2="exp"))
fg_get_summary_desc(fg)

## -----------------------------------------------------------------------------
# add a new feature summary; 
# input list must contain a 'values', 'id1', and 'id2' containing summary 
# statistic values and the sample id's compared;
# we recommend users stick with default feature generation method fg_summary
fg <- fg_add_summary(fg, type="node",  summary_meta=list(
    feature="SpecEnr", test_name="t_copy",
    class="class", label1="control", label2="exp"), p=fg_sum1)
fg_get_summary_desc(fg)

## -----------------------------------------------------------------------------
# plotting functions default to plotting node feature SpecEnr 
# labelled with mean expected/proportion (maximum 30 labels are shown for clarity)
# and only significant nodes based on the wilcox_byLayer_diminish summary statistic
# are shown.
# gr <- fg_plot(fg, p_thres=.01, show_bgedges=TRUE, # show background edges
#               node_feature="SpecEnr", edge_feature="prop",
#               test_name="t_diminish", label_max=30)
gr <- fg_plot(fg, index=1, p_thres=.01, show_bgedges=TRUE)
# plot_gr(gr)

## -----------------------------------------------------------------------------
# interactive version in beta
plot_gr(gr, interactive=TRUE)

## ----message=FALSE------------------------------------------------------------
data(fg_data_pos2)
fg1 <- flowGraph(fg_data_pos2$count, class=fg_data_pos2$meta$class, 
                 no_cores=no_cores)

## -----------------------------------------------------------------------------
fg_get_summary_desc(fg)

fg_plot_qq(fg, type="node", index=1)
fg_plot_qq(fg, type="node", index=1, logged=TRUE)

# interactive version
fg_plot_qq(fg, type="node", index=1, interactive=TRUE)

## -----------------------------------------------------------------------------
fg_plot_box(fg, type="node", summary_meta=NULL, index=1, node_edge="A+")

## -----------------------------------------------------------------------------
fg_plot_pVSdiff(fg, type="node", summary_meta=NULL, index=1)

# interactive version
fg_plot_pVSdiff(fg, type="node", summary_meta=NULL, index=1, interactive=TRUE)

## -----------------------------------------------------------------------------
gr <- fg_get_graph(fg)
gr <- ggdf(gr)

gr$v$colour <- ifelse(!grepl("[-]",gr$v$phenotype), 1, 0)
                     # "nodes with only marker conditions", "other nodes")
gr$v$label <- gr$v$phenotype
gr$v$v_ind <- gr$v$label_ind <- TRUE
gr$e$e_ind <- !grepl("[-]",gr$e$from) & !grepl("[-]",gr$e$to)

plot_gr(gr, main="Example cell hierarchy with markers A, B, C, D")

## ----evaluate=FALSE-----------------------------------------------------------
data(fg_data_pos2)
fg <- flowGraphSubset(fg_data_pos2$count, meta=fg_data_pos2$meta, no_cores=no_cores,
                 summary_pars=flowGraphSubset_summary_pars(),
                 summary_adjust=flowGraphSubset_summary_adjust())

## -----------------------------------------------------------------------------
sessionInfo()

