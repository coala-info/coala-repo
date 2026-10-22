# trim_isoseq_polya CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| trim_isoseq_polya | PASS | new CWL for trim_isoseq_polyA; nf-core isoseq lima output converted to FASTA, all 104 polyA tails removed |

## trim_isoseq_polya

### Tool Description
Trims the polyA tail from the 3-prime ends of FASTA sequences (Iso-seq) using an HMM.

### Metadata
- **Docker Image**: quay.io/biocontainers/trim_isoseq_polya:0.0.3--h7c8eefc_0
- **Homepage**: https://github.com/PacificBiosciences/trim_isoseq_polyA
- **Package**: https://anaconda.org/channels/bioconda/packages/trim_isoseq_polya/overview
- **Validation**: PASS

### Original Help Text
```text
Error: the option '--input' is required but missing
this program trims the polyA tail specifically from the 3' ends of fasta files:
  -h [ --help ]                   display this help message and exit
  -i [ --input ] arg              The input fasta file with polyA, can be 
                                  compressed by gzip or bzip2
  -m [ --model ] arg              HMM model file to use; if not specified, will
                                  use default values
  -a [ --polyA_training ] arg     Fasta file with polyA sequences for training 
                                  with maximum-likelihood estimation
  -b [ --non_polyA_training ] arg Fasta file with non-polyA sequences for 
                                  training with maximum-likelihood estimation
  -n [ --new_model ] arg          New trained model file to output
  -c [ --color ]                  To color polyA sequences in the output 
                                  instead of trimming away them
  -t [ --thread ] arg (=8)        Number of threads to use
  -G [ --generic ]                Input is generic fasta format; By default, 
                                  this script adjusts the coordinate in the 
                                  header section of output fasta format for 
                                  Iso-seq input. This option switches off this 
                                  behavior.
```

