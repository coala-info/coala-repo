# Code example from 'KinSwingR' vignette. See references/ for full tutorial.

## ----echo=TRUE----------------------------------------------------------------
library(KinSwingR)
data(example_phosphoproteome)
data(phosphositeplus_human)

# View the datasets:
head(example_phosphoproteome)

head(phosphositeplus_human)

## sample 100 data points for demonstration
sample_data <- head(example_phosphoproteome, 1000)

# Random sample for demosntration purposes
set.seed(1234)
sample_pwm <- phosphositeplus_human[sample(nrow(phosphositeplus_human), 1000),]

# for visualising a motif, sample only CAMK2A
CAMK2A_example <- phosphositeplus_human[phosphositeplus_human[,1]== "CAMK2A",] 


## ----echo=TRUE----------------------------------------------------------------
annotated_data <- cleanAnnotation(input_data = sample_data, 
                                  annotation_delimiter = "|",
                                  multi_protein_delimiter = ":", 
                                  multi_site_delimiter = ";",
                                  seq_number = 4, 
                                  replace = TRUE, 
                                  replace_search = "X",
                                  replace_with = "_")

head(annotated_data)


## ----echo=TRUE----------------------------------------------------------------
pwms <- buildPWM(sample_pwm)

## ----echo=TRUE----------------------------------------------------------------
head(pwms$kinase)

## ----echo=TRUE----------------------------------------------------------------
CAMK2A_pwm <- buildPWM(CAMK2A_example)
CAMK2A <- viewPWM(CAMK2A_pwm, 
                  which_pwm="CAMK2A",
                  view_pwm = TRUE,
                  color_scheme = "shapely")

## ----echo=TRUE----------------------------------------------------------------
# As an example of control over multi-core processing
# load BiocParallel library
library(BiocParallel)
# finally set/register the number of cores to use
register(SnowParam(workers = 4))

# set seed for reproducible results
set.seed(1234)
scores <- scoreSequences(input_data = annotated_data, 
                         pwm_in = pwms,
                         n = 100)

## ----echo=TRUE----------------------------------------------------------------
# after loading BiocParallel library, set/register the number of cores to use
register(SnowParam(workers = 4))

# set seed for reproducible results
set.seed(1234)
swing_out <- swing(input_data = annotated_data, 
                   pwm_in = pwms, 
                   pwm_scores = scores,
                   permutations = 10)

# This will produce two tables, one is a network for use with e.g. Cytoscape and the other is the scores. To access the scores:
head(swing_out$scores)

