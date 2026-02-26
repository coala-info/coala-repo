# cpinsim CWL Generation Report

## cpinsim_annotate

### Tool Description
Annotates interaction, competition, and allosteric effect files based on provided constraints and network information.

### Metadata
- **Docker Image**: quay.io/biocontainers/cpinsim:0.5.2--py36_1
- **Homepage**: https://github.com/BiancaStoecker/cpinsim
- **Package**: https://anaconda.org/channels/bioconda/packages/cpinsim/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cpinsim/overview
- **Total Downloads**: 7.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/BiancaStoecker/cpinsim
- **Stars**: N/A
### Original Help Text
```text
usage: cpinsim annotate [-h]
                        [--interactions_without_constraints PATH [PATH ...]]
                        [--competitions PATH [PATH ...]]
                        [--allosteric_effects PATH [PATH ...]]
                        [--extended_inference] [--output_interactions PATH]
                        [--output_competitions PATH]
                        [--output_allosterics PATH]

optional arguments:
  -h, --help            show this help message and exit
  --interactions_without_constraints PATH [PATH ...], -i PATH [PATH ...]
                        Files containing the underlying network: pairwise
                        interactions without constraints. Two columns
                        InteractorA | InteractorB
  --competitions PATH [PATH ...], -c PATH [PATH ...]
                        Files containing the competitions. Two columns: Host |
                        Competitors (comma separated)
  --allosteric_effects PATH [PATH ...], -a PATH [PATH ...]
                        Files containing the allosteric effects. Four columns:
                        Host | Interactor | Activator | Inhibitor
  --extended_inference, -e
                        Extended inference for missing domains in
                        competitions.
  --output_interactions PATH, -oi PATH
                        One output file containing all annotated pairwise
                        interactions.
  --output_competitions PATH, -oc PATH
                        One output file containing all annotated competitions.
  --output_allosterics PATH, -oa PATH
                        One output file containing all annotated allosteric
                        effects.
```


## cpinsim_parse

### Tool Description
Parse protein interaction data from various file formats.

### Metadata
- **Docker Image**: quay.io/biocontainers/cpinsim:0.5.2--py36_1
- **Homepage**: https://github.com/BiancaStoecker/cpinsim
- **Package**: https://anaconda.org/channels/bioconda/packages/cpinsim/overview
- **Validation**: PASS

### Original Help Text
```text
usage: cpinsim parse [-h]
                     [--interactions_without_constraints INTERACTIONS_WITHOUT_CONSTRAINTS [INTERACTIONS_WITHOUT_CONSTRAINTS ...]]
                     [--competitions COMPETITIONS [COMPETITIONS ...]]
                     [--allosteric_effects ALLOSTERIC_EFFECTS [ALLOSTERIC_EFFECTS ...]]
                     [--output OUTPUT]

optional arguments:
  -h, --help            show this help message and exit
  --interactions_without_constraints INTERACTIONS_WITHOUT_CONSTRAINTS [INTERACTIONS_WITHOUT_CONSTRAINTS ...], -i INTERACTIONS_WITHOUT_CONSTRAINTS [INTERACTIONS_WITHOUT_CONSTRAINTS ...]
                        Files containing the annotated pairwise interactions.
  --competitions COMPETITIONS [COMPETITIONS ...], -c COMPETITIONS [COMPETITIONS ...]
                        Files containing the annotated competitions.
  --allosteric_effects ALLOSTERIC_EFFECTS [ALLOSTERIC_EFFECTS ...], -a ALLOSTERIC_EFFECTS [ALLOSTERIC_EFFECTS ...]
                        Files containing the annotated allosteric effects.
  --output OUTPUT, -o OUTPUT
                        Output file containing the parsed proteins.
```


## cpinsim_simulate

### Tool Description
Simulates protein interaction networks.

### Metadata
- **Docker Image**: quay.io/biocontainers/cpinsim:0.5.2--py36_1
- **Homepage**: https://github.com/BiancaStoecker/cpinsim
- **Package**: https://anaconda.org/channels/bioconda/packages/cpinsim/overview
- **Validation**: PASS

### Original Help Text
```text
usage: cpinsim simulate [-h]
                        [--concentrations MAX-PROTEIN-INSTANCES PATH/TO/CONCENTRATIONS | --number-of-copies N]
                        [--association-probability P]
                        [--dissociation-probability P] [--max-steps MAX_STEPS]
                        [--perturbation PROTEIN FACTOR] --output-graph PATH
                        [--output-log PATH]
                        proteins

positional arguments:
  proteins              Path to a csv-file containing the parsed proteins.

optional arguments:
  -h, --help            show this help message and exit
  --concentrations MAX-PROTEIN-INSTANCES PATH/TO/CONCENTRATIONS, -c MAX-PROTEIN-INSTANCES PATH/TO/CONCENTRATIONS
                        Maximum number of protein instances and path to a csv-
                        file containing a concentration for each protein.
  --number-of-copies N, -n N
                        Number of copies for each protein type.
  --association-probability P, -ap P
                        The probability for a new association between two
                        proteins (default: 0.005).
  --dissociation-probability P, -dp P
                        The probability for a dissociation of a pairwise
                        interaction (default: 0.0125).
  --max-steps MAX_STEPS, -m MAX_STEPS
                        Maximum number of simulation steps if convergence is
                        not reached until then (default: 1000).
  --perturbation PROTEIN FACTOR, -p PROTEIN FACTOR
                        Protein that should be overexpressed or down regulated
                        by factor FACTOR for perturbation analysis.
  --output-graph PATH, -og PATH
                        Pickle the complete graph at the end of simulation
                        (after last dissociation step) and write it to the
                        given path.
  --output-log PATH, -ol PATH
                        Write some log information of each simulation stept to
                        the given path. If not specified, std-out is used.
```

