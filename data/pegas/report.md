# pegas CWL Generation Report

## pegas

### Tool Description
Run the PeGAS pipeline.

### Metadata
- **Docker Image**: quay.io/biocontainers/pegas:1.2.3--pyhdfd78af_0
- **Homepage**: https://github.com/liviurotiul/PeGAS
- **Package**: https://anaconda.org/channels/bioconda/packages/pegas/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pegas/overview
- **Total Downloads**: 3.3K
- **Last updated**: 2026-02-12
- **GitHub**: https://github.com/liviurotiul/PeGAS
- **Stars**: N/A
### Original Help Text
```text
usage: pegas [-h] -d DATA -o OUTPUT [-c CORES] [--overwrite]
             [--shovill-cpu-cores SHOVILL_CPU_CORES]
             [--shovill-ram SHOVILL_RAM] [--prokka-cpu-cores PROKKA_CPU_CORES]
             [--roary-cpu-cores ROARY_CPU_CORES] [--interactive]

Run the PeGAS pipeline.

options:
  -h, --help            show this help message and exit
  -d, --data DATA       Directory with fastq.gz files
  -o, --output OUTPUT   Directory for outputs
  -c, --cores CORES     Total cores to use (default: all)
  --overwrite           Overwrite output dir if it exists
  --shovill-cpu-cores SHOVILL_CPU_CORES
  --shovill-ram SHOVILL_RAM
                        RAM (GB) to allocate to Shovill
  --prokka-cpu-cores PROKKA_CPU_CORES
  --roary-cpu-cores ROARY_CPU_CORES
  --interactive         Generate the interactive HTML report (optional)
```

