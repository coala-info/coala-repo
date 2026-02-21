# Code example from 'User_manual' vignette. See references/ for full tutorial.

## ----include=FALSE------------------------------------------------------------
knitr::opts_chunk$set(comment = "", warning = FALSE, message = FALSE)

## -----------------------------------------------------------------------------
library(knitr)
library(ClustIRR)
library(igraph)
library(ggplot2)
theme_set(new = theme_bw(base_size = 10))
library(ggrepel)
library(patchwork)
options(digits=2)

## ----eval=FALSE---------------------------------------------------------------
# if(!require("BiocManager", quietly = TRUE)) {
#   install.packages("BiocManager")
# }
# BiocManager::install("ClustIRR")

## ----graphic, echo = FALSE, fig.align="left", out.width='100%'----------------
knitr::include_graphics("../inst/extdata/logo.png")

## -----------------------------------------------------------------------------
data("D1", package = "ClustIRR")
str(D1)

## -----------------------------------------------------------------------------
tcr_reps <- rbind(D1$a, D1$b, D1$c)

## -----------------------------------------------------------------------------
meta <- rbind(D1$ma, D1$mb, D1$mc)

## -----------------------------------------------------------------------------
cl <- clustirr(s = tcr_reps, meta = meta, control = list(gmi = 0.8))

## -----------------------------------------------------------------------------
kable(head(cl$clust_irrs[["a"]]@clust$CDR3a), digits = 2)

## -----------------------------------------------------------------------------
kable(head(cl$clust_irrs[["a"]]@clust$CDR3b), digits = 2)

## -----------------------------------------------------------------------------
plot_graph(cl, select_by = "Ag_species", as_visnet = TRUE)

## ----fig.width=6, fig.height=4.5----------------------------------------------
# data.frame of edges and their attributes
e <- igraph::as_data_frame(x = cl$graph, what = "edges")

## ----fig.width=5, fig.height=3.5----------------------------------------------
ggplot(data = e)+
  geom_density(aes(ncweight, col = chain))+
  geom_density(aes(nweight, col = chain), linetype = "dashed")+
  xlab(label = "edge weight (solid = ncweight, dashed = nweight)")+
  theme(legend.position = "top")

## -----------------------------------------------------------------------------
gcd <- detect_communities(graph = cl$graph, 
                          algorithm = "leiden",
                          metric = "average",
                          resolution = 1,
                          iterations = 100,
                          weight = "ncweight",
                          chains = c("CDR3a", "CDR3b"))

## -----------------------------------------------------------------------------
names(gcd)

## -----------------------------------------------------------------------------
dim(gcd$community_occupancy_matrix)

## -----------------------------------------------------------------------------
head(gcd$community_occupancy_matrix)

## ----fig.width=5, fig.height=5------------------------------------------------
honeycomb <- get_honeycombs(com = gcd$community_occupancy_matrix)

## ----fig.width=10, fig.height=2.5---------------------------------------------
wrap_plots(honeycomb, nrow = 1)+
    plot_annotation(tag_levels = 'A')

## -----------------------------------------------------------------------------
kable(head(gcd$community_summary$wide), digits = 1, row.names = FALSE)

## -----------------------------------------------------------------------------
kable(head(gcd$community_summary$tall), digits = 1, row.names = FALSE)

## -----------------------------------------------------------------------------
kable(head(gcd$node_summary), digits = 1, row.names = FALSE)

## -----------------------------------------------------------------------------
ns_com_8 <- gcd$node_summary[gcd$node_summary$community == 8, ]

table(ns_com_8$sample)

## ----fig.width=6, fig.height=4------------------------------------------------
par(mai = c(0,0,0,0))
plot(subgraph(graph = gcd$graph, vids = which(V(gcd$graph)$community == 8)))

## -----------------------------------------------------------------------------
# we can pick from these edge attributes
edge_attr_names(graph = gcd$graph)

## -----------------------------------------------------------------------------
edge_filter <- rbind(data.frame(name = "nweight", value = 8, operation = ">="),
                     data.frame(name = "ncweight", value = 8, operation = ">="))

