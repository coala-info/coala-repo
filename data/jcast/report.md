# jcast CWL Generation Report

## jcast

### Tool Description
retrieves transcript splice junctionsand translates them into amino acid sequences

### Metadata
- **Docker Image**: quay.io/biocontainers/jcast:0.3.5--pyhdfd78af_0
- **Homepage**: https://github.com/ed-lau/jcast
- **Package**: https://anaconda.org/channels/bioconda/packages/jcast/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/jcast/overview
- **Total Downloads**: 21.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/ed-lau/jcast
- **Stars**: N/A
### Original Help Text
```text
usage: jcast [-h] [-o OUT] [-r READ] [-m] [-c] [-q q_lo q_hi]
             [--g_or_ln G_OR_LN]
             rmats_folder gtf_file genome

jcast retrieves transcript splice junctionsand translates them into amino acid
sequences

positional arguments:
  rmats_folder          path to folder storing rMATS output
  gtf_file              path to Ensembl gtf file
  genome                path to genome file

options:
  -h, --help            show this help message and exit
  -o OUT, --out OUT     name of the output files [default: psq_out]
  -r READ, --read READ  the lowest skipped junction read count for a junction
                        to be translated [default: 1]
  -m, --model           models junction read count cutoff using a Gaussian
                        mixture model [default: False]
  -c, --canonical       write out canonical protein sequence even if
                        transcriptslices are untranslatable [default: False]
  -q q_lo q_hi, --qvalue q_lo q_hi
                        take junctions with rMATS fdr within this threshold
                        [default: 0 1]
  --g_or_ln G_OR_LN     Switch on distribution to use for low end of
                        histogram, 0 for Gamma, anything else for LogNorm
```

