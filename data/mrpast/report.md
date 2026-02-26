# mrpast CWL Generation Report

## mrpast_simulate

### Tool Description
Simulate demographic histories using mrpaste.

### Metadata
- **Docker Image**: quay.io/biocontainers/mrpast:0.2--py312h8f4af18_0
- **Homepage**: https://aprilweilab.github.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/mrpast/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/mrpast/overview
- **Total Downloads**: 1.8K
- **Last updated**: 2025-12-03
- **GitHub**: https://github.com/aprilweilab/mrpast
- **Stars**: N/A
### Original Help Text
```text
usage: mrpast simulate [-h] [--jobs JOBS] [--seed SEED] [--verbose]
                       [--replicates REPLICATES] [--seq-len SEQ_LEN]
                       [--recomb-rate RECOMB_RATE] [--individuals INDIVIDUALS]
                       [--debug-demo]
                       model arg_prefix

positional arguments:
  model                 The input YAML file specifying the model
  arg_prefix            The prefix for the output tree-sequence files

options:
  -h, --help            show this help message and exit
  --jobs JOBS, -j JOBS  Number of jobs (threads) to use. Defaults to 1.
  --seed SEED           Set the random seed.
  --verbose, -v         Verbose output, including timing information.
  --replicates REPLICATES, -r REPLICATES
                        Number of simulation replications to perform. Defaults
                        to 20.
  --seq-len SEQ_LEN, -s SEQ_LEN
                        Length of sequences in base-pairs. Default to
                        100000000.
  --recomb-rate RECOMB_RATE, -e RECOMB_RATE
                        Rate of recombination, or filename/prefix for
                        recombination map. A prefix will match
                        '<prefix>*.txt'. Defaults to 1e-08.
  --individuals INDIVIDUALS, -n INDIVIDUALS
                        Number of individuals per population. Defaults to 10.
  --debug-demo, -d      Output results from msprime demography debugger.
```


## mrpast_process

### Tool Description
Process MRPAST model and ARG files.

### Metadata
- **Docker Image**: quay.io/biocontainers/mrpast:0.2--py312h8f4af18_0
- **Homepage**: https://aprilweilab.github.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/mrpast/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mrpast process [-h] [--jobs JOBS] [--seed SEED] [--verbose]
                      [--replicates REPLICATES] [--num-times NUM_TIMES]
                      [--solve] [--add-ground-truth] [--suffix SUFFIX]
                      [--out-dir OUT_DIR] [--min-time-unit MIN_TIME_UNIT]
                      [--max-generation MAX_GENERATION]
                      [--tree-sample-rate TREE_SAMPLE_RATE]
                      [--leave-out LEAVE_OUT]
                      [--bootstrap {,coalcounts,jackknife}]
                      [--bootstrap-iter BOOTSTRAP_ITER] [--group-by GROUP_BY]
                      [--time-slices TIME_SLICES] [--rate-maps RATE_MAPS]
                      [--rate-map-threshold RATE_MAP_THRESHOLD]
                      [--map-pops MAP_POPS]
                      model arg_prefix

positional arguments:
  model                 The input YAML file specifying the model
  arg_prefix            The prefix of the input tree-seq file(s) specifying
                        the ARG. Assumes .trees file extension.

