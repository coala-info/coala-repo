# taco CWL Generation Report

## taco_taco_refcomp

### Tool Description
Reference comparison tool for taco

### Metadata
- **Docker Image**: quay.io/biocontainers/taco:0.7.3--py27_0
- **Homepage**: https://github.com/tacorna/taco
- **Package**: https://anaconda.org/channels/bioconda/packages/taco/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/taco/overview
- **Total Downloads**: 12.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/tacorna/taco
- **Stars**: N/A
### Original Help Text
```text
usage: taco_refcomp [-h] [-v] [-o OUTPUT_DIR] [-p NUM_CORES] [--cpat]
                    [--cpat-species CPAT_SPEC] [--cpat-genome CPAT_GEN]
                    [-r REF_GTF_FILE] [-t TEST_GTF_FILE]

optional arguments:
  -h, --help            show this help message and exit
  -v, --verbose
  -o OUTPUT_DIR, --output-dir OUTPUT_DIR
                        Directory for reference comparison output (default:
                        taco_compare)
  -p NUM_CORES, --num-processes NUM_CORES
                        Run tool in parallel with N processes. (note: each
                        core processes 1 chromosome) (default: 1)
  --cpat                Run CPAT tool to for coding potential scoring. (CPAT
                        function currently only supports Human, Mouse, and
                        Zebrafish) (WARNING: The CPAT tool can take over an
                        hour) (default: False)
  --cpat-species CPAT_SPEC
                        Select either: human, mouse, zebrafish (default:
                        human)
  --cpat-genome CPAT_GEN
                        Provide a genome fasta for the genome used to produce
                        assemblies being compared. Required if "--cpat" used.
                        CPAT uses this to obtain sequence for the provided
                        transcripts (default: None)
  -r REF_GTF_FILE, --ref-gtf REF_GTF_FILE
                        Reference GTF file to compare against (default: None)
  -t TEST_GTF_FILE, --test-gtf TEST_GTF_FILE
                        GTF file used for comparison (default: None)
```

