# Code example from 'INSPEcT_GUI' vignette. See references/ for full tutorial.

## ----INSPEcT_loading,eval=FALSE,echo=TRUE,message=FALSE,warnings=FALSE--------
# library(INSPEcT)
# runINSPEcTGUI()

## ----fig1,eval=TRUE,echo=FALSE, out.width="100%", fig.cap="Representation of the GUI divided into its 4 main sections.", fig.align="right"----
knitr::include_graphics("INSPEcT_GUI_figures/INSPEcT_GUI.png")

## ----fig2,eval=TRUE,echo=FALSE, out.width="75%", fig.cap="Interaction with an object of class INSPEcT (section 1)."----
knitr::include_graphics("INSPEcT_GUI_figures/select_INSPEcT_object_class_gene.png")

## ----fig3,eval=TRUE,echo=FALSE, out.width="90%", fig.cap="Visualization of the RNA dynamics for a single gene (section 2).", fig.align="center"----
knitr::include_graphics("INSPEcT_GUI_figures/rates_and_concentrations_panel.png")

## ----fig4,eval=TRUE,echo=FALSE, out.width="75%", fig.cap="Model minimization (section 3).", fig.align="center"----
knitr::include_graphics("INSPEcT_GUI_figures/minimization_status.png")

## ----fig5,eval=TRUE,echo=FALSE, out.width="100%", fig.cap="Direct interaction with RNA life-cycle kinetic rates (section 4)."----
knitr::include_graphics("INSPEcT_GUI_figures/rates_functional_forms.png")

## ----fig6,eval=TRUE,echo=FALSE, out.width="100%", fig.cap="Case study 1: constant kinetic rates.", fig.align="center"----
knitr::include_graphics("INSPEcT_GUI_figures/case_study_1.png")

## ----fig7,eval=TRUE,echo=FALSE, out.width="100%", fig.cap="Case study 2: modulation of processing rate.", fig.align="center"----
knitr::include_graphics("INSPEcT_GUI_figures/case_study_2.png")

## ----fig8,eval=TRUE,echo=FALSE, out.width="100%", fig.cap="Case study 3: modulation of synthesis rate.", fig.align="center"----
knitr::include_graphics("INSPEcT_GUI_figures/case_study_3.png")

## ----fig9,eval=TRUE,echo=FALSE, out.width="100%", fig.cap="Case study 4: concomitant modulation of synthesis and degradation rates.", fig.align="center"----
knitr::include_graphics("INSPEcT_GUI_figures/case_study_4.png")

## ----session------------------------------------------------------------------
sessionInfo()

