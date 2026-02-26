# bigsi CWL Generation Report

## bigsi_bloom

### Tool Description
Creates a bloom filter from a sequence file or cortex graph.

### Metadata
- **Docker Image**: quay.io/biocontainers/bigsi:0.3.1--py_0
- **Homepage**: https://github.com/Phelimb/BIGSI
- **Package**: https://anaconda.org/channels/bioconda/packages/bigsi/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bigsi/overview
- **Total Downloads**: 2.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/Phelimb/BIGSI
- **Stars**: N/A
### Original Help Text
```text
usage: bigsi-v0.3.1 bloom [-h] [-c CONFIG] ctx outfile

Creates a bloom filter from a sequence file or cortex graph.
(fastq,fasta,bam,ctx) e.g. index insert ERR1010211.ctx

positional arguments:
  ctx
  outfile

optional arguments:
  -h, --help            show this help message and exit
  -c CONFIG, --config CONFIG
```


## bigsi_build

### Tool Description
Build a BIGSI index.

### Metadata
- **Docker Image**: quay.io/biocontainers/bigsi:0.3.1--py_0
- **Homepage**: https://github.com/Phelimb/BIGSI
- **Package**: https://anaconda.org/channels/bioconda/packages/bigsi/overview
- **Validation**: PASS

### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/bigsi", line 6, in <module>
    exit(main())
  File "/usr/local/lib/python3.7/site-packages/bigsi/__main__.py", line 151, in main
    API.cli()
  File "/usr/local/lib/python3.7/site-packages/hug/api.py", line 390, in __call__
    result = self.commands.get(command)()
  File "/usr/local/lib/python3.7/site-packages/hug/interface.py", line 551, in __call__
    raise exception
  File "/usr/local/lib/python3.7/site-packages/hug/interface.py", line 547, in __call__
    result = self.output(self.interface(**pass_to_function), context)
  File "/usr/local/lib/python3.7/site-packages/hug/interface.py", line 100, in __call__
    return __hug_internal_self._function(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/bigsi/__main__.py", line 87, in build
    config = get_config_from_file(config)
  File "/usr/local/lib/python3.7/site-packages/bigsi/__main__.py", line 43, in get_config_from_file
    return DEFAULT_CONFIG
NameError: name 'DEFAULT_CONFIG' is not defined
```


## bigsi_delete

### Tool Description
Deletes a BigSI index.

### Metadata
- **Docker Image**: quay.io/biocontainers/bigsi:0.3.1--py_0
- **Homepage**: https://github.com/Phelimb/BIGSI
- **Package**: https://anaconda.org/channels/bioconda/packages/bigsi/overview
- **Validation**: PASS

### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/bigsi", line 6, in <module>
    exit(main())
  File "/usr/local/lib/python3.7/site-packages/bigsi/__main__.py", line 151, in main
    API.cli()
  File "/usr/local/lib/python3.7/site-packages/hug/api.py", line 390, in __call__
    result = self.commands.get(command)()
  File "/usr/local/lib/python3.7/site-packages/hug/interface.py", line 551, in __call__
    raise exception
  File "/usr/local/lib/python3.7/site-packages/hug/interface.py", line 547, in __call__
    result = self.output(self.interface(**pass_to_function), context)
  File "/usr/local/lib/python3.7/site-packages/hug/interface.py", line 100, in __call__
    return __hug_internal_self._function(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/bigsi/__main__.py", line 146, in delete
    config = get_config_from_file(config)
  File "/usr/local/lib/python3.7/site-packages/bigsi/__main__.py", line 43, in get_config_from_file
    return DEFAULT_CONFIG
NameError: name 'DEFAULT_CONFIG' is not defined
```


## bigsi_insert

### Tool Description
Inserts a bloom filter into the graph e.g. bigsi insert ERR1010211.bloom
ERR1010211

### Metadata
- **Docker Image**: quay.io/biocontainers/bigsi:0.3.1--py_0
- **Homepage**: https://github.com/Phelimb/BIGSI
- **Package**: https://anaconda.org/channels/bioconda/packages/bigsi/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bigsi-v0.3.1 insert [-h] config bloomfilter sample

Inserts a bloom filter into the graph e.g. bigsi insert ERR1010211.bloom
ERR1010211

positional arguments:
  config       Basic text / string value
  bloomfilter
  sample

optional arguments:
  -h, --help   show this help message and exit
```


## bigsi_merge

### Tool Description
N/A

### Metadata
- **Docker Image**: quay.io/biocontainers/bigsi:0.3.1--py_0
- **Homepage**: https://github.com/Phelimb/BIGSI
- **Package**: https://anaconda.org/channels/bioconda/packages/bigsi/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bigsi-v0.3.1 merge [-h] config merge_config

positional arguments:
  config        Basic text / string value
  merge_config  Basic text / string value

optional arguments:
  -h, --help    show this help message and exit
```


## bigsi_search

### Tool Description
Search for a sequence

### Metadata
- **Docker Image**: quay.io/biocontainers/bigsi:0.3.1--py_0
- **Homepage**: https://github.com/Phelimb/BIGSI
- **Package**: https://anaconda.org/channels/bioconda/packages/bigsi/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bigsi-v0.3.1 search [-h] [-t THRESHOLD] [-c CONFIG] seq

positional arguments:
  seq                   Basic text / string value

optional arguments:
  -h, --help            show this help message and exit
  -t THRESHOLD, --threshold THRESHOLD
                        A float number
  -c CONFIG, --config CONFIG
                        Basic text / string value
```

