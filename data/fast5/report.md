# fast5 CWL Generation Report

## fast5_f5ls

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: biocontainers/fast5:v0.6.5-2-deb_cv1
- **Homepage**: https://github.com/mateidavid/fast5
- **Package**: https://anaconda.org/channels/bioconda/packages/fast5/overview
- **Validation**: FAIL (generation failed)

- **Conda**: https://anaconda.org/channels/bioconda/packages/fast5/overview
- **Total Downloads**: 246.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/mateidavid/fast5
- **Stars**: N/A
### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/bin/f5ls", line 12, in <module>
    import dateutil.parser
ModuleNotFoundError: No module named 'dateutil'
```


## fast5_f5pack

### Tool Description
Pack and unpack ONT fast5 files.

### Metadata
- **Docker Image**: biocontainers/fast5:v0.6.5-2-deb_cv1
- **Homepage**: https://github.com/mateidavid/fast5
- **Package**: https://anaconda.org/channels/bioconda/packages/fast5/overview
- **Validation**: PASS

### Original Help Text
```text
usage: f5pack [-h] [--log LOG] [--pack] [--unpack] [--archive] [--fastq]
              [--rs {drop,pack,unpack,copy}] [--ed {drop,pack,unpack,copy}]
              [--fq {drop,pack,unpack,copy}] [--ev {drop,pack,unpack,copy}]
              [--al {drop,pack,unpack,copy}] [--force] [--qv-bits QV_BITS]
              [--p-model-state-bits P_MODEL_STATE_BITS] [-R] -o OUTPUT
              [inputs [inputs ...]]

Pack and unpack ONT fast5 files.

positional arguments:
  inputs                Input directories, fast5 files, or files of fast5 file
                        names. For input directories, the subdirectory
                        hierarchy (if traversed with --recurse) is recreated
                        in the output directory.

optional arguments:
  -h, --help            show this help message and exit
  --log LOG             log level
  --pack                Pack data (default).
  --unpack              Unpack data.
  --archive             Pack raw samples data, drop rest.
  --fastq               Pack fastq data, drop rest.
  --rs {drop,pack,unpack,copy}
                        Policy for raw samples.
  --ed {drop,pack,unpack,copy}
                        Policy for eventdetection events.
  --fq {drop,pack,unpack,copy}
                        Policy for fastq.
  --ev {drop,pack,unpack,copy}
                        Policy for basecall events.
  --al {drop,pack,unpack,copy}
                        Policy for basecall alignment.
  --force               Overwrite existing destination files.
  --qv-bits QV_BITS     QV bits to keep.
  --p-model-state-bits P_MODEL_STATE_BITS
                        p_model_state bits to keep.
  -R, --recurse         Recurse in input directories.
  -o OUTPUT, --output OUTPUT
                        Output directory.
```

