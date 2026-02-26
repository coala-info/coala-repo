# fuma CWL Generation Report

## fuma

### Tool Description
fuma

### Metadata
- **Docker Image**: quay.io/biocontainers/fuma:4.0.0--pyhb7b1952_0
- **Homepage**: https://github.com/yhoogstrate/fuma/
- **Package**: https://anaconda.org/channels/bioconda/packages/fuma/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/fuma/overview
- **Total Downloads**: 20.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/yhoogstrate/fuma
- **Stars**: N/A
### Original Help Text
```text
usage: fuma [-h] [-V] [--formats] [-m {overlap,subset,egm}]
            [--strand-specific-matching] [--no-strand-specific-matching]
            [--acceptor-donor-order-specific-matching]
            [--no-acceptor-donor-order-specific-matching] [--verbose]
            [-a [ADD_GENE_ANNOTATION ...]] -s ADD_SAMPLE [ADD_SAMPLE ...]
            [-l [LINK_SAMPLE_TO_ANNOTATION ...]] [-f {summary,list,extensive}]
            [-g LONG_GENE_SIZE] [-o OUTPUT]

optional arguments:
  -h, --help            show this help message and exit
  -V, --version         show program's version number and exit
  --formats             show accepted dataset formats
  -m {overlap,subset,egm}, --matching-method {overlap,subset,egm}
                        The used method to match two gene sets. Overlap
                        matches when two gene set have one or more genes
                        overlapping. Subset matches when one gene set is a
                        subset of the other. EGM is exact gene matching; all
                        genes in both sets need to be identical to match.
  --strand-specific-matching
                        Consider fusion genes distinct when the breakpoints
                        have different strands: (A<-,B<-) != (->A,B<-);
                        default
  --no-strand-specific-matching
                        Consider fusion genes identical when the breakpoints
                        have different strands: (A<-,B<-) == (->A,B<-)
  --acceptor-donor-order-specific-matching
                        Consider fusion genes distinct when the donor and
                        acceptor sites are swapped: (A,B) != (B,A)
  --no-acceptor-donor-order-specific-matching
                        Consider fusion genes identical when the donor and
                        acceptor sites are swapped: (A,B) == (B,A); default
  --verbose             increase output verbosity
  -a [ADD_GENE_ANNOTATION ...], --add-gene-annotation [ADD_GENE_ANNOTATION ...]
                        annotation_alias:filename * file in BED format
  -s ADD_SAMPLE [ADD_SAMPLE ...], --add-sample ADD_SAMPLE [ADD_SAMPLE ...]
                        sample_alias:format:filename (available formats: fuma
                        --formats)
  -l [LINK_SAMPLE_TO_ANNOTATION ...], --link-sample-to-annotation [LINK_SAMPLE_TO_ANNOTATION ...]
                        sample_alias:annotation_alias
  -f {summary,list,extensive}, --format {summary,list,extensive}
                        Output-format
  -g LONG_GENE_SIZE, --long-gene-size LONG_GENE_SIZE
                        Gene-name based matching is more sensitive to long
                        genes. This is the gene size used to mark fusion genes
                        spanning a 'long gene' as reported the output. Use 0
                        to disable this feature.
  -o OUTPUT, --output OUTPUT
                        output filename; '-' for stdout

For more info please visit:
<https://github.com/yhoogstrate/fuma>
```

