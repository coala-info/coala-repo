# Code example from 'RiboCrypt_app_tutorial' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE, fig.align = "left")

## ----echo = FALSE, out.width = "1000px", out.height="600px", fig.align="left"----
knitr::include_graphics("../images/tutorial_fig1.png")

## ----echo = FALSE, out.width = "500px", out.height="600px", fig.align="left"----
knitr::include_graphics("../images/tutorial_fig2.png")

## ----echo = FALSE, out.width = "900px", out.height="600px", fig.align="left"----
knitr::include_graphics("../images/tutorial_fig3.png")

## ----echo = FALSE, out.width = "1000px", out.height="500px", fig.align="left"----
knitr::include_graphics("../images/tutorial_fig5.png")

## ----echo = FALSE, out.width = "1000px", out.height="500px", fig.align="left"----
knitr::include_graphics("../images/tutorial_fig4.png")

## ----echo = FALSE, results = 'asis'-------------------------------------------
knitr::opts_knit$set(base.url = file.path(normalizePath("./../inst/rmd"), "/"))
res <- knitr::knit_child('./../inst/rmd/tutorial.rmd', quiet = TRUE)
cat(res, sep = '\n')