## -----------------------------------------------------------------------------
# we can pick from these node attributes
vertex_attr_names(graph = gcd$graph)

## -----------------------------------------------------------------------------
node_filter <- data.frame(name = c("TRBV", "TRAV"))

## -----------------------------------------------------------------------------
c8 <- decode_community(community_id = 8, 
                         graph = gcd$graph,
                         edge_filter = edge_filter,
                         node_filter = node_filter)

## ----fig.width=6, fig.height=4------------------------------------------------
par(mar = c(0, 0, 0, 0))
plot(c8$community, vertex.size = 10)

## -----------------------------------------------------------------------------
kable(as_data_frame(x = c8$community, what = "vertices")
      [, c("name", "component_id", "CDR3b", "TRBV", 
           "TRBJ", "CDR3a", "TRAV", "TRAJ")],
      row.names = FALSE)

## -----------------------------------------------------------------------------
kable(c8$component_stats, row.names = FALSE)

## -----------------------------------------------------------------------------
d <- dco(community_occupancy_matrix = gcd$community_occupancy_matrix,
         mcmc_control = list(mcmc_warmup = 300,
                             mcmc_iter = 600,
                             mcmc_chains = 2,
                             mcmc_cores = 1,
                             mcmc_algorithm = "NUTS",
                             adapt_delta = 0.9,
                             max_treedepth = 10))

## -----------------------------------------------------------------------------
beta_violins <- get_beta_violin(node_summary = gcd$node_summary,
                                beta = d$posterior_summary$beta,
                                ag = "",
                                ag_species = TRUE,
                                db = "vdjdb")

## ----fig.width=5, fig.height=3------------------------------------------------
beta_violins

## -----------------------------------------------------------------------------
beta_violins <- get_beta_violin(node_summary = gcd$node_summary,
                                beta = d$posterior_summary$beta,
                                ag = "CMV",
                                ag_species = TRUE,
                                db = "vdjdb")

## ----fig.width=9, fig.height=7------------------------------------------------
beta_violins

## ----fig.width=6, fig.height=2.5----------------------------------------------
ggplot(data = d$posterior_summary$y_hat)+
  facet_wrap(facets = ~sample, nrow = 1, scales = "free")+
  geom_abline(intercept = 0, slope = 1, linetype = "dashed", col = "gray")+
  geom_errorbar(aes(x = y_obs, y = mean, ymin = L95, ymax = H95),
                col = "darkgray", width=0)+
  geom_point(aes(x = y_obs, y = mean), size = 0.8)+
  xlab(label = "observed y")+
  ylab(label = "predicted y (and 95% HDI)")

## ----fig.width=7, fig.height=6------------------------------------------------
ggplot(data = d$posterior_summary$delta)+
    facet_wrap(facets = ~contrast, ncol = 2)+
    geom_errorbar(aes(x = community, y = mean, ymin = L95, ymax = H95), 
                  col = "lightgray", width = 0)+
    geom_point(aes(x = community, y = mean), shape = 21, fill = "black", 
               stroke = 0.4, col = "white", size = 1.25)+
    theme(legend.position = "top")+
    ylab(label = expression(delta))+
    scale_x_continuous(expand = c(0,0))

## ----fig.width=7, fig.height=6------------------------------------------------
ggplot(data = d$posterior_summary$epsilon)+
    facet_wrap(facets = ~contrast, ncol = 2)+
    geom_errorbar(aes(x = community, y = mean, ymin = L95, ymax = H95), 
                  col = "lightgray", width = 0)+
    geom_point(aes(x = community, y = mean), shape = 21, fill = "black", 
               stroke = 0.4, col = "white", size = 1.25)+
    theme(legend.position = "top")+
    ylab(label = expression(epsilon))+
    scale_x_continuous(expand = c(0,0))

## ----echo=FALSE, include=FALSE------------------------------------------------
rm(a, b, cl_a, cl_b, cl_c, meta_a, meta_b, meta_c, d, e, g, gcd)

