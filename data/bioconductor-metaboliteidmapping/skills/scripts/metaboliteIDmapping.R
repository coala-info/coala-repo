# Code example from 'metaboliteIDmapping' vignette. See references/ for full tutorial.

## ----load_library-------------------------------------------------------------

library( metaboliteIDmapping)

metabolitesMapping


## ----search_mapping-----------------------------------------------------------

library( AnnotationHub)

ah <- AnnotationHub()
datasets <- query( ah, "metaboliteIDmapping")

datasets[1]

datasets[2]


## ----load_mapping-------------------------------------------------------------

data <- ah[["AH91792"]]

data


