# umi-transfer CWL Generation Report

## umi-transfer_external

### Tool Description
Integrate UMIs from a separate FastQ file

### Metadata
- **Docker Image**: quay.io/biocontainers/umi-transfer:1.6.0--hc1c3326_0
- **Homepage**: https://github.com/SciLifeLab/umi-transfer
- **Package**: https://anaconda.org/channels/bioconda/packages/umi-transfer/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/umi-transfer/overview
- **Total Downloads**: 3.5K
- **Last updated**: 2025-11-28
- **GitHub**: https://github.com/SciLifeLab/umi-transfer
- **Stars**: N/A
### Original Help Text
```text
░░░░░░░░░░░░░░░░░░░░░░░░░░░ SciLifeLab - National Genomics Infrastructure ░░░░░░░░░░░░░░░░░░░░░░░░░░░                                              

https://www.scilifelab.se
https://ngisweden.scilifelab.se
https://github.com/SciLifeLab/umi-transfer                                      

Integrate UMIs from a separate FastQ file

Usage: umi-transfer external [OPTIONS] --in <R1_IN> --in2 <R2_IN> --umi <RU_IN>

Options:
  -p, --position <TARGET_POSITION>
          Choose the target position for the UMI: 'header' or 'inline'. Defaults to 'header'.
                  
            [default: header] [possible values: header, inline]
  -c, --correct_numbers
          Read numbers will be altered to ensure the canonical read numbers 1 and 2 in output file sequence headers.
                  
           
  -z, --gzip
          Compress output files. Turned off by default.
                  
           
  -l, --compression_level <COMPRESSION_LEVEL>
          Choose the compression level: Maximum 9, defaults to 3. Higher numbers result in smaller files but take longer to compress.
                  
           
  -t, --threads <NUM_THREADS>
          Maximum number of threads to use for processing. Preferably pick odd numbers, 9 or 11 recommended. Defaults to the maximum number of cores available.
                  
           
  -f, --force
          Overwrite existing output files without further warnings or prompts.
                  
           
  -d, --delim <DELIM>
          Delimiter to use when joining the UMIs to the read name. Defaults to `:`.
                  
           
      --in <R1_IN>
          [REQUIRED] Input file 1 with reads.
              
           
      --in2 <R2_IN>
          [REQUIRED] Input file 2 with reads.
              
           
  -u, --umi <RU_IN>
          [REQUIRED] Input file with UMI.
                  
          
      --out <R1_OUT>
          Path to FastQ output file for R1.
              
           
      --out2 <R2_OUT>
          Path to FastQ output file for R2.
              
           
  -h, --help
          Print help
  -V, --version
          Print version
```

