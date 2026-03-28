# constava CWL Generation Report

## constava_fit-model

### Tool Description
The `constava fit-model` submodule is used to generate the probabilistic conformational state models used in the analysis. By default, when running `constava analyze` these models are generated on-the-fly. In selected cases generating a model beforehand and loading it can be useful, though.

We provide two model types. kde-Models are the default. They are fast to fit but may be slow in the inference in large conformational ensembles (e.g., long-timescale MD simulations). The idea of grid-Models is, to replace the continuous probability density function of the kde-Model by a fixed set of grid-points. The PDF for any sample is then estimated by linear interpolation between the nearest grid points. This is slightly less accurate than the kde-Model but speeds up inference significantly.

### Metadata
- **Docker Image**: quay.io/biocontainers/constava:1.2.0--pyhdfd78af_0
- **Homepage**: https://github.com/bio2byte/constava
- **Package**: https://anaconda.org/channels/bioconda/packages/constava/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/constava/overview
- **Total Downloads**: 844
- **Last updated**: 2026-02-05
- **GitHub**: https://github.com/bio2byte/constava
- **Stars**: N/A
### Original Help Text
```text
usage: constava fit-model [-h] [-i <file.json>] -o <file.pkl>
                          [--model-type {kde,grid}] [--kde-bandwidth <float>]
                          [--grid-points <int>] [--degrees] [-v]

The `constava fit-model` submodule is used to generate the probabilistic
conformational state models used in the analysis. By default, when running
`constava analyze` these models are generated on-the-fly. In selected cases
generating a model beforehand and loading it can be useful, though.

We provide two model types. kde-Models are the default. They are fast to fit
but may be slow in the inference in large conformational ensembles (e.g.,
long-timescale MD simulations). The idea of grid-Models is, to replace
the continuous probability density function of the kde-Model by a fixed set
of grid-points. The PDF for any sample is then estimated by linear
interpolation between the nearest grid points. This is slightly less
accurate than the kde-Model but speeds up inference significantly.

options:
  -h, --help            show this help message and exit

Input and output options:
  -i, --input <file.json>
                        The data to which the new conformational state models will
                        be fitted. It should be provided as a JSON file. The
                        top-most key should indicate the names of the
                        conformational states. On the level below, lists of phi-/
                        psi pairs for each stat should be provided. If not provided
                        the default data from the publication will be used.
  -o, --output <file.pkl>
                        Write the generated model to a pickled file, that can be
                        loaded gain using `constava analyze --load-model`

Conformational state model options:
  --model-type {kde,grid}
                        The probabilistic conformational state model used. The
                        default is `kde`. The alternative `grid` runs significantly
                        faster while slightly sacrificing accuracy: {'kde', 'grid'}
                        (default: 'kde')
  --kde-bandwidth <float>
                        This flag controls the bandwidth of the Gaussian kernel
                        density estimator. (default: 0.13)
  --grid-points <int>   This flag controls how many grid points are used to
                        describe the probability density function. Only applies if
                        `--model-type` is set to `grid`. (default: 10000)

Miscellaneous options:
  --degrees             Set this flag, if dihedrals in `model-data` are in degrees
                        instead of radians.
  -v, --verbose         Set verbosity level of screen output. Flag can be given
                        multiple times (up to 2) to gradually increase output to
                        debugging mode.
```


## constava_Fit

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/constava:1.2.0--pyhdfd78af_0
- **Homepage**: https://github.com/bio2byte/constava
- **Package**: https://anaconda.org/channels/bioconda/packages/constava/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
usage: constava [-h] [--version] {fit-model,analyze,dihedrals,test} ...
constava: error: argument subcommand: invalid choice: 'Fit' (choose from fit-model, analyze, dihedrals, test)
```


## constava_analyze

### Tool Description
The `constava analyze` submodule analyzes the provided backbone dihedral angles and infers the propensities for each residue to reside in a given conformational state.

### Metadata
- **Docker Image**: quay.io/biocontainers/constava:1.2.0--pyhdfd78af_0
- **Homepage**: https://github.com/bio2byte/constava
- **Package**: https://anaconda.org/channels/bioconda/packages/constava/overview
- **Validation**: PASS

### Original Help Text
```text
usage: constava analyze [-h] [-i <file.csv> [<file.csv> ...]]
                        [--input-format {auto,xvg,csv}] [-o <file.csv>]
                        [--output-format {auto,csv,json,tsv}] [-m <file.pkl>]
                        [--window <int> [<int> ...]]
                        [--window-series <int> [<int> ...]]
                        [--bootstrap <int> [<int> ...]]
                        [--bootstrap-series <int> [<int> ...]]
                        [--bootstrap-samples <int>] [--degrees]
                        [--precision <int>] [--indent_size <int>]
                        [--seed <int>] [-v]

The `constava analyze` submodule analyzes the provided backbone dihedral angles
and infers the propensities for each residue to reside in a given
conformational state.

Each conformational state is a statistical model of based on the backbone
dihedrals (phi, psi). The default models were derived from an analysis of NMR
ensembles and chemical shifts. To analyze a conformational ensemble, the phi-
and psi-angles for each conformational state in the ensemble need to be
provided.

As input data the backbone dihedral angles extracted from the conformational
ensemble need to be provided. Those can be generated using the
`constava dihedrals` submodule (`--input-format csv`) or GROMACS'
`gmx chi` module (`--input-format xvg`).

options:
  -h, --help            show this help message and exit

Input & output options:
  -i, --input <file.csv> [<file.csv> ...]
                        Input file(s) that contain the dihedral angles.
  --input-format {auto,xvg,csv}
                        Format of the input file: {'auto', 'csv', 'xvg'}
  -o, --output <file.csv>
                        The file to write the results to.
  --output-format {auto,csv,json,tsv}
                        Format of output file: {'csv', 'json', 'tsv'}. (default: 'auto')

