# dockq CWL Generation Report

## dockq_DockQ

### Tool Description
Quality measure for protein-protein docking models

### Metadata
- **Docker Image**: quay.io/biocontainers/dockq:2.1.3--py312h031d066_0
- **Homepage**: https://github.com/bjornwallner/DockQ
- **Package**: https://anaconda.org/channels/bioconda/packages/dockq/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/dockq/overview
- **Total Downloads**: 1.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/bjornwallner/DockQ
- **Stars**: N/A
### Original Help Text
```text
usage: DockQ [-h] [--capri_peptide] [--small_molecule] [--short]
             [--json out.json] [--verbose] [--no_align] [--n_cpu CPU]
             [--max_chunk CHUNK] [--allowed_mismatches ALLOWED_MISMATCHES]
             [--mapping MODELCHAINS:NATIVECHAINS]
             <model> <native>

DockQ - Quality measure for protein-protein docking models

positional arguments:
  <model>               Path to model file
  <native>              Path to native file

options:
  -h, --help            show this help message and exit
  --capri_peptide       use version for capri_peptide (DockQ cannot not be
                        trusted for this setting)
  --small_molecule      If the docking pose of a small molecule should be
                        evaluated
  --short               Short output
  --json out.json       Write outputs to a chosen json file
  --verbose, -v         Verbose output
  --no_align            Do not align native and model using sequence
                        alignments, but use the numbering of residues instead
  --n_cpu CPU           Number of cores to use
  --max_chunk CHUNK     Maximum size of chunks given to the cores, actual
                        chunksize is min(max_chunk,combos/cpus)
  --allowed_mismatches ALLOWED_MISMATCHES
                        Number of allowed mismatches when mapping model
                        sequence to native sequence.
  --mapping MODELCHAINS:NATIVECHAINS
                        Specify a chain mapping between model and native
                        structure. If the native contains two chains "H" and
                        "L" while the model contains two chains "A" and "B",
                        and chain A is a model of native chain H and chain B
                        is a model of native chain L, the flag can be set as:
                        '--mapping AB:HL'. This can also help limit the search
                        to specific native interfaces. For example, if the
                        native is a tetramer (ABCD) but the user is only
                        interested in the interface between chains B and C,
                        the flag can be set as: '--mapping :BC' or the
                        equivalent '--mapping *:BC'.
```