options:
  -h, --help            show this help message and exit
  --jobs JOBS, -j JOBS  Number of jobs (threads) to use. Defaults to 1.
  --seed SEED           Set the random seed.
  --verbose, -v         Verbose output, including timing information.
  --replicates REPLICATES, -r REPLICATES
                        Number of solver replications to perform. Defaults to
                        10 * num_epochs.
  --num-times NUM_TIMES, -t NUM_TIMES
                        Number of time slices to use. Defaults to 20. Use the
                        suffix 'l' or 'L' to use left-skewed time slices.
  --solve, -s           Solve the model after generating the solver inputs.
  --add-ground-truth, -g
                        Generate an additional solver input(s) using the
                        ground-truth parameter values.
  --suffix SUFFIX       Filenames will use the provided suffix instead of a
                        random one.
  --out-dir OUT_DIR, -o OUT_DIR
                        Output directory.
  --min-time-unit MIN_TIME_UNIT, -u MIN_TIME_UNIT
                        The minimum time unit for distinguishing between
                        coalescence events (default: 1.0 generation)
  --max-generation MAX_GENERATION, -m MAX_GENERATION
                        Ignore all coalescence events occuring after the given
                        generation (default: 1000000.0)
  --tree-sample-rate TREE_SAMPLE_RATE, -b TREE_SAMPLE_RATE
                        Sample a tree from the ARG every tree-sample-rate base
                        pairs (default: 125000 bp)
  --leave-out LEAVE_OUT
                        Comma-separated list of population IDs to leave out
                        when counting coalescence
  --bootstrap {,coalcounts,jackknife}
                        Bootstrap the sampled trees to create more than once
                        coalescent matrix. coalcounts: standard bootstrap of
                        over marginal trees. jackknife: leave-one-out jacktree
                        over blocks of marginal trees.
  --bootstrap-iter BOOTSTRAP_ITER, -i BOOTSTRAP_ITER
                        How many blocks to split the trees in for jackknifing,
                        number of reps for standard bootstrap. Default: 100
  --group-by GROUP_BY   Regex to group ARGs or coal files by. By default group
                        by chromosome for bootstrapping and by sample
                        otherwise.
  --time-slices TIME_SLICES
                        The comma-separated list of time slice values instead
                        of computing them from coalescence counts. Or, if
                        prefixed with '+', the list of time slices to append
                        to the auto-generated time slices.
  --rate-maps RATE_MAPS
                        A filename prefix for tskit-style RateMap files, whose
                        lexicographic sort order matches the input ARGs
                        lexicographic sort order. Generates a glob
                        '<prefix>*.txt'. Used for determining tree sampling
                        (see --rate-map-threshold)
  --rate-map-threshold RATE_MAP_THRESHOLD
                        Only sample trees from regions with a recombination
                        rate <= to this. Requires --rate-maps
  --map-pops MAP_POPS   A list of <idx1>:<idx2>, comma-separated, which maps a
                        particular population to another population, based on
                        their 0-based indices. Useful for when the ARG
                        populations are in a different order (or have ghosts)
                        compared to the model.
```


## mrpast_solve

### Tool Description
The solver input JSON files. The output filenames will be derived from the input filenames.

### Metadata
- **Docker Image**: quay.io/biocontainers/mrpast:0.2--py312h8f4af18_0
- **Homepage**: https://aprilweilab.github.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/mrpast/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mrpast solve [-h] [--timeout TIMEOUT] [--jobs JOBS] [--seed SEED]
                    [--verbose]
                    solver_inputs [solver_inputs ...]

positional arguments:
  solver_inputs         The solver input JSON files. The output filenames will
                        be derived from the input filenames.

options:
  -h, --help            show this help message and exit
  --timeout TIMEOUT     Timeout in seconds. Solver returns the current best
                        result upon timeout.
  --jobs JOBS, -j JOBS  Number of jobs (threads) to use. Defaults to 1.
  --seed SEED           Set the random seed.
  --verbose, -v         Verbose output, including timing information.
```


## mrpast_sim2vcf

### Tool Description
Convert .trees files to VCF format.

### Metadata
- **Docker Image**: quay.io/biocontainers/mrpast:0.2--py312h8f4af18_0
- **Homepage**: https://aprilweilab.github.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/mrpast/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mrpast sim2vcf [-h] [--prefix] [--leave-out LEAVE_OUT]
                      [--mut-rate MUT_RATE] [--zarr] [--jobs JOBS]
                      [--seed SEED] [--verbose]
                      arg_file

positional arguments:
  arg_file              The ARG (.trees) file to process.

options:
  -h, --help            show this help message and exit
  --prefix, -p          Treat arg_file as a prefix, and search for all
                        <arg_prefix>*.trees files
  --leave-out LEAVE_OUT
                        Comma-separated list of population IDs to leave out
                        when converting to VCF
  --mut-rate MUT_RATE   The mutation rate, for simulating mutations on
                        existing trees.
  --zarr, -z            Output VCF/ZARR files, required for tsinfer usage.
  --jobs JOBS, -j JOBS  Number of jobs (threads) to use. Defaults to 1.
  --seed SEED           Set the random seed.
  --verbose, -v         Verbose output, including timing information.
