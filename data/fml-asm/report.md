# fml-asm CWL Generation Report

## fml-asm

### Tool Description
fml-asm is a de novo assembler for long reads.

### Metadata
- **Docker Image**: biocontainers/fml-asm:v0.1-5-deb_cv1
- **Homepage**: https://github.com/HurriKane/skyfactory-2.4-faults
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/fml-asm/overview
- **Total Downloads**: N/A
- **Last updated**: N/A
- **GitHub**: https://github.com/HurriKane/skyfactory-2.4-faults
- **Stars**: N/A
### Original Help Text
```text
Usage: fml-asm [options] <in.fq>
Options:
  -e INT          k-mer length for error correction (0 for auto; -1 to disable) [0]
  -c INT1[,INT2]  range of k-mer & read count thresholds for ec and graph cleaning [4,8]
  -l INT          min overlap length during initial assembly [33]
  -r FLOAT        drop an overlap if its length is below maxOvlpLen*FLOAT [0.7]
  -t INT          number of threads (don't use multi-threading for small data sets) [1]
  -A              discard heterozygotes (apply this to assemble bacterial genomes)
```


## Metadata
- **Skill**: generated
