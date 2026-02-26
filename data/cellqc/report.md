# cellqc CWL Generation Report

## cellqc

### Tool Description
CellQC is a Snakemake pipeline for quality control of single-cell RNA sequencing data.

### Metadata
- **Docker Image**: quay.io/biocontainers/cellqc:0.1.0--pyh7e72e81_0
- **Homepage**: https://github.com/lijinbio/cellqc
- **Package**: https://anaconda.org/channels/bioconda/packages/cellqc/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cellqc/overview
- **Total Downloads**: 8.0K
- **Last updated**: 2025-05-09
- **GitHub**: https://github.com/lijinbio/cellqc
- **Stars**: N/A
### Original Help Text
```text
Start running: snakemake --snakefile /usr/local/lib/python3.10/site-packages/cellqc/Snakefile --directory / --cores 4 --jobs 4 --config samplefile='None' outdir='/' configfile='None' nowtimestr='260225_205103' --printshellcmds --debug-dag --skip-script-cleanup --verbose --use-conda
Full Traceback (most recent call last):
  File "/usr/local/lib/python3.10/site-packages/snakemake/__init__.py", line 671, in snakemake
    workflow.include(
  File "/usr/local/lib/python3.10/site-packages/snakemake/workflow.py", line 1389, in include
    exec(compile(code, snakefile.get_path_or_uri(), "exec"), self.globals)
  File "/usr/local/lib/python3.10/site-packages/cellqc/Snakefile", line 4, in <module>
    include: "rules/config.smk"
  File "/usr/local/lib/python3.10/site-packages/snakemake/workflow.py", line 1389, in include
    exec(compile(code, snakefile.get_path_or_uri(), "exec"), self.globals)
  File "/usr/local/lib/python3.10/site-packages/cellqc/rules/config.smk", line 65, in <module>
  File "/usr/local/lib/python3.10/site-packages/pandas/io/parsers/readers.py", line 1405, in read_table
    return _read(filepath_or_buffer, kwds)
  File "/usr/local/lib/python3.10/site-packages/pandas/io/parsers/readers.py", line 620, in _read
    parser = TextFileReader(filepath_or_buffer, **kwds)
  File "/usr/local/lib/python3.10/site-packages/pandas/io/parsers/readers.py", line 1620, in __init__
    self._engine = self._make_engine(f, self.engine)
  File "/usr/local/lib/python3.10/site-packages/pandas/io/parsers/readers.py", line 1880, in _make_engine
    self.handles = get_handle(
  File "/usr/local/lib/python3.10/site-packages/pandas/io/common.py", line 873, in get_handle
    handle = open(
FileNotFoundError: [Errno 2] No such file or directory: 'None'

FileNotFoundError in file /usr/local/lib/python3.10/site-packages/cellqc/rules/config.smk, line 63:
[Errno 2] No such file or directory: 'None'
  File "/usr/local/lib/python3.10/site-packages/cellqc/Snakefile", line 4, in <module>
  File "/usr/local/lib/python3.10/site-packages/cellqc/rules/config.smk", line 63, in <module>
  File "/usr/local/lib/python3.10/site-packages/pandas/io/parsers/readers.py", line 1405, in read_table
  File "/usr/local/lib/python3.10/site-packages/pandas/io/parsers/readers.py", line 620, in _read
  File "/usr/local/lib/python3.10/site-packages/pandas/io/parsers/readers.py", line 1620, in __init__
  File "/usr/local/lib/python3.10/site-packages/pandas/io/parsers/readers.py", line 1880, in _make_engine
  File "/usr/local/lib/python3.10/site-packages/pandas/io/common.py", line 873, in get_handle
Finish running: snakemake --snakefile /usr/local/lib/python3.10/site-packages/cellqc/Snakefile --directory / --cores 4 --jobs 4 --config samplefile='None' outdir='/' configfile='None' nowtimestr='260225_205103' --printshellcmds --debug-dag --skip-script-cleanup --verbose --use-conda
Error: snakemake --snakefile /usr/local/lib/python3.10/site-packages/cellqc/Snakefile --directory / --cores 4 --jobs 4 --config samplefile='None' outdir='/' configfile='None' nowtimestr='260225_205103' --printshellcmds --debug-dag --skip-script-cleanup --verbose --use-conda failed. Exit code: 1
```

