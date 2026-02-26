# bio-ting CWL Generation Report

## bio-ting_ting

### Tool Description
TCR analysis tool

### Metadata
- **Docker Image**: quay.io/biocontainers/bio-ting:1.1.0--py_0
- **Homepage**: https://github.com/FelixMoelder/ting
- **Package**: https://anaconda.org/channels/bioconda/packages/bio-ting/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bio-ting/overview
- **Total Downloads**: 7.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/FelixMoelder/ting
- **Stars**: N/A
### Original Help Text
```text
usage: ting [-h] -t TCR_SEQUENCES -r REFERENCE -k KMER_FILE -o OUTPUT [-b]
            [-ng] [-nl] [-p MAX_P_VALUE] [--gliph_minp GLIPH_MINP] [-f] [-g]

optional arguments:
  -h, --help            show this help message and exit
  -t TCR_SEQUENCES, --tcr_sequences TCR_SEQUENCES
                        File holding TCRs
  -r REFERENCE, --reference REFERENCE
                        Reference fasta file of naive CDR3 amino acid
                        sequences used for estimation of significant k-mers.
  -k KMER_FILE, --kmer_file KMER_FILE
                        tab separated file holding kmers in first row
  -o OUTPUT, --output OUTPUT
                        path of output-file
  -b, --use_structural_boundaries
                        First and last three amino acids are included in
                        processing
  -ng, --no_global      If set global clustering is excluded
  -nl, --no_local       If set local clustering is excluded
  -p MAX_P_VALUE, --max_p_value MAX_P_VALUE
                        p-value threshold for identifying significant k-mers
                        by fisher exact test
  --gliph_minp GLIPH_MINP
                        probability threshold for identifying significant
                        k-mers by gliph test
  -f, --stringent_filtering
                        If used only TCRs starting with a cystein and ending
                        with phenylalanine will be used
  -g, --kmers_gliph     If set kmers are identified by the non-deterministic
                        approach as implemented by gliph
```

