# Code example from 'surfaltr_vignette' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
rmarkdown.html_vignette.check_title = FALSE
library(devtools)
devtools::load_all()
library(knitr)
library(kableExtra)

## ----eval = FALSE-------------------------------------------------------------
# if (!require("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("surfaltr")

## ----eval = FALSE-------------------------------------------------------------
# library(surfaltr)

## ----eval = FALSE-------------------------------------------------------------
# check_tmhmm_install(path/to/folder/TMHMM2.0c)

## ----echo = FALSE, out.width = "85%", fig.align = "center"--------------------
knitr::include_graphics("Figure_1.png")

## ----eval=FALSE---------------------------------------------------------------
# graph_from_aas(data_file = system.file("extdata", "CRB1.csv", package="surfaltr"),
#                organism = "mouse", rank = "combo",
#                n_prts = 20, mode = "phobius", size_txt = 2, space_left = -400,
#                temp = FALSE)
# 
# graph_from_ids(data_file = system.file("extdata", "hpa_genes.csv",package="surfaltr"),
#                organism = "human",
#                rank = "combo", n_prts = 20, mode = "phobius", size_txt = 2,
#                space_left = -400, temp = FALSE)

## ----echo = FALSE-------------------------------------------------------------
all_genome_data <- read.csv(file = "hpa_genes.csv", header = TRUE)
kable(head(all_genome_data), align = 'c')%>%
  kable_styling(full_width = TRUE)

## ----echo = FALSE-------------------------------------------------------------
all_genome_data <- read.csv(file = "CRB1.csv", header = TRUE)
all_genome_data <-  data.frame(lapply(all_genome_data, substr, 1, 70))
for(row in 1:nrow(all_genome_data)){
  all_genome_data[row, "protein_sequence"] <- paste(all_genome_data[row, "protein_sequence"], "...", sep = "")
}
kable(head(all_genome_data), align = 'c')%>%
  kable_styling(full_width = TRUE)

## ----echo = FALSE-------------------------------------------------------------
inp <- read.csv(file = "Input_Table.csv", header = TRUE, fileEncoding="latin1")
kable(inp, align = 'c')%>%
  kable_styling(full_width = TRUE)

## ----eval=FALSE---------------------------------------------------------------
# graph_from_ids(data_file = system.file("extdata", "hpa_genes.csv",package="surfaltr"), organism = "human",
#                rank = "combo", n_prts = 20, mode = "phobius", size_txt = 2,
#                space_left = -400, tmhmm_folder_name = NULL)

## ----eval=FALSE---------------------------------------------------------------
# graph_from_aas(data_file = system.file("extdata", "CRB1.csv", package="surfaltr"), organism = "mouse", rank = "TM",
#                n_prts = 10, mode = "phobius", size_txt = 2, space_left = -400,
#                tmhmm_folder_name = NULL)
# 

## ----eval = FALSE-------------------------------------------------------------
# AA_seq <- get_pairs(data_file = system.file("extdata", "CRB1.csv", package="surfaltr"), if_aa = TRUE, organism = "mouse", temp = FALSE)
# 

## ----echo = FALSE, out.width = "200%", fig.align = "center"-------------------
knitr::include_graphics("crb1_output.PNG")

## ----echo = FALSE, fig.align = "center"---------------------------------------
knitr::include_graphics("CRB1_fasta_ss.PNG")

## ----echo = FALSE, out.width = "50%", fig.align = "center"--------------------
knitr::include_graphics("Figure_2.png")

## ----eval = FALSE-------------------------------------------------------------
# mem_topo <- get_tmhmm(fasta_file_name = "AA.fasta", tmhmm_folder_name = "~/path/to/TMHMM2.0c")

## ----eval = FALSE-------------------------------------------------------------
# AA_lst <- get_pairs(data_file = system.file("extdata", "CRB1.csv", package="surfaltr"), if_aa = TRUE, organism = "mouse")
# mem_topo <- get_tmhmm("AA.fasta", tmhmm_folder_name = "~/path/to/TMHMM2.0c")

## ----eval = FALSE-------------------------------------------------------------
# topo <- run_phobius(AA_seq = AA_lst, fasta_file_name = "~/<your-workin-directory>/output/AA.fasta")

## ----eval = FALSE-------------------------------------------------------------
# AA_lst <- get_pairs(data_file = "~/CRB1.csv", if_aa = TRUE, organism = "mouse")
# mem_topo <- run_phobius(AA_seq = AA_lst, fasta_file_name = "~/<your-workin-directory>/output/AA.fasta")

## ----eval = FALSE-------------------------------------------------------------
# AA_lst <- get_pairs(data_file = system.file("extdata", "CRB1.csv", package="surfaltr"), if_aa = TRUE, organism = "mouse")
# mem_topo <- run_phobius(AA_seq = AA_lst, fasta_file_name = "~/<your-working-directory>/AA.fasta")
# plot_isoforms(topo = mem_topo, AA_seq = AA_lst, rank = "combo", n_prts = 15,
#               size_txt = 3, space_left = -400)

## ----echo = FALSE-------------------------------------------------------------
tm_rank <- read.csv(file = "TM_Table.csv", header = TRUE, fileEncoding="latin1")
kable(tm_rank, align = 'c')%>%
  kable_styling(full_width = FALSE)

## ----echo = FALSE-------------------------------------------------------------
cm_rank <- read.csv(file = "Combo_Table.csv", header = TRUE, fileEncoding="latin1")
kable(cm_rank, align = 'c')%>%
  kable_styling(full_width = FALSE)

## ----echo = FALSE, out.width = "65%", fig.align = "center"--------------------
knitr::include_graphics("Figure_3.png")

## ----echo = FALSE-------------------------------------------------------------
ft_rank <- read.csv(file = "Format_Table.csv", header = TRUE, fileEncoding="latin1")
kable(ft_rank, align = 'c')%>%
  kable_styling(full_width = TRUE)

## ----echo = FALSE, out.width = "50%", fig.align = "center"--------------------
knitr::include_graphics("Figure_4.png")

## ----eval = FALSE-------------------------------------------------------------
# align_prts(gene_names = c("Crb1", "Adgrl1"), data_file = system.file("extdata", "CRB1.csv", package="surfaltr"),
#            if_aa = TRUE, organism = "mouse")

## ----eval = FALSE-------------------------------------------------------------
# align_org_prts(gene_names = c("gene-name"), hs_data_file = "~/path/to/human-dataframe.csv",
#                mm_data_file =  "~/path/to/mouse-dataframe.csv", if_aa = FALSE)

## ----echo = FALSE, fig.align = "center"---------------------------------------
knitr::include_graphics("Figure_5.png")

## ----eval = FALSE-------------------------------------------------------------
# library(surfaltr)

## ----eval = TRUE--------------------------------------------------------------
sessionInfo()

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup, include = FALSE---------------------------------------------------
library(surfaltr)

