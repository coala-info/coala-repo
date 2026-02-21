# pbsim3 CWL Generation Report

## pbsim3

### Tool Description
FAIL to generate CWL: pbsim3 not found in Singularity image. The image may not provide this executable.

### Metadata
- **Docker Image**: quay.io/biocontainers/pbsim3:3.0.5--h9948957_2
- **Homepage**: https://github.com/yukiteruono/pbsim3
- **Package**: https://anaconda.org/channels/bioconda/packages/pbsim3/overview
- **Validation**: FAIL (generation failed)

- **Conda**: https://anaconda.org/channels/bioconda/packages/pbsim3/overview
- **Total Downloads**: 4.3K
- **Last updated**: 2025-08-12
- **GitHub**: https://github.com/yukiteruono/pbsim3
- **Stars**: N/A
### Generation Failed

FAIL to generate CWL: pbsim3 not found in Singularity image. The image may not provide this executable.


### Validation Errors

- FAIL to generate CWL: pbsim3 not found in Singularity image. The image may not provide this executable.



### Original Help Text
```text

```


## Metadata
- **Skill**: generated

## pbsim3_pbsim

### Tool Description
Simulator for long-read sequencers (PacBio and ONT)

### Metadata
- **Docker Image**: quay.io/biocontainers/pbsim3:3.0.5--h9948957_2
- **Homepage**: https://github.com/yukiteruono/pbsim3
- **Package**: https://anaconda.org/channels/bioconda/packages/pbsim3/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image

USAGE: pbsim [options] 

 [general options]

  --prefix             prefix of output files (sd).
  --id-prefix          prefix of read ID (S).
  --seed               for a pseudorandom number generator (Unix time).

 [options for whole genome sequencing]

  --strategy           wgs
  --genome             FASTA format file (text file only).
  --depth              depth of coverage (20.0).
  --length-min         minimum length (100).
  --length-max         maximum length (1000000).

 [options for transcriptome sequencing]

  --strategy           trans
  --transcript         original format file.
  --length-min         minimum length (100).
  --length-max         maximum length (1000000).

 [options for template sequencing]

  --strategy           templ
  --template           FASTA format file (text file only).

 [options for quality score model]

  --method             qshmm
  --qshmm              quality score model.
  --length-mean        mean length (9000.0).
  --length-sd          standard deviation of length (7000.0).
  --accuracy-mean      mean accuracy (0.85).
  --pass-num           number of sequencing passes (1).
  --difference-ratio   difference (error) ratio (6:55:39).
                       (substitution:insertion:deletion)
                       Each value must be 0-1000, e.g. 1000:1:0 is OK.
                       Note that the above default value is for PacBio RS II;
                       22:45:33 for PacBio Sequel and 39:24:36 for ONT are
                       recommended.
  --hp-del-bias        bias intensity of deletion in homopolymer (1).
                       The option specifies the deletion rate at 10-mer, where
                       the deletion rate at 1-mer is 1. The bias intensity from
                       1-mer to 10-mer is proportional to the length of the
                       homopolymer.

 [options for error model]

  --method             errhmm
  --errhmm             error model.
  --length-mean        mean length (9000.0).
  --length-sd          standard deviation of length (7000.0).
  --accuracy-mean      mean accuracy (0.85).
  --pass-num           number of sequencing passes (1).

 [options for sample-based method]

 Note that the method can only be used for wag strategy.

  --sample             FASTQ format file to sample (text file only).
  --sample-profile-id  sample (filtered) profile ID.
                       When using --sample, profile is stored;
                       'sample_profile_<ID>.fastq', and
                       'sample_profile_<ID>.stats' are created.
                       When not using --sample, profile is re-used.
                       Note that when profile is used, --length-min,max,
                       --accuracy-min,max would be the same as the profile.
  --accuracy-min       minimum accuracy (0.75).
  --accuracy-max       maximum accuracy (1.00).
  --difference-ratio   difference (error) ratio (6:55:39).
                       (substitution:insertion:deletion)
                       Each value must be 0-1000, e.g. 1000:1:0 is OK.
                       Note that the above default value is for PacBio RS II;
                       22:45:33 for PacBio Sequel and 39:24:36 for ONT are
                       recommended.
  --hp-del-bias        bias intensity of deletion in homopolymer (1).
                       The option specifies the deletion rate at 10-mer, where
                       the deletion rate at 1-mer is 1. The bias intensity from
                       1-mer to 10-mer is proportional to the length of the
                       homopolymer.
```

