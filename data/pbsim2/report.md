# pbsim2 CWL Generation Report

## pbsim2

### Tool Description
FAIL to generate CWL: pbsim2 not found in Singularity image. The image may not provide this executable.

### Metadata
- **Docker Image**: quay.io/biocontainers/pbsim2:2.0.1--h9948957_4
- **Homepage**: https://github.com/yukiteruono/pbsim2
- **Package**: https://anaconda.org/channels/bioconda/packages/pbsim2/overview
- **Validation**: FAIL (generation failed)

- **Conda**: https://anaconda.org/channels/bioconda/packages/pbsim2/overview
- **Total Downloads**: 4.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/yukiteruono/pbsim2
- **Stars**: N/A
### Generation Failed

FAIL to generate CWL: pbsim2 not found in Singularity image. The image may not provide this executable.


### Validation Errors

- FAIL to generate CWL: pbsim2 not found in Singularity image. The image may not provide this executable.



### Original Help Text
```text

```


## Metadata
- **Skill**: generated

## pbsim2_pbsim

### Tool Description
Simulator for long-read sequencers (PacBio and Nanopore)

### Metadata
- **Docker Image**: quay.io/biocontainers/pbsim2:2.0.1--h9948957_4
- **Homepage**: https://github.com/yukiteruono/pbsim2
- **Package**: https://anaconda.org/channels/bioconda/packages/pbsim2/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
/usr/local/bin/pbsim: option '--hmm_model' requires an argument

USAGE: pbsim [options] <reference>

 <reference>           FASTA format file (text file only).

 [general options]

  --prefix             prefix of output files (sd).
  --id-prefix          prefix of read ID (S).
  --depth              depth of coverage (20.0).
  --length-min         minimum length (100).
  --length-max         maximum length (1000000).
  --difference-ratio   ratio of differences (6:50:54).
                       (substitution:insertion:deletion)
                       Each value must be 0-1000, e.g. 1000:1:0 is OK.
                       Note that the above default value is for PacBio, and
                       for Nanopore we recommend increasing substitution rate
                       and decreasing insertion rate, such as 23:31:46.
  --seed               for a pseudorandom number generator (Unix time).

 [options of sampling-based simulation]

  --sample-fastq       FASTQ format file to sample (text file only).
  --sample-profile-id  sample-fastq (filtered) profile ID.
                       when using --sample-fastq, profile is stored.
                       'sample_profile_<ID>.fastq', and
                       'sample_profile_<ID>.stats' are created.
                       when not using --sample-fastq, profile is re-used.
                       Note that when profile is used, --length-min,max,
                       --accuracy-min,max would be the same as the profile.
  --accuracy-min       minimum accuracy (0.75).
  --accuracy-max       maximum accuracy (1.00).

 [options of model-based simulation].

  --hmm_model          HMM model of quality code.
  --length-mean        mean of length model (9000.0).
  --length-sd          standard deviation of length model (7000.0).
  --accuracy-mean      mean of accuracy model (0.85).
```

