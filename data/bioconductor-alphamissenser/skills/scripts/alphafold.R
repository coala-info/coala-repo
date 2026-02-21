# Code example from 'alphafold' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>"
)

## ----dependencies, eval = FALSE-----------------------------------------------
# pkgs <- c("bio3d", "r3dmol")
# pkgs_to_install <- pkgs[!pkgs %in% rownames(installed.packages())]
# if (length(pkgs_to_install))
#     BiocManager::install(pkgs_to_install)

## ----setup, message = FALSE---------------------------------------------------
library(AlphaMissenseR)

## ----am_available-------------------------------------------------------------
am_available()

## ----am_data------------------------------------------------------------------
am_data("aa_substitutions")
am_data("hg38")

## ----P35557-------------------------------------------------------------------
P35557_aa <-
    am_data("aa_substitutions") |>
    dplyr::filter(uniprot_id == "P35557")

## ----median-pathogenicity-----------------------------------------------------
af_prediction_view(P35557_aa)

## ----uniprot_ids--------------------------------------------------------------
uniprot_ids <-
    am_data("aa_substitutions") |>
    dplyr::filter(uniprot_id %like% "P3555%") |>
    dplyr::distinct(uniprot_id) |>
    pull(uniprot_id)
uniprot_ids

## ----af_predictions-----------------------------------------------------------
prediction <- af_predictions(uniprot_ids)
glimpse(prediction)

## ----pdb_url------------------------------------------------------------------
pdb_url <-
    prediction |>
    dplyr::filter(uniprotAccession == "P35557") |>
    dplyr::pull(pdbUrl)

## ----pdb----------------------------------------------------------------------
pdb_file <- BiocFileCache::bfcrpath(rnames = basename(pdb_url), fpath = pdb_url)
pdb <- bio3d::read.pdb(pdb_file)
pdb

## ----pdb_r3dmol---------------------------------------------------------------
r3dmol::r3dmol() |>
    ## use the PDB representation
    r3dmol::m_add_model(r3dmol::m_bio3d(pdb)) |>
    ## visualize as a 'cartoon' with alpha helices and beta sheets
    r3dmol::m_set_style(style = r3dmol::m_style_cartoon(arrow = TRUE)) |>
    ## fit molecule into display area
    r3dmol::m_zoom_to()

## ----am_data-hg38-------------------------------------------------------------
P35557 <-
    am_data("hg38") |>
    dplyr::filter(uniprot_id == "P35557")

## ----am_aa_pathogenicity------------------------------------------------------
pathogenicity <- am_aa_pathogenicity(P35557)
pathogenicity

## ----js_template--------------------------------------------------------------
cat(
    AlphaMissenseR:::js_template("colorfunc", colors = "..."),
    "\n"
)

## ----af_colorfunc_by_position-------------------------------------------------
df <- tibble(
    pos = 1 + 1:10, # no color information for position 1
    value = 10:1 / 10
)
colorfunc <- af_colorfunc_by_position(
    df,
    "pos", "value",
    pos_max = 12    # no color information for position 12
)
cat(colorfunc, "\n")

## ----colorfunc----------------------------------------------------------------
colorfunc <-
    pathogenicity |>
    af_colorfunc_by_position(
        "aa_pos", "aa_pathogenicity_mean",
        length(pdb$seqres)
    )

## ----pdb_r3dmol_color---------------------------------------------------------
r3dmol::r3dmol() |>
    ## use the PDB representation
    r3dmol::m_add_model(r3dmol::m_bio3d(pdb)) |>
    ## visualize as a 'cartoon' with alpha helices and beta sheets
    r3dmol::m_set_style(
        style = r3dmol::m_style_cartoon(
            arrow = TRUE,
            ## color residue according to colorfunc
            colorfunc = colorfunc
        )
    ) |>
    ## fit molecule into display area
    r3dmol::m_zoom_to()

## ----mk_gpos, message=FALSE---------------------------------------------------
gpos <-
    am_data("hg38") |>
    filter(uniprot_id == "Q1W6H9") |>
    to_GPos()

## ----gosling_bar--------------------------------------------------------------
gosling_plot(
    gpos, plot_type = "bar",
    title = "Q1W6H9 track",
    subtitle = "bar plot example"
)

## ----gosling_lollipop---------------------------------------------------------
gosling_plot(
    gpos, plot_type = "lollipop",
    title = "Q1W6H9 track",
    subtitle = "lollipop plot example"
)

## ----db_disconnect_all--------------------------------------------------------
db_disconnect_all()

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