```


## mrpast_arginfer

### Tool Description
Infer ARG trees from VCF files.

### Metadata
- **Docker Image**: quay.io/biocontainers/mrpast:0.2--py312h8f4af18_0
- **Homepage**: https://aprilweilab.github.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/mrpast/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mrpast arginfer [-h] [--ne-override NE_OVERRIDE] [--mut-rate MUT_RATE]
                       [--recomb-rate RECOMB_RATE] [--samples SAMPLES]
                       [--thin THIN] [--dry-run]
                       [--tool {singer,relate,tsinfer}]
                       [--ancestral ANCESTRAL] [--jobs JOBS] [--seed SEED]
                       [--verbose]
                       vcf_prefix arg_prefix pop_map

positional arguments:
  vcf_prefix            The prefix of VCF file(s) to process. Generates a glob
                        "<vcf_prefix>*.vcf"
  arg_prefix            The prefix to use when writing the resulting ARGs to
                        disk (.trees files)
  pop_map               The file containing the population map (*.popmap.json)

options:
  -h, --help            show this help message and exit
  --ne-override NE_OVERRIDE, -N NE_OVERRIDE
                        Provide an override for the auto-calculated (diploid)
                        effective population size.
  --mut-rate MUT_RATE, -m MUT_RATE
                        Expected mutation rate. Default 1.2e-08.
  --recomb-rate RECOMB_RATE, -r RECOMB_RATE
                        Expected recombination rate, or recombination map
                        filename. Default 1e-08.
  --samples SAMPLES, -s SAMPLES
                        How many ARGS to sample. Default 10.
  --thin THIN, -t THIN  How many MC/MC iterations between samples. Default
                        depends on the inference tool.
  --dry-run, -d         Just emit the arguments that would be used when
                        running SINGER.
  --tool {singer,relate,tsinfer}
                        Which ARG inference tool to run: "tsinfer" (default),
                        "relate", or "singer"
  --ancestral ANCESTRAL, -a ANCESTRAL
                        The ancestral FASTA file (input). Assumes the
                        positions start counting at 1.
  --jobs JOBS, -j JOBS  Number of jobs (threads) to use. Defaults to 1.
  --seed SEED           Set the random seed.
  --verbose, -v         Verbose output, including timing information.
```


## mrpast_model

### Tool Description
Builds and manipulates demographic models.

### Metadata
- **Docker Image**: quay.io/biocontainers/mrpast:0.2--py312h8f4af18_0
- **Homepage**: https://aprilweilab.github.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/mrpast/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mrpast model [-h] [--to-demes TO_DEMES] [--debug] model

positional arguments:
  model                 The model YAML file

options:
  -h, --help            show this help message and exit
  --to-demes TO_DEMES, -d TO_DEMES
                        Write a Demes YAML file representing the model.
  --debug               Emit msprime demography debugger output for the given
                        model
```


## mrpast_init

### Tool Description
Initialize a mrpast model.

### Metadata
- **Docker Image**: quay.io/biocontainers/mrpast:0.2--py312h8f4af18_0
- **Homepage**: https://aprilweilab.github.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/mrpast/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mrpast init [-h]
                   [--from-demes FROM_DEMES | --from-old-mrpast FROM_OLD_MRPAST]

options:
  -h, --help            show this help message and exit
  --from-demes FROM_DEMES, -d FROM_DEMES
                        Convert a Demes YAML file into a mrpast model.
  --from-old-mrpast FROM_OLD_MRPAST
                        Convert an old matrix-based mrpast YAML file into a
                        current mrpast model.
```


## mrpast_confidence

### Tool Description
Solve for all bootstrapped samples instead of using GIM (theoretical).

### Metadata
- **Docker Image**: quay.io/biocontainers/mrpast:0.2--py312h8f4af18_0
- **Homepage**: https://aprilweilab.github.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/mrpast/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mrpast confidence [-h] [--bootstrap] [--replicates REPLICATES]
                         [--jobs JOBS] [--seed SEED] [--verbose]
                         solved_result

positional arguments:
  solved_result         A JSON file output by the solver.

options:
  -h, --help            show this help message and exit
  --bootstrap, -b       Solve for all bootstrapped samples instead of using
                        GIM (theoretical).
  --replicates REPLICATES, -r REPLICATES
                        Number of solver replications to perform per bootstrap
                        sample. Defaults to 10 * num_epochs.
  --jobs JOBS, -j JOBS  Number of jobs (threads) to use. Defaults to 1.
  --seed SEED           Set the random seed.
  --verbose, -v         Verbose output, including timing information.
