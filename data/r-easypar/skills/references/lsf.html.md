[Skip to contents](#main)

[easypar](../index.html)
1.0.0

* [Get started](../articles/easypar.html)
* [Reference](../reference/index.html)
* Articles

  [LSF array jobs with easypar](../articles/lsf.html)
  [PBSpro array jobs with easypar](../articles/pbspro.html)
* [Changelog](../news/index.html)

![](../logo.png)

# LSF array jobs with easypar

#### Giulio Caravagna

#### 15 September 2019

Source: [`vignettes/lsf.Rmd`](https://github.com/caravagnalab/easypar/blob/HEAD/vignettes/lsf.Rmd)

`lsf.Rmd`

`easypar` can be used to generate scripts that submit array jobs to the LSF cluster system.

First, write in R your code.

```
# Computation function
FUN = function(x, y){  ... }

# Input for 25 array jobs that match FUN arguments
PARAMS = data.frame(x = runif(25), y = runif(25))

# Generates submission files
run_lsf(FUN, PARAMS)
```

Then, in your terminal.

```
# Test if the generated script runs with the first input
head -1 EASYPAR_LSF_input_jobarray.csv | Rscript EASYPAR_LSF_Run.R

# Submit array jobs (after loading the cluster module)
bsub < EASYPAR_LSF_submission.sh
```

#### Requirements

* a function `FUN` (e.g.,: `FUN = ls`) that can run as a stand-alone R application, with its own parameters and that manages explicitly its dependencies.

> Note: `FUN` will be run as an indipendent process.

* a dataframe `PARAMS` where every row is an input for `FUN`. The column order must match `FUN` arguments.

Conceptually, you set up the data as for an `apply(FUN, MARGIN = 1)` by row.

The input should have column names without dots or spaces; these will match the arguments of `FUN`. So, for instance, an input with 2-columns will only work if `FUN` has 2 parameters.

#### Output

`run_lsf` generates 3 files:

* an R script wrapping the definition of `FUN`, with extra code to call `FUN` using parameters from the command line. Your function in this script is called with a fake name;
* a `csv` file containing the input `PARAMS`, without any header (column names), and row names.
* a LSF array job submission script with `N` jobs where `N` are the rows of `PARAMS`.

Before submitting the job, test the computation as explained above.

#### Customising jobs

Cluster-specific BSUB instructions can be specified, as well as other dependencies from modules available on the cluster.

Function `run_lsf` allows to:

* specify a list of modules that will be added as dependencies of the LSF submission script. For instance, `modules = 'R/3.5.0'` will generate the dependecy for a specific R version (`3.5.0`).
* customize the BSUB parameters of the generated script.

The package comes with a default BSUB configuration, that **has to be updated according to your cluster setup**.

```
library(easypar)
```

```
## Warning: replacing previous import 'cli::num_ansi_colors' by
## 'crayon::num_ansi_colors' when loading 'easypar'
```

```
# Default parameters in the package
default_BSUB_config()
```

```
## $`-J`
## [1] "EASYPAR_Runner"
##
## $`-P`
## [1] "dummy_project"
##
## $`-q`
## [1] "short"
##
## $`-n`
## [1] 1
##
## $`-R`
## [1] "\"span[hosts=1]\""
##
## $`-W`
## [1] "4:00"
##
## $`-o`
## [1] "log/output.%J.%I"
##
## $`-e`
## [1] "log/errors.%J.%I"
```

These are classical BSUB parameters:

* `-J`, the job ID;
* `-P`, the project ID;
* `-q`, the queue ID;
* `-n` and `-R`, the resources to allocate;
* `-W` the wall time of the jobs;
* `-o` and `-e`, the outputs and the error filenames. Notice that by default we have the job array ID in the filename, so to have one log per job.

> It is required to modify the default values of `-P` and `-q`, the project and queue ID, according to your LSF configuration. Otherwise, the submission script will generate an error becaue the default values do not mean anything.

Modifications are done to the default list of parameters; other BSUB flags can be used as well. No checkings on their correctness are done by `easypar`.

```
custom_BSUB = default_BSUB_config()

# More informative job ID
custom_BSUB$`-J` = "bwa_aligner"

# A token for a project allowed to run on the cluster
custom_BSUB$`-P` = "DKSMWOP331"

# A queue name that is valid on the cluster
custom_BSUB$`-q` = "bioinformatics"

print(custom_BSUB)
```

```
## $`-J`
## [1] "bwa_aligner"
##
## $`-P`
## [1] "DKSMWOP331"
##
## $`-q`
## [1] "bioinformatics"
##
## $`-n`
## [1] 1
##
## $`-R`
## [1] "\"span[hosts=1]\""
##
## $`-W`
## [1] "4:00"
##
## $`-o`
## [1] "log/output.%J.%I"
##
## $`-e`
## [1] "log/errors.%J.%I"
```

```
# Shorter version
custom_BSUB = default_BSUB_config(J = 'bwa_aligner', P = 'DKSMWOP331', q = 'bioinformatics')

print(custom_BSUB)
```

```
## $`-J`
## [1] "bwa_aligner"
##
## $`-P`
## [1] "DKSMWOP331"
##
## $`-q`
## [1] "bioinformatics"
##
## $`-n`
## [1] 1
##
## $`-R`
## [1] "\"span[hosts=1]\""
##
## $`-W`
## [1] "4:00"
##
## $`-o`
## [1] "log/output.%J.%I"
##
## $`-e`
## [1] "log/errors.%J.%I"
```

Once the BSUB has been customized, you can either:

* generate the submission scripts, and submit your job manually
* generate the submission scripts and submit the jobs with a `system` call.

By default (`run = FALSE`) the `run_lsf` function outputs the shell command that should be used to submit the jobs, but leaves the user to submit the job. This is because we experienced some command line issues calling modules with a system call.

#### Example

An example computation follows.

```
# A simple function that prints some outputs
FUN = function(x, y){
  print(x, y)
}

# input for 25 array jobs
PARAMS = data.frame(
  x = runif(25),
  y = runif(25)
  )

# generates the input files, adding some module dependencies
run_lsf(FUN,
        PARAMS,
        BSUB_config = custom_BSUB,
        modules = 'R/3.5.0'
        )
```

```
## ── easypar: LSF array jobs generator ───────────────────────────────────────────
```

```
## → Destination folder: .
```

```
## Creating folder for output and error logs:  log
```

```
## ✔ LSF submission script: #!/bin/bash
##
## #BSUB -J bwa_aligner[1-25]
## #BSUB -P DKSMWOP331
## #BSUB -q bioinformatics
## #BSUB -n 1
## #BSUB -R "span[hosts=1]"
## #BSUB -W 4:00
## #BSUB -o log/output.%J.%I
## #BSUB -e log/errors.%J.%I
##
## # =-=-=-=-=-=-=-=-=-=-=-=-=-==-=-=-=-=-=-=-=-=
## # Automatic LSF script generated via easypar
## # 2022-05-30 14:21:45
## # =-=-=-=-=-=-=-=-=-=-=-=-=-==-=-=-=-=-=-=-=-=
##
## # Required modules
## module load R/3.5.0
##
##
## # Input file and R script
## file_input=EASYPAR_LSF_input_jobarray.csv
## R_script=EASYPAR_LSF_Run.R
## line=$LSB_JOBINDEX
##
## # Data loading
## x=$( awk -v line=$line 'BEGIN {FS="\t"}; FNR==line {print $1}' $file_input)
## y=$( awk -v line=$line 'BEGIN {FS="\t"}; FNR==line {print $2}' $file_input)
##
## # Job run
## Rscript $R_script $x $y (R runner: EASYPAR_LSF_Run.R)
```

```
## ✔  Input file (head of): EASYPAR_LSF_input_jobarray.csv
```

```
##
```

```
## ── Scripts generated ──
```

```
##
```

```
##
## Job submission: bsub < EASYPAR_LSF_submission.sh
##    Job testing: Rscript EASYPAR_LSF_Run.R 0.497507827356458 0.202100263675675
```

#### Submitting the job

If you do not try to run it automatically, command `bsub < EASYPAR_LSF_submission.sh` will submit the jobs to the cluster.

Developed by Giulio Caravagna.

Site built with [pkgdown](https://pkgdown.r-lib.org/) 2.0.3.