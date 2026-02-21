# Code example from 'extra_attrs' vignette. See references/ for full tutorial.

## ----message=FALSE, warning=FALSE---------------------------------------------------------------------------
library(OmnipathR)

## ----load-interactions--------------------------------------------------------------------------------------
i <- post_translational(fields = 'extra_attrs')
dplyr::select(i, source_genesymbol, target_genesymbol, extra_attrs)

## ----list-extra-attrs---------------------------------------------------------------------------------------
extra_attrs(i)

## ----extra-attr-values--------------------------------------------------------------------------------------
extra_attr_values(i, SIGNOR_mechanism)

## ----to-cols------------------------------------------------------------------------------------------------
i0 <- extra_attrs_to_cols(
    i,
    si_mechanism = SIGNOR_mechanism,
    ma_mechanism = Macrophage_type,
    keep_empty = FALSE
)

dplyr::select(
    i0,
    source_genesymbol,
    target_genesymbol,
    si_mechanism,
    ma_mechanism
)

## ----single-value-vector------------------------------------------------------------------------------------
dplyr::pull(i0, si_mechanism)[[7]]

## ----to-cols-flatten----------------------------------------------------------------------------------------
i1 <- extra_attrs_to_cols(
    i,
    si_mechanism = SIGNOR_mechanism,
    ma_mechanism = Macrophage_type,
    keep_empty = FALSE,
    flatten = TRUE
)

dplyr::select(
    i1,
    source_genesymbol,
    target_genesymbol,
    si_mechanism,
    ma_mechanism
)

## ----with-attrs-1-------------------------------------------------------------------------------------------
nrow(with_extra_attrs(i, SIGNOR_mechanism))

## ----with-attrs-2-------------------------------------------------------------------------------------------
nrow(with_extra_attrs(i, SIGNOR_mechanism, CA1_effect, Li2012_mechanism))

## ----signor-phos-1------------------------------------------------------------------------------------------
phos <- c('phosphorylation', 'Phosphorylation')

si_phos <- filter_extra_attrs(i, SIGNOR_mechanism = phos)

dplyr::select(si_phos, source_genesymbol, target_genesymbol)

## ----search-attr--------------------------------------------------------------------------------------------
keys <- extra_attrs(i)
keys_ubi <- purrr::keep(
    keys,
    function(k){
        any(stringr::str_detect(extra_attr_values(i, !!k), 'biqu'))
    }
)
keys_ubi

## ----search-values------------------------------------------------------------------------------------------
ubi <- rlang::set_names(
    purrr::map(
        keys_ubi,
        function(k){
            stringr::str_subset(extra_attr_values(i, !!k), 'biqu')
        }
    ),
    keys_ubi
)
ubi

## ----filter-ubi---------------------------------------------------------------------------------------------
ubi_kws <- c('ubiquitination', 'Ubiquitination')

i_ubi <-
    dplyr::distinct(
        dplyr::bind_rows(
            purrr::map(
                keys_ubi,
                function(k){
                    filter_extra_attrs(i, !!k := ubi_kws, na_ok = FALSE)
                }
            )
        )
    )

dplyr::select(i_ubi, source_genesymbol, target_genesymbol)

## ----count-e3-----------------------------------------------------------------------------------------------
length(unique(i_ubi$source_genesymbol))

## ----match-e3-----------------------------------------------------------------------------------------------
uniprot_kws <- annotations(
    resources = 'UniProt_keyword',
    entity_type = 'protein',
    wide = TRUE
)

e3_ligases <- dplyr::pull(
    dplyr::filter(uniprot_kws, keyword == 'Ubl conjugation'),
    genesymbol
)

length(e3_ligases)
length(intersect(unique(i_ubi$source_genesymbol), e3_ligases))
length(setdiff(unique(i_ubi$source_genesymbol), e3_ligases))

## ----ubi-es-------------------------------------------------------------------------------------------------
es_ubi <- enzyme_substrate(types = 'ubiquitination')
es_ubi

## ----match-es-----------------------------------------------------------------------------------------------
es_i_ubi <-
    dplyr::inner_join(
        es_ubi,
        i_ubi,
        by = c(
            'enzyme_genesymbol' = 'source_genesymbol',
            'substrate_genesymbol' = 'target_genesymbol'
        )
    )

nrow(dplyr::distinct(dplyr::select(es_i_ubi, enzyme, substrate, residue_offset)))

## ----session------------------------------------------------------------------------------------------------
sessionInfo()

