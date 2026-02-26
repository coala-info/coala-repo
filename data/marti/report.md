# marti CWL Generation Report

## marti

### Tool Description
Metagenomic Analysis in Real TIme (MARTi) Engine

### Metadata
- **Docker Image**: quay.io/biocontainers/marti:0.9.29--hdfd78af_0
- **Homepage**: https://github.com/richardmleggett/MARTi
- **Package**: https://anaconda.org/channels/bioconda/packages/marti/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/marti/overview
- **Total Downloads**: 5.6K
- **Last updated**: 2025-09-10
- **GitHub**: https://github.com/richardmleggett/MARTi
- **Stars**: N/A
### Original Help Text
```text
Metagenomic Analysis in Real TIme (MARTi) Engine v0.9.29
Comments/bugs to: richard.leggett@earlham.ac.uk

To run a MARTi analysis:

    marti -config <file> [options]

Options:
-init to enter initialisation mode and output version information.
-options <filename> to specify the location of a marti_engine_options.txt file to use.
-loglevel <int> to set the level of logging to logs/engine.txt from 0 (none) to 5 (maximum) (default 1)
-fixrandom <long> to fix the random number seed used for debugging
-queue <name> to set default SLURM partition

To generate a new config file

    marti -writeconfig <file> [options]

To generate a new options file

    marti -writeoptions <file>
```

