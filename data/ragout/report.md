# ragout CWL Generation Report

## ragout

### Tool Description
Chromosome assembly with multiple references

### Metadata
- **Docker Image**: quay.io/biocontainers/ragout:2.3--py36hc9558a2_0
- **Homepage**: https://github.com/fenderglass/Ragout
- **Package**: https://anaconda.org/channels/bioconda/packages/ragout/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ragout/overview
- **Total Downloads**: 36.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/fenderglass/Ragout
- **Stars**: N/A
### Original Help Text
```text
usage: ragout [-h] [-o output_dir] [-s {sibelia,maf,hal}] [--refine]
              [--solid-scaffolds] [--overwrite] [--repeats] [--debug]
              [-t THREADS] [--version]
              recipe_file

Chromosome assembly with multiple references

positional arguments:
  recipe_file           path to recipe file

optional arguments:
  -h, --help            show this help message and exit
  -o output_dir, --outdir output_dir
                        output directory (default: ragout-out)
  -s {sibelia,maf,hal}, --synteny {sibelia,maf,hal}
                        backend for synteny block decomposition (default:
                        sibelia)
  --refine              enable refinement with assembly graph (default: False)
  --solid-scaffolds     do not break input sequences - disables chimera
                        detection module (default: False)
  --overwrite           overwrite results from the previous run (default:
                        False)
  --repeats             enable repeat resolution algorithm (default: False)
  --debug               enable debug output (default: False)
  -t THREADS, --threads THREADS
                        number of threads for synteny backend (default: 1)
  --version             show program's version number and exit
```


## Metadata
- **Skill**: generated