Conformational state model options:
  -m, --load-model <file.pkl>
                        Load a conformational state model from the given pickled
                        file. If not provided, the default model will be used.

Sub-sampling options:
  --window <int> [<int> ...]
                        Do inference using a moving reading-frame. Each reading
                        frame consists of <int> consecutive samples. Multiple
                        values can be provided.
  --window-series <int> [<int> ...]
                        Do inference using a moving reading-frame. Each reading
                        frame consists of <int> consecutive samples. Return the
                        results for every window rather than the average. This can
                        result in very large output files. Multiple values can be
                        provided.
  --bootstrap <int> [<int> ...]
                        Do inference using <Int> samples obtained through
                        bootstrapping. Multiple values can be provided.
  --bootstrap-series <int> [<int> ...]
                        Do inference using <Int> samples obtained through
                        bootstrapping. Return the results for every subsample
                        rather than the average. This can result in very
                        large output files. Multiple values can be provided.
  --bootstrap-samples <int>
                        When bootstrapping, sample <Int> times from the input data.
                        (default: 500)

Miscellaneous options:
  --degrees             Set this flag, if dihedrals in the input files are in
                        degrees.
  --precision <int>     Sets the number of decimals in the output files.
  --indent_size <int>   Sets the number of spaces used to indent the output document.
  --seed <int>          Set random seed for bootstrap sampling
  -v, --verbose         Set verbosity level of screen output. Flag can be given
                        multiple times (up to 2) to gradually increase output to
                        debugging mode.
```


## constava_Analyze

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/constava:1.2.0--pyhdfd78af_0
- **Homepage**: https://github.com/bio2byte/constava
- **Package**: https://anaconda.org/channels/bioconda/packages/constava/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
usage: constava [-h] [--version] {fit-model,analyze,dihedrals,test} ...
constava: error: argument subcommand: invalid choice: 'Analyze' (choose from fit-model, analyze, dihedrals, test)
```


## constava_dihedrals

### Tool Description
The `constava dihedrals` submodule is used to extract the backbone dihedrals needed for the analysis from conformational ensembles. By default the results are written out in radians as this is the preferred format for `constava analyze`.

Note: For the first and last residue in a protein only one backbone dihedral can be extracted. Thus, those residues are omitted by default.

### Metadata
- **Docker Image**: quay.io/biocontainers/constava:1.2.0--pyhdfd78af_0
- **Homepage**: https://github.com/bio2byte/constava
- **Package**: https://anaconda.org/channels/bioconda/packages/constava/overview
- **Validation**: PASS

### Original Help Text
```text
usage: constava dihedrals [-h] [-s <file.pdb>]
                          [-f <file.xtc> [<file.xtc> ...]] [-o OUTPUT]
                          [--selection SELECTION] [--precision PRECISION]
                          [--degrees] [-O]

The `constava dihedrals` submodule is used to extract the backbone dihedrals
needed for the analysis from conformational ensembles. By default the results
are written out in radians as this is the preferred format for
`constava analyze`.

Note: For the first and last residue in a protein only one backbone dihedral
can be extracted. Thus, those residues are omitted by default.

options:
  -h, --help            show this help message and exit

Input & output options:
  -s, --structure <file.pdb>
                        Structure file with atomic information: [pdb, gro, tpr]
  -f, --trajectory <file.xtc> [<file.xtc> ...]
                        Trajectory file with coordinates: [pdb, gro, trr, xtc, crd, nc]
  -o, --output OUTPUT   CSV file to write dihedral information to. (default: dihedrals.csv)

Input & output options:
  --selection SELECTION
                        Selection for the dihedral calculation. (default: 'protein')
  --precision PRECISION
                        Defines the number of decimals written for the dihedrals. (default: 5)
  --degrees             If set results are written in degrees instead of radians.
  -O, --overwrite       If set any previously generated output will be overwritten.
```


## constava_Obtain

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/constava:1.2.0--pyhdfd78af_0
- **Homepage**: https://github.com/bio2byte/constava
- **Package**: https://anaconda.org/channels/bioconda/packages/constava/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
usage: constava [-h] [--version] {fit-model,analyze,dihedrals,test} ...
constava: error: argument subcommand: invalid choice: 'Obtain' (choose from fit-model, analyze, dihedrals, test)
```


## constava_test

### Tool Description
The `constava test` submodule runs a couple of test cases to check, if consistent results are achieved. This should be done once after installation and takes about a minute.

### Metadata
- **Docker Image**: quay.io/biocontainers/constava:1.2.0--pyhdfd78af_0
- **Homepage**: https://github.com/bio2byte/constava
- **Package**: https://anaconda.org/channels/bioconda/packages/constava/overview
- **Validation**: PASS

### Original Help Text
```text
usage: constava test [-h] [-v]

The `constava test` submodule runs a couple of test cases to check, if
consistent results are achieved. This should be done once after
installation and takes about a minute.

options:
  -h, --help     show this help message and exit
  -v, --verbose  Set verbosity level of screen output. Flag can be given
                 multiple times (up to 2) to gradually increase output to
                 debugging mode.
```


## constava_Run

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/constava:1.2.0--pyhdfd78af_0
- **Homepage**: https://github.com/bio2byte/constava
- **Package**: https://anaconda.org/channels/bioconda/packages/constava/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
usage: constava [-h] [--version] {fit-model,analyze,dihedrals,test} ...
constava: error: argument subcommand: invalid choice: 'Run' (choose from fit-model, analyze, dihedrals, test)
```


## Metadata
- **Skill**: generated
