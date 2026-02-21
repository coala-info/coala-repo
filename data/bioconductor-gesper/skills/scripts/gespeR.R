# Code example from 'gespeR' vignette. See references/ for full tutorial.

## ----setup_knitr, include=FALSE, cache=FALSE-----------------------------
library(knitr)
## set global chunk options
opts_chunk$set(fig.path='tmp/gespeR-', fig.align='center', fig.show='hold', par=TRUE, fig.width = 4, fig.height = 4, out.width='.75\\textwidth', dpi=150)

## ----citation, echo = FALSE, results = "asis"----------------------------
	print(citation("gespeR")[1], style="LaTeX")

## ----load_gespeR, message = FALSE----------------------------------------
  library(gespeR)

## ----load_phenotypes-----------------------------------------------------
  phenos <- lapply(LETTERS[1:4], function(x) {
    sprintf("Phenotypes_screen_%s.txt", x)
  })
  phenos <- lapply(phenos, function(x) {
    Phenotypes(system.file("extdata", x, package="gespeR"),
      type = "SSP",
      col.id = 1,
      col.score = 2)
  })
  show(phenos[[1]])

## ----plot_phenotypes-----------------------------------------------------
  plot(phenos[[1]])

## ----load_TRs------------------------------------------------------------
  tr <- lapply(LETTERS[1:4], function(x) {
    sprintf("TR_screen_%s.rds", x)
  })
  tr <- lapply(tr, function(x) {
    TargetRelations(system.file("extdata", x, package="gespeR"))
  })
  show(tr[[2]])

## ----unload_TRs----------------------------------------------------------
  # Size of object with loaded values
  format(object.size(tr[[1]]), units = "Kb")
  tempfile <- paste(tempfile(pattern = "file", tmpdir = tempdir()), ".rds", sep="")
  tr[[1]] <- unloadValues(tr[[1]], writeValues = TRUE, path = tempfile)

  # Size of object after unloading
  format(object.size(tr[[1]]), units = "Kb")

  # Reload values
  tr[[1]] <- loadValues(tr[[1]])

## ----fit_cv--------------------------------------------------------------
  res.cv <- lapply(1:length(phenos), function(i) {
    gespeR(phenotypes = phenos[[i]],
          target.relations = tr[[i]],
           mode = "cv",
           alpha = 0.5,
           ncores = 1)
  })

## ----ssp_gsp_scores------------------------------------------------------
  ssp(res.cv[[1]])
  gsp(res.cv[[1]])
  head(scores(res.cv[[1]]))

## ----plot_cv-------------------------------------------------------------
  plot(res.cv[[1]])

## ----concordance---------------------------------------------------------
  conc.gsp <- concordance(lapply(res.cv, gsp))
  conc.ssp <- concordance(lapply(res.cv, ssp))

## ----plot_concordance, out.width='.45\\textwidth', message = FALSE-------
  plot(conc.gsp) + ggtitle("GSPs\n")
  plot(conc.ssp) + ggtitle("SSPs\n")

## ----session, echo=FALSE, results = "asis"-------------------------------
    toLatex(sessionInfo())

