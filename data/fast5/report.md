# fast5 CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| fast5_f5ls | Failed | image problem: f5ls crashes at start with ModuleNotFoundError: No module named 'dateutil' |
| fast5_f5pack | Failed | image problem: f5pack crashes at start with TypeError: expected bytes, str found (Python 3 and the fast5 extension do not match) |

## fast5_f5pack

### Tool Description
Pack and unpack ONT fast5 files.

### fast5_f5ls

### Tool Description
Summarize contents of ONT fast5 files.

### Metadata
- **Docker Image**: biocontainers/fast5:v0.6.5-2-deb_cv1
- **Homepage**: https://github.com/mateidavid/fast5
- **Package**: https://anaconda.org/channels/bioconda/packages/fast5/overview
- **Validation**: PASS

### Original Help Text
```text
usage: f5ls [-h] [--log-level LOG_LEVEL] [--delim DELIM] [-R] [inputs [inputs ...]]

Summarize contents of ONT fast5 files.

positional arguments:
  inputs                Input directories, fast5 files, or files of fast5 file names.

optional arguments:
  -h, --help            show this help message and exit
  --log-level LOG_LEVEL
                        log level
  --delim DELIM         Delimiters list; first char used between path and value, second char used between path elements.
  -R, --recurse         Recurse in input directories.

(Help text rebuilt from the argparse definition in /usr/bin/f5ls, because the program crashes in the image with: ModuleNotFoundError: No module named 'dateutil'.)
```

## Metadata
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

