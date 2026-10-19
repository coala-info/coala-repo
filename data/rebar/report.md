# rebar CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| rebar_dataset_download | Failed | image problem: the image has no CA certificates, so downloading the sars-cov-2 dataset fails with 'unable to get local issuer certificate'; only the built-in toy1 dataset downloads. |
| rebar_dataset_list | PASS | Listed the datasets sars-cov-2 and toy1. |
| rebar_plot | PASS | Drew breakpoint plots for D and E from the toy1 run; the plot for D shows the A to B switch at position 12. |
| rebar_run | PASS | On the tool's toy1 dataset, found recombinants D (A,B at 12-12) and E (C,D at 4-4), matching the tool README. |
| rebar_simulate | PASS | Simulated a recombinant of A and B at breakpoint 12 on the toy1 dataset; the sequence is A up to 12 and B after. |

## rebar_dataset_list

### Tool Description
List the datasets that rebar can download.

### Metadata
- **Docker Image**: quay.io/biocontainers/rebar:0.2.1--h9ee0642_0
- **Homepage**: https://github.com/phac-nml/rebar
- **Package**: https://anaconda.org/channels/bioconda/packages/rebar/overview
- **Validation**: PASS

### Original Help Text
```text
List datasets

Usage: rebar dataset list [OPTIONS]

Options:
  -n, --name <NAME>            Dataset name
  -v, --verbosity <VERBOSITY>  Control output verbosity level [default: info] [possible values: info, warn, debug, error]
  -h, --help                   Print help
```

## rebar_dataset_download

### Tool Description
Download a dataset (populations, reference, annotations) for rebar.

### Metadata
- **Docker Image**: quay.io/biocontainers/rebar:0.2.1--h9ee0642_0
- **Homepage**: https://github.com/phac-nml/rebar
- **Package**: https://anaconda.org/channels/bioconda/packages/rebar/overview
- **Validation**: PASS

### Original Help Text
```text
Download dataset

Usage: rebar dataset download [OPTIONS] --name <NAME> --tag <TAG> --output-dir <OUTPUT_DIR>

Options:
  -r, --name <NAME>
          Dataset name

  -t, --tag <TAG>
          Dataset tag.
          
          A date (YYYY-MM-DD), or 'nightly', or 'custom'

  -o, --output-dir <OUTPUT_DIR>
          Output directory.
          
          If the directory does not exist, it will be created.

  -s, --summary <SUMMARY>
          Download dataset from a summary.json snapshot

  -v, --verbosity <VERBOSITY>
          Control output verbosity level
          
          [default: info]
          [possible values: info, warn, debug, error]

  -h, --help
          Print help (see a summary with '-h')
```

## rebar_run

### Tool Description
Detect recombination in a dataset population and/or an input alignment.

### Metadata
- **Docker Image**: quay.io/biocontainers/rebar:0.2.1--h9ee0642_0
- **Homepage**: https://github.com/phac-nml/rebar
- **Package**: https://anaconda.org/channels/bioconda/packages/rebar/overview
- **Validation**: PASS

