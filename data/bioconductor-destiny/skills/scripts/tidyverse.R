# Code example from 'tidyverse' vignette. See references/ for full tutorial.

## -----------------------------------------------------------------------------
suppressPackageStartupMessages({
    library(destiny)
    library(tidyverse)
    library(forcats)  # not in the default tidyverse loadout
})

## -----------------------------------------------------------------------------
scale_colour_continuous <- scale_color_viridis_c

## -----------------------------------------------------------------------------
theme_set(theme_gray() + theme(
    axis.ticks = element_blank(),
    axis.text  = element_blank()))

## -----------------------------------------------------------------------------
data(guo_norm)

## -----------------------------------------------------------------------------
guo_norm %>%
    as('data.frame') %>%
    gather(Gene, Expression, one_of(featureNames(guo_norm)))

## -----------------------------------------------------------------------------
dm <- DiffusionMap(guo_norm)

## -----------------------------------------------------------------------------
names(dm)  # namely: Diffusion Components, Genes, and Covariates

## -----------------------------------------------------------------------------
ggplot(dm, aes(DC1, DC2, colour = Klf2)) +
    geom_point()

## -----------------------------------------------------------------------------
fortify(dm) %>%
    mutate(
        EmbryoState = factor(num_cells) %>%
            lvls_revalue(paste(levels(.), 'cell state'))
    ) %>%
    ggplot(aes(DC1, DC2, colour = EmbryoState)) +
        geom_point()

## -----------------------------------------------------------------------------
fortify(dm) %>%
    gather(DC, OtherDC, num_range('DC', 2:5)) %>%
    ggplot(aes(DC1, OtherDC, colour = factor(num_cells))) +
        geom_point() +
        facet_wrap(~ DC)

## -----------------------------------------------------------------------------
fortify(dm) %>%
    sample_frac() %>%
    ggplot(aes(DC1, DC2, colour = factor(num_cells))) +
        geom_point(alpha = .3)

