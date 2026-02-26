# riblast CWL Generation Report

## riblast_RIblast

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/riblast:1.2.0--h077b44d_2
- **Homepage**: https://github.com/fukunagatsu/RIblast
- **Package**: https://anaconda.org/channels/bioconda/packages/riblast/overview
- **Validation**: FAIL (generation failed)

- **Conda**: https://anaconda.org/channels/bioconda/packages/riblast/overview
- **Total Downloads**: 1.9K
- **Last updated**: 2025-06-24
- **GitHub**: https://github.com/fukunagatsu/RIblast
- **Stars**: N/A
### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
RIblast - RNA-RNA interaction preriction tool. v1.2.0

Options
db: convert a FASTA file to RIblast database files

RIblast db [-i InputFastaFile] [-o OutputDbName] [-r RepeatMaskingStyle]
           [-s LookupTableSize] [-w MaximalSpan] [-d MinAccessibleLength]

  Options:
 (Required)
    -i STR    RNA sequences in FASTA format
    -o STR    The database name

 (Optional)
    -r INT    Designation of repeat masking style. 0:hard-masking, 1:soft-masking, 2:no-masking [default:0]
    -s INT    Lookup table size of short string search [default: 8]
    -w INT    The constraint of maximal distance between the bases that form base pairs. This parameter must be 20 or above [default: 70]
    -d INT    Minimum accessible length for accessibility approximation [default:5]


ris: search RNA-RNA interaction between a query and database sequences

RIblast ris [-i InputFastaFile] [-o OutputFileName] [-d DatabaseFileName]
            [-l MaxSeedLength] [-e HybridizationEnergyThreshold] [-f InteractionEnergyThreshold]
            [-x DropOutLengthInGappedExtension] [-y DropOutLengthInUngappedExtension]
            [-g OutputEnergyThreshold] [-s OutputStyle]

  Options:
 (Required)
    -i STR    RNA sequences in FASTA format
    -o STR    Output file name
    -d STR    The database name

 (Optional)
    -l INT    Max size of seed length [default:20]
    -e DBL    Hybridization energy threshold for seed search [default: -6.0]
    -f DBL    Interaction energy threshold for removal of the interaction candidate before gapped extension [default: -4.0]
    -x INT    Dropout Length in gapped extension [default:16]
    -y INT    Dropout Length in ungapped extension [default:5]
    -g DBL    Energy threshold for output [default:-8.0]
    -s INT    Designation of output format style. 0:simplified output, 1:detailed output [default:0]
```

