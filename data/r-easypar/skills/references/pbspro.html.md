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

# PBSpro array jobs with easypar

#### Giulio Caravagna

#### 15 September 2019

Source: [`vignettes/pbspro.Rmd`](https://github.com/caravagnalab/easypar/blob/HEAD/vignettes/pbspro.Rmd)

`pbspro.Rmd`

`easypar` can be used to generate scripts that submit array jobs to the PBSpro cluster system.

First, write in R your code.

```
# Computation function
FUN = function(x, y){  ... }

# Input for 25 array jobs that match FUN arguments
PARAMS = data.frame(x = runif(25), y = runif(25))

# Generates submission files
run_PBSpro(FUN, PARAMS)
```

Then, in your terminal.

```
# Test if the generated script runs with the first input
head -1 EASYPAR_PBSpro_input_jobarray.csv | Rscript EASYPAR_PBSpro_Run.R

# Submit array jobs (after loading the cluster module)
qsub < EASYPAR_PBSpro_submission.sh
```

#### Requirements

* a function `FUN` (e.g.,: `FUN = ls`) that can run as a stand-alone R application, with its own parameters and that manages explicitly its dependencies.

> Note: `FUN` will be run as an indipendent process.

* a dataframe `PARAMS` where every row is an input for `FUN`. The column order must match `FUN` arguments.

Conceptually, you set up the data as for an `apply(FUN, MARGIN = 1)` by row.

The input should have column names without dots or spaces; these will match the arguments of `FUN`. So, for instance, an input with 2-columns will only work if `FUN` has 2 parameters.

#### Output

`run_PBSpro` generates 3 files:

* an R script wrapping the definition of `FUN`, with extra code to call `FUN` using parameters from the command line. Your function in this script is called with a fake name;
* a `csv` file containing the input `PARAMS`, without any header (column names), and row names.
* a PBSpro array job submission script with `N` jobs where `N` are the rows of `PARAMS`.

Before submitting the job, test the computation as explained above.

#### Customising jobs

Cluster-specific QSUB instructions can be specified, as well as other dependencies from modules available on the cluster.

Function `run_PBSpro` allows to:

* specify a list of modules that will be added as dependencies of the PBSpro submission script. For instance, `modules = 'R/3.5.0'` will generate the dependecy for a specific R version (`3.5.0`).
* customize the QSUB parameters of the generated script.

The package comes with a default QSUB configuration, that **has to be updated according to your cluster setup**.

```
library(easypar)
```

```
## Warning: replacing previous import 'cli::num_ansi_colors' by
## 'crayon::num_ansi_colors' when loading 'easypar'
```

```
# Default parameters in the package
default_QSUB_config()
```

```
## $`-P`
## [1] "EASYPAR_Project"
##
## $`-q`
## [1] "thin"
##
## $`-l walltime`
## [1] "3:00:00"
##
## $`-l nodes=:ppn=`
## [1]  1 16
##
## $`-N`
## [1] "EASYPAR_Runner"
##
## $`-o`
## [1] "output.^array_index^.log"
##
## $`-e`
## [1] "error.^array_index^.err"
##
## $`-J`
## [1] ""
```

These are classical QSUB parameters: `-P` = the project ID, `-q` = the queue ID, `-l walltime` = the wall time of the jobs, `-l nodes=:ppn=` = the number of nodes and cpus to allocate as resources, `-N` = the job ID, `-o` and `-e` = the output and error filenames. Notice that by default we have the job array ID in the filename, so to have one log per job.

> It is required to modify the default values of `-P` and `-q`, the project and queue ID, according to your PBSpro configuration. Otherwise, the submission script will generate an error becaue the default values do not mean anything.

Modifications are done to the default list of parameters; other QSUB flags can be used as well. No checkings on their correctness are done by `easypar`.

```
custom_QSUB = default_QSUB_config()

# More informative job ID
custom_QSUB$`-J` = "bwa_aligner"

# A token for a project allowed to run on the cluster
custom_QSUB$`-P` = "DKSMWOP331"

# A queue name that is valid on the cluster
custom_QSUB$`-q` = "bioinformatics"

print(custom_QSUB)
```

```
## $`-P`
## [1] "DKSMWOP331"
##
## $`-q`
## [1] "bioinformatics"
##
## $`-l walltime`
## [1] "3:00:00"
##
## $`-l nodes=:ppn=`
## [1]  1 16
##
## $`-N`
## [1] "EASYPAR_Runner"
##
## $`-o`
## [1] "output.^array_index^.log"
##
## $`-e`
## [1] "error.^array_index^.err"
##
## $`-J`
## [1] "bwa_aligner"
```

```
# Shorter version
custom_QSUB = default_QSUB_config(J = 'bwa_aligner', project = 'DKSMWOP331', queue = 'bioinformatics')

print(custom_QSUB)
```

```
## $`-P`
## [1] "DKSMWOP331"
##
## $`-q`
## [1] "bioinformatics"
##
## $`-l walltime`
## [1] "3:00:00"
##
## $`-l nodes=:ppn=`
## [1]  1 16
##
## $`-N`
## [1] "EASYPAR_Runner"
##
## $`-o`
## [1] "output.^array_index^.log"
##
## $`-e`
## [1] "error.^array_index^.err"
##
## $`-J`
## [1] "bwa_aligner"
```

Once the QSUB has been customized, you can either:

* generate the submission scripts, and submit your job manually
* generate the submission scripts and submit the jobs with a `system` call.

By default (`run = FALSE`) the `run_PBSpro` function outputs the shell command that should be used to submit the jobs, but leaves the user to submit the job. This is because we experienced some command line issues calling modules with a system call.

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
run_PBSpro(FUN,
        PARAMS,
        QSUB_config = custom_QSUB,
        modules = 'R/3.5.0'
        )
```

```
## ── easypar: PBSpro array jobs generator ────────────────────────────────────────
```

```
## → Destination folder: .
```

```
## ✔ PBSpro submission script: #!/bin/bash
##
## #PBS -P DKSMWOP331
## #PBS -q bioinformatics
## #PBS -l walltime=3:00:00
## #PBS -l nodes=1:ppn=16
## #PBS -N EASYPAR_Runner
## #PBS -o output.^array_index^.log
## #PBS -e error.^array_index^.err
## #PBS -J bwa_aligner1-25
##
## # =-=-=-=-=-=-=-=-=-=-=-=-=-==-=-=-=-=-=-=-=-=
## # Automatic PBSpro script generated via easypar
## # 2022-05-30 14:21:48
## # =-=-=-=-=-=-=-=-=-=-=-=-=-==-=-=-=-=-=-=-=-=
##
## # Required modules
## module load R/3.5.0
##
##
##
## # Input file and R script
## file_input=${PBS_O_WORKDIR}/EASYPAR_PBSpro_input_jobarray.csv
## R_script=${PBS_O_WORKDIR}/EASYPAR_PBSpro_Run.R
##
## PER_TASK=1
## START_NUM=$(( ($PBS_ARRAY_INDEX - 1) * $PER_TASK + 1 ))
## END_NUM=$(( $PBS_ARRAY_INDEX * $PER_TASK ))
## echo This is task $PBS_ARRAY_INDEX, which will do runs $START_NUM to $END_NUM
##
##
## # Looping over tasks
## for (( run=$START_NUM; run<=$END_NUM; run++ )); do
##  echo This is PBSpro task $PBS_ARRAY_INDEX, run number $run
##  # Data loading
##  x=$( awk -v line=$run 'BEGIN {FS="\t"}; FNR==line {print $1}' $file_input)
##  y=$( awk -v line=$run 'BEGIN {FS="\t"}; FNR==line {print $2}' $file_input)
##  # Job run
##  Rscript $R_script $x $y
## done
##
## date (R runner: EASYPAR_PBSpro_Run.R)
```

```
## ✔  Input file (head of): EASYPAR_PBSpro_input_jobarray.csv
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
## Job submission: qsub -c c < EASYPAR_PBSpro_submission.sh
##    Job testing: Rscript EASYPAR_PBSpro_Run.R 0.361189847812057 0.399693528423086
```

#### Submitting the job

If you do not try to run it automatically, command `qsub < EASYPAR_PBSpro_submission.sh` will submit the jobs to the cluster.

Developed by Giulio Caravagna.

Site built with [pkgdown](https://pkgdown.r-lib.org/) 2.0.3.