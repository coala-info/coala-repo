# Code example from 'usage_of_ggkegg' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE,
                    fig.width=12,
                    fig.height=6,
                    warning=FALSE,
                    message=FALSE)

## ----pathway1, message=FALSE, warning=FALSE, fig.width=6, fig.height=3--------
library(ggkegg)
library(tidygraph)
library(dplyr)
graph <- ggkegg::pathway("hsa04110", use_cache=TRUE)
graph

## ----pathway1_1, message=FALSE, warning=FALSE, fig.width=6, fig.height=3------
graph |> 
    mutate(degree=centrality_degree(mode="all"),
        betweenness=centrality_betweenness()) |> 
    activate(nodes) |>
    filter(type=="gene") |>
    arrange(desc(degree)) |>
    as_tibble() |>
    relocate(degree, betweenness)

## ----plot_pathway1, message=FALSE, warning=FALSE, fig.width=10, fig.height=8----
graph <- graph |> mutate(showname=strsplit(graphics_name, ",") |>
                    vapply("[", 1, FUN.VALUE="a"))

ggraph(graph, layout="manual", x=x, y=y)+
    geom_edge_parallel(aes(color=subtype_name),
        arrow=arrow(length=unit(1,"mm"), type="closed"),
        end_cap=circle(1,"cm"),
        start_cap=circle(1,"cm"))+
    geom_node_rect(aes(fill=I(bgcolor),
                      filter=type == "gene"),
                  color="black")+
    geom_node_text(aes(label=showname,
                      filter=type == "gene"),
                  size=2)+
    theme_void()

## ----plot_pathway2, message=FALSE, warning=FALSE, fig.width=10, fig.height=10----
graph |> mutate(x=NULL, y=NULL) |>
ggraph(layout="nicely")+
    geom_edge_parallel(aes(color=subtype_name),
        arrow=arrow(length=unit(1,"mm"), type="closed"),
        end_cap=circle(0.1,"cm"),
        start_cap=circle(0.1,"cm"))+
    geom_node_point(aes(filter=type == "gene"),
                  color="black")+
    geom_node_point(aes(filter=type == "group"),
                  color="tomato")+
    geom_node_text(aes(label=showname,
                      filter=type == "gene"),
                  size=3, repel=TRUE, bg.colour="white")+
    scale_edge_color_viridis(discrete=TRUE)+
    theme_void()

## ----convert, message=FALSE, warning=FALSE------------------------------------
graph |>
    activate(nodes) |>
    mutate(hsa=convert_id("hsa")) |>
    filter(type == "gene") |>
    as_tibble() |>
    relocate(hsa)

## ----highlight, message=FALSE, warning=FALSE, fig.width=10, fig.height=8------
graph |>
    activate(nodes) |>
    mutate(highlight=highlight_set_nodes("hsa:7157")) |>
    ggraph(layout="manual", x=x, y=y)+
    geom_node_rect(aes(fill=I(bgcolor),
                      filter=type == "gene"), color="black")+
    geom_node_rect(aes(fill="tomato", filter=highlight), color="black")+
    geom_node_text(aes(label=showname,
                      filter=type == "gene"), size=2)+
    geom_edge_parallel(aes(color=subtype_name),
                   arrow=arrow(length=unit(1,"mm"),
                               type="closed"),
                   end_cap=circle(1,"cm"),
                   start_cap=circle(1,"cm"))+
    theme_void()

## ----example_raw, message=FALSE, warning=FALSE, eval=TRUE---------------------
graph |>
    mutate(degree=centrality_degree(mode="all")) |>
    ggraph(graph, layout="manual", x=x, y=y)+
        geom_node_rect(aes(fill=degree,
                      filter=type == "gene"))+
        overlay_raw_map()+
        scale_fill_viridis_c()+
        theme_void()

## ----module2, eval=TRUE-------------------------------------------------------
mod <- module("M00002", use_cache=TRUE)
mod

## ----mod_vis1, message=FALSE, warning=FALSE, fig.width=8, fig.height=4--------
## Text-based
mod |>
    module_text() |> ## return data.frame
    plot_module_text()

## ----mod_vis2, message=FALSE, warning=FALSE, fig.width=8, fig.height=8--------
## Network-based
mod |>
    obtain_sequential_module_definition() |> ## return tbl_graph
    plot_module_blocks()

## ----ggkegg, fig.width=6, fig.height=6----------------------------------------
ggkegg("bpsp00270") |> class() ## Returns ggraph
ggkegg("N00002") ## Returns the KEGG NETWORK plot

## -----------------------------------------------------------------------------
sessionInfo()

