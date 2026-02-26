# stripepy-hic CWL Generation Report

## stripepy-hic_stripepy

### Tool Description
stripepy is designed to recognize linear patterns in contact maps (.hic, .mcool, .cool) through the geometric reasoning, including topological persistence and quasi-interpolation.

### Metadata
- **Docker Image**: quay.io/biocontainers/stripepy-hic:1.3.0--pyh2a3209d_1
- **Homepage**: https://github.com/paulsengroup/StripePy
- **Package**: https://anaconda.org/channels/bioconda/packages/stripepy-hic/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/stripepy-hic/overview
- **Total Downloads**: 657
- **Last updated**: 2025-12-15
- **GitHub**: https://github.com/paulsengroup/StripePy
- **Stars**: N/A
### Original Help Text
```text
usage: stripepy {call,download,plot,view} ...

stripepy is designed to recognize linear patterns in contact maps (.hic, .mcool, .cool) through the geometric reasoning, including topological persistence and quasi-interpolation.

options:
  -h, --help            show this help message and exit
  --license             Print StripePy's license and return.
  --cite                Print StripePy's reference and return.
  -v, --version         show program's version number and exit

subcommands:
  {call,download,plot,view}
                        List of available subcommands:
    call                stripepy works in four consecutive steps:
                        • Step 1: Pre-processing
                        • Step 2: Recognition of loci of interest (also called 'seeds')
                        • Step 3: Shape analysis (i.e., width and height estimation)
                        • Step 4: Signal analysis
    download            Helper command to simplify downloading datasets that can be used to test StripePy.
    plot                Generate various static plots useful to visually inspect the output produced by stripepy call.
    view                Fetch stripes from the HDF5 file produced by stripepy call.
```