### Original Help Text
```text
Detect recombination in a dataset population and/or input alignment.

Usage: rebar run [OPTIONS] --dataset-dir <DATASET_DIR> --output-dir <OUTPUT_DIR> <--populations <POPULATIONS>|--alignment <ALIGNMENT>>

Options:
  -d, --dataset-dir <DATASET_DIR>
          Dataset directory

      --populations <POPULATIONS>
          Input fasta alignment

      --alignment <ALIGNMENT>
          Input dataset population

      --parents <PARENTS>
          Restrict parent search to just these candidate parents

  -k, --knockout <KNOCKOUT>
          Remove these populations from the dataset.
          
          Regardless of whether you use '*' or not, all descendants of the specified populations will be removed.

  -v, --verbosity <VERBOSITY>
          Control output verbosity level
          
          [default: info]
          [possible values: info, warn, debug, error]

  -m, --mask <MASK>
          Number of bases to mask at the 5' and 3' ends.
          
          Comma separated. Use --mask 0,0 to disable masking.
          
          [default: 100 200]

  -i, --max-iter <MAX_ITER>
          Maximum number of search iterations to find each parent
          
          [default: 3]

      --max-parents <MAX_PARENTS>
          Maximum number of parents
          
          [default: 2]

      --min-parents <MIN_PARENTS>
          Minimum number of parents
          
          [default: 2]

  -c, --min-consecutive <MIN_CONSECUTIVE>
          Minimum number of consecutive bases in a parental region
          
          [default: 3]

  -l, --min-length <MIN_LENGTH>
          Minimum length of a parental region
          
          [default: 500]

  -s, --min-subs <MIN_SUBS>
          Minimum number of substitutions in a parental region
          
          [default: 1]

  -u, --naive
          Run a naive search, which does not use information about edge cases or known recombinant parents

  -o, --output-dir <OUTPUT_DIR>
          Output directory.
          
          If the directory does not exist, it will be created.

  -t, --threads <THREADS>
          Number of CPU threads to use
          
          [default: 1]

  -h, --help
          Print help (see a summary with '-h')
```

## rebar_plot

### Tool Description
Plot recombination from rebar run output.

### Metadata
- **Docker Image**: quay.io/biocontainers/rebar:0.2.1--h9ee0642_0
- **Homepage**: https://github.com/phac-nml/rebar
- **Package**: https://anaconda.org/channels/bioconda/packages/rebar/overview
- **Validation**: PASS

### Original Help Text
```text
Plot recombination from 'run' output.

Usage: rebar plot [OPTIONS] --run-dir <RUN_DIR>

Options:
  -r, --run-dir <RUN_DIR>
          Output directory from rebar run.
          
          Will plot all TSV files under barcodes/

  -b, --barcodes-file <BARCODES_FILE>
          A single barcodes TSV file to plot

  -a, --annotations <ANNOTATIONS>
          Dataset genome annotations

  -o, --output-dir <OUTPUT_DIR>
          Output directory for plots.
          
          Otherwise will default to 'plots/' under the --run-dir

  -p, --all-coords
          Draw all coordinates in barcodes file.
          
          By default, rebar wil only draw coordinates where the parent populations have different bases. As a result, private mutations at these coordinates will not be visualized. This flag will forcibly draw all coordinates in the barcodes file, but be warned, depending on the genome size and number of samples, this may cause a crash.

  -v, --verbosity <VERBOSITY>
          Control output verbosity level
          
          [default: info]
          [possible values: info, warn, debug, error]

  -h, --help
          Print help (see a summary with '-h')
```

## rebar_simulate

### Tool Description
Simulate recombination between parent populations of a dataset.

### Metadata
- **Docker Image**: quay.io/biocontainers/rebar:0.2.1--h9ee0642_0
- **Homepage**: https://github.com/phac-nml/rebar
- **Package**: https://anaconda.org/channels/bioconda/packages/rebar/overview
- **Validation**: PASS

### Original Help Text
```text
Simulate recombination.

Usage: rebar simulate [OPTIONS] --dataset-dir <DATASET_DIR> --parents <PARENTS> --output-dir <OUTPUT_DIR>

Options:
  -d, --dataset-dir <DATASET_DIR>
          Dataset directory

      --parents <PARENTS>
          Simulate recombination between these parents.
          
          5' -> 3'

      --breakpoints <BREAKPOINTS>
          Specify the breakpoints.
          
          If not provided, will be random.

  -o, --output-dir <OUTPUT_DIR>
          Output directory.
          
          If the directory does not exist, it will be created.

  -v, --verbosity <VERBOSITY>
          Control output verbosity level
          
          [default: info]
          [possible values: info, warn, debug, error]

  -h, --help
          Print help (see a summary with '-h')
```

## Metadata
- **Skill**: generated
