# pbsim CWL Generation Report

## pbsim

### Tool Description
PacBio read simulator for sampling-based or model-based simulation

### Metadata
- **Docker Image**: biocontainers/pbsim:v1.0.3-2-deb_cv1
- **Homepage**: https://github.com/yukiteruono/pbsim3
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pbsim/overview
- **Total Downloads**: 10.0K
- **Last updated**: 2025-08-19
- **GitHub**: https://github.com/yukiteruono/pbsim3
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image

USAGE: pbsim [options] <reference>

 <reference>           FASTA format file.

 [general options]

  --prefix             prefix of output files (sd).
  --data-type          data type. CLR or CCS (CLR).
  --depth              depth of coverage (CLR: 20.0, CCS: 50.0).
  --length-min         minimum length (100).
  --length-max         maximum length (CLR: 25000, CCS: 2500).
  --accuracy-min       minimum accuracy.
                       (CLR: 0.75, CCS: fixed as 0.75).
                       this option can be used only in case of CLR.
  --accuracy-max       maximum accuracy.
                       (CLR: 1.00, CCS: fixed as 1.00).
                       this option can be used only in case of CLR.
  --difference-ratio   ratio of differences. substitution:insertion:deletion.
                       each value up to 1000 (CLR: 10:60:30, CCS:6:21:73).
  --seed               for a pseudorandom number generator (Unix time).

 [options of sampling-based simulation]

  --sample-fastq       FASTQ format file to sample.
  --sample-profile-id  sample-fastq (filtered) profile ID.
                       when using --sample-fastq, profile is stored.
                       'sample_profile_<ID>.fastq', and
                       'sample_profile_<ID>.stats' are created.
                       when not using --sample-fastq, profile is re-used.
                       Note that when profile is used, --length-min,max,
                       --accuracy-min,max would be the same as the profile.

 [options of model-based simulation].

  --model_qc           model of quality code.
  --length-mean        mean of length model (CLR: 3000.0, CCS:450.0).
  --length-sd          standard deviation of length model.
                       (CLR: 2300.0, CCS: 170.0).
  --accuracy-mean      mean of accuracy model.
                       (CLR: 0.78, CCS: fixed as 0.98).
                       this option can be used only in case of CLR.
  --accuracy-sd        standard deviation of accuracy model.
                       (CLR: 0.02, CCS: fixed as 0.02).
                       this option can be used only in case of CLR.
```


## Metadata
- **Skill**: generated