```


## mrpast_polarize

### Tool Description
Polarize VCF file based on ancestral FASTA file.

### Metadata
- **Docker Image**: quay.io/biocontainers/mrpast:0.2--py312h8f4af18_0
- **Homepage**: https://aprilweilab.github.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/mrpast/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mrpast polarize [-h] vcf_file ancestral out_prefix

positional arguments:
  vcf_file    The input VCF file.
  ancestral   The ancestral FASTA file (input). Assumes the positions start
              counting at 1.
  out_prefix  The output prefix for the haps/sample results.

options:
  -h, --help  show this help message and exit
```


## mrpast_show

### Tool Description
Show results from mrpast solver.

### Metadata
- **Docker Image**: quay.io/biocontainers/mrpast:0.2--py312h8f4af18_0
- **Homepage**: https://aprilweilab.github.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/mrpast/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mrpast show [-h] [--sort-by SORT_BY] solved_result

positional arguments:
  solved_result         A JSON file output by the solver.

options:
  -h, --help            show this help message and exit
  --sort-by SORT_BY, -s SORT_BY
                        Sort parameters by the column name.
```


## mrpast_select

### Tool Description
Selects the best model based on AIC from multiple solver outputs.

### Metadata
- **Docker Image**: quay.io/biocontainers/mrpast:0.2--py312h8f4af18_0
- **Homepage**: https://aprilweilab.github.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/mrpast/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mrpast select [-h] [--bootstrap] solved_results [solved_results ...]

positional arguments:
  solved_results   Two or more JSON file output by the solver.

options:
  -h, --help       show this help message and exit
  --bootstrap, -b  Emit the distribution of AIC values for all bootstrapped
                   samples. Requires that you have previously run 'mrpast
                   confidence --bootstrap' to produce a .csv for each of the
                   solved_results.
```


## Metadata
- **Skill**: generated

## mrpast_mrpast simulate

### Tool Description
Simulate demographic histories using mr.py.

### Metadata
- **Docker Image**: quay.io/biocontainers/mrpast:0.2--py312h8f4af18_0
- **Homepage**: https://aprilweilab.github.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/mrpast/overview
- **Validation**: PASS
### Original Help Text
```text
usage: mrpast simulate [-h] [--jobs JOBS] [--seed SEED] [--verbose]
                       [--replicates REPLICATES] [--seq-len SEQ_LEN]
                       [--recomb-rate RECOMB_RATE] [--individuals INDIVIDUALS]
                       [--debug-demo]
                       model arg_prefix

positional arguments:
  model                 The input YAML file specifying the model
  arg_prefix            The prefix for the output tree-sequence files

options:
  -h, --help            show this help message and exit
  --jobs JOBS, -j JOBS  Number of jobs (threads) to use. Defaults to 1.
  --seed SEED           Set the random seed.
  --verbose, -v         Verbose output, including timing information.
  --replicates REPLICATES, -r REPLICATES
                        Number of simulation replications to perform. Defaults
                        to 20.
  --seq-len SEQ_LEN, -s SEQ_LEN
                        Length of sequences in base-pairs. Default to
                        100000000.
  --recomb-rate RECOMB_RATE, -e RECOMB_RATE
                        Rate of recombination, or filename/prefix for
                        recombination map. A prefix will match
                        '<prefix>*.txt'. Defaults to 1e-08.
  --individuals INDIVIDUALS, -n INDIVIDUALS
                        Number of individuals per population. Defaults to 10.
  --debug-demo, -d      Output results from msprime demography debugger.
```

## mrpast_mrpast solve

### Tool Description
Solve problems using the mrpast solver.

### Metadata
- **Docker Image**: quay.io/biocontainers/mrpast:0.2--py312h8f4af18_0
- **Homepage**: https://aprilweilab.github.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/mrpast/overview
- **Validation**: PASS
### Original Help Text
```text
usage: mrpast solve [-h] [--timeout TIMEOUT] [--jobs JOBS] [--seed SEED]
                    [--verbose]
                    solver_inputs [solver_inputs ...]

positional arguments:
  solver_inputs         The solver input JSON files. The output filenames will
                        be derived from the input filenames.

options:
  -h, --help            show this help message and exit
  --timeout TIMEOUT     Timeout in seconds. Solver returns the current best
                        result upon timeout.
  --jobs JOBS, -j JOBS  Number of jobs (threads) to use. Defaults to 1.
  --seed SEED           Set the random seed.
  --verbose, -v         Verbose output, including timing information.
```

