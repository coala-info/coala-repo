# minimod CWL Generation Report

## minimod_view

### Tool Description
View modifications in reads using a reference genome and BAM file

### Metadata
- **Docker Image**: quay.io/biocontainers/minimod:0.4.0--h577a1d6_0
- **Homepage**: https://github.com/warp9seq/minimod
- **Package**: https://anaconda.org/channels/bioconda/packages/minimod/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/minimod/overview
- **Total Downloads**: 248
- **Last updated**: 2025-07-16
- **GitHub**: https://github.com/warp9seq/minimod
- **Stars**: N/A
### Original Help Text
```text
[view_main::INFO][1;34m Modification codes not provided. Using default modification code m[0m
[parse_mod_codes::INFO][1;34m Context not provided for modification code m. Using CG[0m
[print_view_options::INFO][1;34m Modification code: m, Context: CG[0m
[view_main::WARNING][1;33m Missing arguments[0m At src/view_main.c:249
Usage: minimod view ref.fa reads.bam

basic options:
   -c STR                     modification code(s) (eg. m, h or mh or as ChEBI) [m]
   -t INT                     number of processing threads [8]
   -K INT                     batch size (max number of reads loaded at once) [512]
   -B FLOAT[K/M/G]            max number of bases loaded at once [20.0M]
   -h                         help
   -p INT                     print progress every INT seconds (0: per batch) [0]
   -o FILE                    output file [stdout]
   --insertions               enable modifications in insertions [no]
   --haplotypes               enable haplotype mode [no]
   --verbose INT              verbosity level [4]
   --version                  print version

advanced options:
   --debug-break INT          break after processing the specified no. of batches
   --profile-cpu=yes|no       process section by section
```


## minimod_freq

### Tool Description
Calculate modification frequencies from reads aligned to a reference

### Metadata
- **Docker Image**: quay.io/biocontainers/minimod:0.4.0--h577a1d6_0
- **Homepage**: https://github.com/warp9seq/minimod
- **Package**: https://anaconda.org/channels/bioconda/packages/minimod/overview
- **Validation**: PASS

### Original Help Text
```text
[freq_main::INFO][1;34m Modification codes not provided. Using default modification code m[0m
[parse_mod_codes::INFO][1;34m Context not provided for modification code m. Using CG[0m
[freq_main::INFO][1;34m Modification threshold not provided. Using default threshold 0.8[0m
[parse_mod_threshes::INFO][1;34m Modification code: m, Context: CG, Threshold: 0.800000[0m
[parse_mod_threshes::INFO][1;34m Modification code: m, Context: CG, Threshold: 0.800000[0m
[freq_main::WARNING][1;33m Missing arguments[0m At src/freq_main.c:276
Usage: minimod freq ref.fa reads.bam

basic options:
   -b                         output in bedMethyl format [not set]
   -c STR                     modification code(s) (eg. m, h or mh or as ChEBI) [m]
   -m FLOAT                   min modification threshold(s). Comma separated values for each modification code given in -c [0.8]
   -t INT                     number of processing threads [8]
   -K INT                     batch size (max number of reads loaded at once) [512]
   -B FLOAT[K/M/G]            max number of bases loaded at once [20.0M]
   -h                         help
   -p INT                     print progress every INT seconds (0: per batch) [0]
   -o FILE                    output file [stdout]
   --insertions               enable modifications in insertions [no]
   --haplotypes               enable haplotype mode [no]
   --verbose INT              verbosity level [4]
   --version                  print version

advanced options:
   --debug-break INT          break after processing the specified no. of batches
```


## Metadata
- **Skill**: generated
