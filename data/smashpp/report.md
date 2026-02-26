# smashpp CWL Generation Report

## smashpp

### Tool Description
SMASH++: a fast and accurate tool for detecting structural variations in DNA sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/smashpp:23.09--h9948957_1
- **Homepage**: https://github.com/smortezah/smashpp
- **Package**: https://anaconda.org/channels/bioconda/packages/smashpp/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/smashpp/overview
- **Total Downloads**: 12.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/smortezah/smashpp
- **Stars**: N/A
### Original Help Text
```text
[1mSYNOPSIS[0m
      ./smashpp [OPTIONS]  -r <REF_FILE>  -t <TAR_FILE>

[1mSAMPLE[0m
      ./smashpp -r ref -t tar -l 0 -m 1000
      ./smashpp \ 
          --reference ref \ 
          --target tar \ 
          --format json \ 
          --verbose 

[1mOPTIONS[0m
    [3mRequired[0m:
      [1m-r[0m, [1m--reference[0m <FILE>       reference file (Seq/FASTA/FASTQ)
      [1m-t[0m, [1m--target[0m <FILE>          target file    (Seq/FASTA/FASTQ)

    [3mOptional[0m:
      [1m-l[0m, [1m--level[0m <INT>
            level of compression: 0 to 6. Default: 3

      [1m-m[0m, [1m--min-segment-size[0m <INT>
            minimum segment size: 1 to 4294967295. Default: 50

      [1m-fmt[0m, [1m--format[0m <STRING>
            format of the output (position) file: {pos, json}.
            Default: pos

      [1m-e[0m, [1m--entropy-N[0m <FLOAT>
            entropy of 'N's: 0.0 to 100.0. Default: 2.0

      [1m-n[0m, [1m--num-threads[0m <INT>
            number of threads: 1 to 255. Default: 4

      [1m-f[0m, [1m--filter-size[0m <INT>
            filter size: 1 to 4294967295. Default: 100

      [1m-ft[0m, [1m--filter-type[0m <INT/STRING>
            filter type (windowing function): {0/rectangular,
            1/hamming, 2/hann, 3/blackman, 4/triangular, 5/welch,
            6/sine, 7/nuttall}. Default: hann

      [1m-fs[0m, [1m--filter-scale[0m <STRING>
            filter scale: {S/small, M/medium, L/large}

      [1m-d[0m, [1m--sampling-step[0m <INT>
            sampling step. Default: 1

      [1m-th[0m, [1m--threshold[0m <FLOAT>
            threshold: 0.0 to 20.0. Default: 1.5

      [1m-rb[0m, [1m--reference-begin-guard[0m <INT>
            reference begin guard: -32768 to 32767. Default: 0

      [1m-re[0m, [1m--reference-end-guard[0m <INT>
            reference ending guard: -32768 to 32767. Default: 0

      [1m-tb[0m, [1m--target-begin-guard[0m <INT>
            target begin guard: -32768 to 32767. Default: 0

      [1m-te[0m, [1m--target-end-guard[0m <INT>
            target ending guard: -32768 to 32767. Default: 0

      [1m-ar[0m, [1m--asymmetric-regions[0m
            consider asymmetric regions. Default: not used

      [1m-nr[0m, [1m--no-self-complexity[0m
            do not compute self complexity. Default: not used

      [1m-sb[0m, [1m--save-sequence[0m
            save sequence (input: FASTA/FASTQ). Default: not used

      [1m-sp[0m, [1m--save-profile[0m
            save profile (*.prf). Default: not used

      [1m-sf[0m, [1m--save-filtered[0m
            save filtered file (*.fil). Default: not used

      [1m-ss[0m, [1m--save-segmented[0m
            save segmented files (*.s[i]). Default: not used

      [1m-sa[0m, [1m--save-profile-filtered-segmented[0m
            save profile, filetered and segmented files.
            Default: not used

      [1m-rm[0m, [1m--reference-model[0m  [3mk[0m,[[3mw[0m,[3md[0m,]ir,[3ma[0m,[3mg[0m/[3mt[0m,ir,[3ma[0m,[3mg[0m:...
      [1m-tm[0m, [1m--target-model[0m     [3mk[0m,[[3mw[0m,[3md[0m,]ir,[3ma[0m,[3mg[0m/[3mt[0m,ir,[3ma[0m,[3mg[0m:...
            parameters of models
                <INT>  [3mk[0m:  context size
                <INT>  [3mw[0m:  width of sketch in log2 form,
                           e.g., set 10 for w=2^10=1024
                <INT>  [3md[0m:  depth of sketch
                <INT>  [3mir[0m: inverted repeat: {0, 1, 2}
                           0: regular (not inverted)
                           1: inverted, solely
                           2: both regular and inverted
              <FLOAT>  [3ma[0m:  estimator
              <FLOAT>  [3mg[0m:  forgetting factor: 0.0 to 1.0
                <INT>  [3mt[0m:  threshold (number of substitutions)

      [1m-ll[0m, [1m--list-levels[0m
            list of compression levels

      [1m-h[0m, [1m--help[0m
            usage guide

      [1m-v[0m, [1m--verbose[0m
            more information

      [1m-V[0m, [1m--version[0m
            show version

[1mAUTHOR[0m
      Morteza Hosseini      mhosayny@gmail.com
```

