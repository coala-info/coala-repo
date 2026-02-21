# Code example from 'tidy_motifs' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(memes)
library(magrittr)
library(universalmotif)

## -----------------------------------------------------------------------------
flyFactorDb <- MotifDb::MotifDb %>% 
  MotifDb::query("FlyFactorSurvey")

## -----------------------------------------------------------------------------
flyFactorMotifs <- flyFactorDb %>% 
  convert_motifs()

## -----------------------------------------------------------------------------
flyFactorMotifs %>% 
  head(1)

## -----------------------------------------------------------------------------
flyFactor_data <- flyFactorMotifs %>% 
  to_df()

## -----------------------------------------------------------------------------
# The following columns can be changed to update motif metadata
flyFactor_data %>% 
  names

## -----------------------------------------------------------------------------
flyFactor_data %>% 
  head(5)

## -----------------------------------------------------------------------------
length(flyFactor_data$altname) == length(unique(flyFactor_data$altname))

## -----------------------------------------------------------------------------
flyFactor_data %<>% 
  dplyr::rename("altname" = "name", 
                "name" = "altname")

## -----------------------------------------------------------------------------
flyFactor_data %>% 
  head(3)

## -----------------------------------------------------------------------------
flyFactor_data %<>% 
  # Critical to set remove = FALSE to keep the `name` column
  tidyr::separate(name, c("tfid"), remove = FALSE, extra = "drop") %>% 
  # Only use the tfid if the altname contains an FBgn
  dplyr::mutate(altname = ifelse(grepl("^FBgn", altname), tfid, altname))

## -----------------------------------------------------------------------------
flyFactor_data %>% 
  head(3)

## -----------------------------------------------------------------------------
flyFactor_data %<>% 
  dplyr::mutate(name = gsub("_FBgn\\d+", "", name))

## -----------------------------------------------------------------------------
flyFactor_data %>% 
  dplyr::filter(altname != tfid) %>% 
  # I'm only showing the first 5 rows for brevity, but take a look at the full
  # data and see what patterns you notice
  head(5)

## -----------------------------------------------------------------------------
flyFactor_data %>% 
  # calling tolower() on both columns removes capitalization as a difference
  dplyr::filter(tolower(altname) != tolower(tfid),
                # Select all altnames that do not contain "-", "." or "("
                !grepl("-|\\.|\\(", altname),
                ) %>% 
  # I'll visalize only these columns for brevity
  dplyr::select(altname, tfid, name, consensus) %>% 
  head(10)
 

## -----------------------------------------------------------------------------
flyFactor_data %<>% 
  # rename all "da" instances using their tfid value instead
  dplyr::mutate(altname = ifelse(altname == "da", tfid, altname))

## -----------------------------------------------------------------------------
flyFactor_data %>% 
  dplyr::filter(tolower(altname) != tolower(tfid),
                !grepl("-|\\.|\\(", altname)) %>% 
  dplyr::select(altname, tfid, name, consensus) %>% 
  head(10)

## -----------------------------------------------------------------------------
flyFactor_data %>% 
  dplyr::filter(tolower(altname) != tolower(tfid),
                !grepl("-|\\.|\\(", altname),
                # Remove CG genes from consideration
                !grepl("CG\\d+", tfid)
                ) %>% 
  dplyr::select(altname, tfid, name, consensus)

## -----------------------------------------------------------------------------
swap_alt_id <- c("CG6272", "Clk", "Max", "Mnt", "Jra")
remove <- "Bgb"

flyFactor_data %<>% 
  dplyr::mutate(altname = ifelse(altname %in% swap_alt_id, tfid, altname)) %>% 
  dplyr::filter(!(altname %in% remove))

## -----------------------------------------------------------------------------
flyFactor_data %>% 
  dplyr::filter(tolower(altname) != tolower(tfid),
                !grepl("-|\\.|\\(", altname),
                # Remove CG genes from consideration
                !grepl("CG\\d+", tfid)
                ) %>% 
  dplyr::select(altname, tfid, name, consensus)

## -----------------------------------------------------------------------------
flyFactor_data %>% 
  dplyr::filter(consensus == "MMCACCTGYYV")

## -----------------------------------------------------------------------------
# This operation takes a while to run on large motif lists
flyFactor_dedup <- remove_duplicate_motifs(flyFactor_data)

## -----------------------------------------------------------------------------
# Rows before cleanup
nrow(flyFactor_data)
# Rows after cleanup
nrow(flyFactor_dedup)

## -----------------------------------------------------------------------------
flyFactor_dedup %>% 
  dplyr::filter(consensus == "MMCACCTGYYV")

## -----------------------------------------------------------------------------
# extrainfo = FALSE drops the extra columns we added during data cleaning which are now unneeded
flyFactorMotifs_final <- to_list(flyFactor_dedup, extrainfo = FALSE)

## -----------------------------------------------------------------------------
flyFactorMotifs_final %>% 
  head(1)

## ----eval=F,include=T---------------------------------------------------------
# write_meme(flyFactorMotifs_final, "flyFactorSurvey_cleaned.meme")

## -----------------------------------------------------------------------------
sessionInfo()

