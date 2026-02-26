# hmtnote CWL Generation Report

## hmtnote_annotate

### Tool Description
Annotate a VCF file using data from HmtVar.

### Metadata
- **Docker Image**: quay.io/biocontainers/hmtnote:0.7.2--pyhdfd78af_1
- **Homepage**: https://github.com/robertopreste/hmtnote
- **Package**: https://anaconda.org/channels/bioconda/packages/hmtnote/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/hmtnote/overview
- **Total Downloads**: 2.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/robertopreste/hmtnote
- **Stars**: N/A
### Original Help Text
```text
Usage: hmtnote annotate [OPTIONS] INPUT_VCF OUTPUT_VCF

  Annotate a VCF file using data from HmtVar.

  If neither ``--basic``, ``--crossref``, ``--variab`` nor ``--predict`` are
  provided, they will all default to True, and the VCF will be annotated using
  all the available information. If no internet connection is available, use
  the ``--offline`` option to use the local database for annotation (you must
  have previously downloaded it using the ``hmtnote dump`` command). If
  ``csv`` is set to True, an additional annotated CSV file will be produced
  (along with the annotated VCF file) with the same base name and in the same
  path as the provided ``output_vcf`` argument.

Options:
  -b, --basic     Annotate VCF using basic information (locus,  pathogenicity,
                  etc.) (default: False)
  -c, --crossref  Annotate VCF using cross-reference information (Clinvar  and
                  dbSNP IDs, etc.) (default: False)
  -v, --variab    Annotate VCF using variability information (nucleotide  and
                  aminoacid variability, allele frequencies) (default: False)
  -p, --predict   Annotate VCF using predictions information (from MutPred,
                  Panther, Polyphen and other resources) (default: False)
  -o, --offline   Annotate VCF using previously downloaded databases  (offline
                  mode) (default: False)
  -C, --csv       Produce an additional annotated CSV file (default: False)
  --help          Show this message and exit.
```


## hmtnote_dump

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/hmtnote:0.7.2--pyhdfd78af_1
- **Homepage**: https://github.com/robertopreste/hmtnote
- **Package**: https://anaconda.org/channels/bioconda/packages/hmtnote/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Usage: hmtnote dump [OPTIONS]

  Download databases from HmtVar for offline annotation.

Options:
  --help  Show this message and exit.
```

