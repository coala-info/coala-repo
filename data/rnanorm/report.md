# rnanorm CWL Generation Report

## rnanorm_cpm

### Tool Description
Calculate counts per million (CPM) for RNA-Seq data.

### Metadata
- **Docker Image**: quay.io/biocontainers/rnanorm:2.2.0--pyhdfd78af_1
- **Homepage**: https://github.com/genialis/RNAnorm
- **Package**: https://anaconda.org/channels/bioconda/packages/rnanorm/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/rnanorm/overview
- **Total Downloads**: 24.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/genialis/RNAnorm
- **Stars**: N/A
### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/rnanorm", line 10, in <module>
    sys.exit(main())
  File "/usr/local/lib/python3.9/site-packages/click/core.py", line 1161, in __call__
    return self.main(*args, **kwargs)
  File "/usr/local/lib/python3.9/site-packages/click/core.py", line 1082, in main
    rv = self.invoke(ctx)
  File "/usr/local/lib/python3.9/site-packages/click/core.py", line 1697, in invoke
    return _process_result(sub_ctx.command.invoke(sub_ctx))
  File "/usr/local/lib/python3.9/site-packages/click/core.py", line 1443, in invoke
    return ctx.invoke(self.callback, **ctx.params)
  File "/usr/local/lib/python3.9/site-packages/click/core.py", line 788, in invoke
    return __callback(*args, **kwargs)
  File "/usr/local/lib/python3.9/site-packages/rnanorm/cli.py", line 85, in wrapper
    return func(*args, **kwargs)
  File "/usr/local/lib/python3.9/site-packages/rnanorm/cli.py", line 128, in cpm
    CLWrapper(CPM).handle(exp, out, force)
  File "/usr/local/lib/python3.9/site-packages/rnanorm/cli.py", line 28, in handle
    X = self.parse_exp(exp)
  File "/usr/local/lib/python3.9/site-packages/rnanorm/cli.py", line 47, in parse_exp
    return pd.read_csv(exp, index_col=0)
  File "/usr/local/lib/python3.9/site-packages/pandas/io/parsers/readers.py", line 1026, in read_csv
    return _read(filepath_or_buffer, kwds)
  File "/usr/local/lib/python3.9/site-packages/pandas/io/parsers/readers.py", line 620, in _read
    parser = TextFileReader(filepath_or_buffer, **kwds)
  File "/usr/local/lib/python3.9/site-packages/pandas/io/parsers/readers.py", line 1620, in __init__
    self._engine = self._make_engine(f, self.engine)
  File "/usr/local/lib/python3.9/site-packages/pandas/io/parsers/readers.py", line 1898, in _make_engine
    return mapping[engine](f, **self.options)
  File "/usr/local/lib/python3.9/site-packages/pandas/io/parsers/c_parser_wrapper.py", line 93, in __init__
    self._reader = parsers.TextReader(src, **kwds)
  File "parsers.pyx", line 581, in pandas._libs.parsers.TextReader.__cinit__
pandas.errors.EmptyDataError: No columns to parse from file
```


## rnanorm_ctf

### Tool Description
Convert count data to TPM format.

### Metadata
- **Docker Image**: quay.io/biocontainers/rnanorm:2.2.0--pyhdfd78af_1
- **Homepage**: https://github.com/genialis/RNAnorm
- **Package**: https://anaconda.org/channels/bioconda/packages/rnanorm/overview
- **Validation**: PASS

### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/rnanorm", line 10, in <module>
    sys.exit(main())
  File "/usr/local/lib/python3.9/site-packages/click/core.py", line 1161, in __call__
    return self.main(*args, **kwargs)
  File "/usr/local/lib/python3.9/site-packages/click/core.py", line 1082, in main
    rv = self.invoke(ctx)
  File "/usr/local/lib/python3.9/site-packages/click/core.py", line 1697, in invoke
    return _process_result(sub_ctx.command.invoke(sub_ctx))
  File "/usr/local/lib/python3.9/site-packages/click/core.py", line 1443, in invoke
    return ctx.invoke(self.callback, **ctx.params)
  File "/usr/local/lib/python3.9/site-packages/click/core.py", line 788, in invoke
    return __callback(*args, **kwargs)
  File "/usr/local/lib/python3.9/site-packages/rnanorm/cli.py", line 85, in wrapper
    return func(*args, **kwargs)
  File "/usr/local/lib/python3.9/site-packages/rnanorm/cli.py", line 119, in wrapper
    return func(*args, **kwargs)
  File "/usr/local/lib/python3.9/site-packages/rnanorm/cli.py", line 186, in ctf
    CLWrapper(CTF, m_trim=m_trim, a_trim=a_trim).handle(exp, out, force)
  File "/usr/local/lib/python3.9/site-packages/rnanorm/cli.py", line 28, in handle
    X = self.parse_exp(exp)
  File "/usr/local/lib/python3.9/site-packages/rnanorm/cli.py", line 47, in parse_exp
    return pd.read_csv(exp, index_col=0)
  File "/usr/local/lib/python3.9/site-packages/pandas/io/parsers/readers.py", line 1026, in read_csv
    return _read(filepath_or_buffer, kwds)
  File "/usr/local/lib/python3.9/site-packages/pandas/io/parsers/readers.py", line 620, in _read
    parser = TextFileReader(filepath_or_buffer, **kwds)
  File "/usr/local/lib/python3.9/site-packages/pandas/io/parsers/readers.py", line 1620, in __init__
    self._engine = self._make_engine(f, self.engine)
  File "/usr/local/lib/python3.9/site-packages/pandas/io/parsers/readers.py", line 1898, in _make_engine
    return mapping[engine](f, **self.options)
  File "/usr/local/lib/python3.9/site-packages/pandas/io/parsers/c_parser_wrapper.py", line 93, in __init__
    self._reader = parsers.TextReader(src, **kwds)
  File "parsers.pyx", line 581, in pandas._libs.parsers.TextReader.__cinit__
pandas.errors.EmptyDataError: No columns to parse from file
```


## rnanorm_cuf

### Tool Description
Normalize RNA-Seq count data using the CUF method.

### Metadata
- **Docker Image**: quay.io/biocontainers/rnanorm:2.2.0--pyhdfd78af_1
- **Homepage**: https://github.com/genialis/RNAnorm
- **Package**: https://anaconda.org/channels/bioconda/packages/rnanorm/overview
- **Validation**: PASS

### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/rnanorm", line 10, in <module>
    sys.exit(main())
  File "/usr/local/lib/python3.9/site-packages/click/core.py", line 1161, in __call__
    return self.main(*args, **kwargs)
  File "/usr/local/lib/python3.9/site-packages/click/core.py", line 1082, in main
    rv = self.invoke(ctx)
  File "/usr/local/lib/python3.9/site-packages/click/core.py", line 1697, in invoke
    return _process_result(sub_ctx.command.invoke(sub_ctx))
  File "/usr/local/lib/python3.9/site-packages/click/core.py", line 1443, in invoke
    return ctx.invoke(self.callback, **ctx.params)
  File "/usr/local/lib/python3.9/site-packages/click/core.py", line 788, in invoke
    return __callback(*args, **kwargs)
  File "/usr/local/lib/python3.9/site-packages/rnanorm/cli.py", line 85, in wrapper
    return func(*args, **kwargs)
  File "/usr/local/lib/python3.9/site-packages/rnanorm/cli.py", line 170, in cuf
    CLWrapper(CUF).handle(exp, out, force)
  File "/usr/local/lib/python3.9/site-packages/rnanorm/cli.py", line 28, in handle
    X = self.parse_exp(exp)
  File "/usr/local/lib/python3.9/site-packages/rnanorm/cli.py", line 47, in parse_exp
    return pd.read_csv(exp, index_col=0)
  File "/usr/local/lib/python3.9/site-packages/pandas/io/parsers/readers.py", line 1026, in read_csv
    return _read(filepath_or_buffer, kwds)
  File "/usr/local/lib/python3.9/site-packages/pandas/io/parsers/readers.py", line 620, in _read
    parser = TextFileReader(filepath_or_buffer, **kwds)
  File "/usr/local/lib/python3.9/site-packages/pandas/io/parsers/readers.py", line 1620, in __init__
    self._engine = self._make_engine(f, self.engine)
  File "/usr/local/lib/python3.9/site-packages/pandas/io/parsers/readers.py", line 1898, in _make_engine
    return mapping[engine](f, **self.options)
  File "/usr/local/lib/python3.9/site-packages/pandas/io/parsers/c_parser_wrapper.py", line 93, in __init__
    self._reader = parsers.TextReader(src, **kwds)
  File "parsers.pyx", line 581, in pandas._libs.parsers.TextReader.__cinit__
pandas.errors.EmptyDataError: No columns to parse from file
```


## rnanorm_fpkm

### Tool Description
Calculate FPKM values from gene expression data.

### Metadata
- **Docker Image**: quay.io/biocontainers/rnanorm:2.2.0--pyhdfd78af_1
- **Homepage**: https://github.com/genialis/RNAnorm
- **Package**: https://anaconda.org/channels/bioconda/packages/rnanorm/overview
- **Validation**: PASS

### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/rnanorm", line 10, in <module>
    sys.exit(main())
  File "/usr/local/lib/python3.9/site-packages/click/core.py", line 1161, in __call__
    return self.main(*args, **kwargs)
  File "/usr/local/lib/python3.9/site-packages/click/core.py", line 1082, in main
    rv = self.invoke(ctx)
  File "/usr/local/lib/python3.9/site-packages/click/core.py", line 1697, in invoke
    return _process_result(sub_ctx.command.invoke(sub_ctx))
  File "/usr/local/lib/python3.9/site-packages/click/core.py", line 1443, in invoke
    return ctx.invoke(self.callback, **ctx.params)
  File "/usr/local/lib/python3.9/site-packages/click/core.py", line 788, in invoke
    return __callback(*args, **kwargs)
  File "/usr/local/lib/python3.9/site-packages/rnanorm/cli.py", line 85, in wrapper
    return func(*args, **kwargs)
  File "/usr/local/lib/python3.9/site-packages/rnanorm/cli.py", line 107, in wrapper
    return func(*args, **kwargs)
  File "/usr/local/lib/python3.9/site-packages/rnanorm/cli.py", line 142, in fpkm
    CLWrapper(FPKM, gtf=gtf, gene_lengths=gene_lengths).handle(exp, out, force)
  File "/usr/local/lib/python3.9/site-packages/rnanorm/cli.py", line 28, in handle
    X = self.parse_exp(exp)
  File "/usr/local/lib/python3.9/site-packages/rnanorm/cli.py", line 47, in parse_exp
    return pd.read_csv(exp, index_col=0)
  File "/usr/local/lib/python3.9/site-packages/pandas/io/parsers/readers.py", line 1026, in read_csv
    return _read(filepath_or_buffer, kwds)
  File "/usr/local/lib/python3.9/site-packages/pandas/io/parsers/readers.py", line 620, in _read
    parser = TextFileReader(filepath_or_buffer, **kwds)
  File "/usr/local/lib/python3.9/site-packages/pandas/io/parsers/readers.py", line 1620, in __init__
    self._engine = self._make_engine(f, self.engine)
  File "/usr/local/lib/python3.9/site-packages/pandas/io/parsers/readers.py", line 1898, in _make_engine
    return mapping[engine](f, **self.options)
  File "/usr/local/lib/python3.9/site-packages/pandas/io/parsers/c_parser_wrapper.py", line 93, in __init__
    self._reader = parsers.TextReader(src, **kwds)
  File "parsers.pyx", line 581, in pandas._libs.parsers.TextReader.__cinit__
pandas.errors.EmptyDataError: No columns to parse from file
```


## rnanorm_tmm

### Tool Description
Apply TMM normalization to an expression matrix.

### Metadata
- **Docker Image**: quay.io/biocontainers/rnanorm:2.2.0--pyhdfd78af_1
- **Homepage**: https://github.com/genialis/RNAnorm
- **Package**: https://anaconda.org/channels/bioconda/packages/rnanorm/overview
- **Validation**: PASS

### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/rnanorm", line 10, in <module>
    sys.exit(main())
  File "/usr/local/lib/python3.9/site-packages/click/core.py", line 1161, in __call__
    return self.main(*args, **kwargs)
  File "/usr/local/lib/python3.9/site-packages/click/core.py", line 1082, in main
    rv = self.invoke(ctx)
  File "/usr/local/lib/python3.9/site-packages/click/core.py", line 1697, in invoke
    return _process_result(sub_ctx.command.invoke(sub_ctx))
  File "/usr/local/lib/python3.9/site-packages/click/core.py", line 1443, in invoke
    return ctx.invoke(self.callback, **ctx.params)
  File "/usr/local/lib/python3.9/site-packages/click/core.py", line 788, in invoke
    return __callback(*args, **kwargs)
  File "/usr/local/lib/python3.9/site-packages/rnanorm/cli.py", line 85, in wrapper
    return func(*args, **kwargs)
  File "/usr/local/lib/python3.9/site-packages/rnanorm/cli.py", line 119, in wrapper
    return func(*args, **kwargs)
  File "/usr/local/lib/python3.9/site-packages/rnanorm/cli.py", line 178, in tmm
    CLWrapper(TMM, m_trim=m_trim, a_trim=a_trim).handle(exp, out, force)
  File "/usr/local/lib/python3.9/site-packages/rnanorm/cli.py", line 28, in handle
    X = self.parse_exp(exp)
  File "/usr/local/lib/python3.9/site-packages/rnanorm/cli.py", line 47, in parse_exp
    return pd.read_csv(exp, index_col=0)
  File "/usr/local/lib/python3.9/site-packages/pandas/io/parsers/readers.py", line 1026, in read_csv
    return _read(filepath_or_buffer, kwds)
  File "/usr/local/lib/python3.9/site-packages/pandas/io/parsers/readers.py", line 620, in _read
    parser = TextFileReader(filepath_or_buffer, **kwds)
  File "/usr/local/lib/python3.9/site-packages/pandas/io/parsers/readers.py", line 1620, in __init__
    self._engine = self._make_engine(f, self.engine)
  File "/usr/local/lib/python3.9/site-packages/pandas/io/parsers/readers.py", line 1898, in _make_engine
    return mapping[engine](f, **self.options)
  File "/usr/local/lib/python3.9/site-packages/pandas/io/parsers/c_parser_wrapper.py", line 93, in __init__
    self._reader = parsers.TextReader(src, **kwds)
  File "parsers.pyx", line 581, in pandas._libs.parsers.TextReader.__cinit__
pandas.errors.EmptyDataError: No columns to parse from file
```


## rnanorm_tpm

### Tool Description
Compute TPM.

### Metadata
- **Docker Image**: quay.io/biocontainers/rnanorm:2.2.0--pyhdfd78af_1
- **Homepage**: https://github.com/genialis/RNAnorm
- **Package**: https://anaconda.org/channels/bioconda/packages/rnanorm/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: rnanorm tpm [OPTIONS] [EXP]

  Compute TPM.

Options:
  --out FILENAME           Output results in this file instead of stdout
  --force                  Overwrite already existing output file
  --gtf FILENAME           Compute gene lengths from this GTF file
  --gene-lengths FILENAME  File with gene lengths
  --help                   Show this message and exit.
```


## rnanorm_uq

### Tool Description
Performs Upper Quartile Normalization on expression data.

### Metadata
- **Docker Image**: quay.io/biocontainers/rnanorm:2.2.0--pyhdfd78af_1
- **Homepage**: https://github.com/genialis/RNAnorm
- **Package**: https://anaconda.org/channels/bioconda/packages/rnanorm/overview
- **Validation**: PASS

### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/rnanorm", line 10, in <module>
    sys.exit(main())
  File "/usr/local/lib/python3.9/site-packages/click/core.py", line 1161, in __call__
    return self.main(*args, **kwargs)
  File "/usr/local/lib/python3.9/site-packages/click/core.py", line 1082, in main
    rv = self.invoke(ctx)
  File "/usr/local/lib/python3.9/site-packages/click/core.py", line 1697, in invoke
    return _process_result(sub_ctx.command.invoke(sub_ctx))
  File "/usr/local/lib/python3.9/site-packages/click/core.py", line 1443, in invoke
    return ctx.invoke(self.callback, **ctx.params)
  File "/usr/local/lib/python3.9/site-packages/click/core.py", line 788, in invoke
    return __callback(*args, **kwargs)
  File "/usr/local/lib/python3.9/site-packages/rnanorm/cli.py", line 85, in wrapper
    return func(*args, **kwargs)
  File "/usr/local/lib/python3.9/site-packages/rnanorm/cli.py", line 163, in uq
    CLWrapper(UQ).handle(exp, out, force)
  File "/usr/local/lib/python3.9/site-packages/rnanorm/cli.py", line 28, in handle
    X = self.parse_exp(exp)
  File "/usr/local/lib/python3.9/site-packages/rnanorm/cli.py", line 47, in parse_exp
    return pd.read_csv(exp, index_col=0)
  File "/usr/local/lib/python3.9/site-packages/pandas/io/parsers/readers.py", line 1026, in read_csv
    return _read(filepath_or_buffer, kwds)
  File "/usr/local/lib/python3.9/site-packages/pandas/io/parsers/readers.py", line 620, in _read
    parser = TextFileReader(filepath_or_buffer, **kwds)
  File "/usr/local/lib/python3.9/site-packages/pandas/io/parsers/readers.py", line 1620, in __init__
    self._engine = self._make_engine(f, self.engine)
  File "/usr/local/lib/python3.9/site-packages/pandas/io/parsers/readers.py", line 1898, in _make_engine
    return mapping[engine](f, **self.options)
  File "/usr/local/lib/python3.9/site-packages/pandas/io/parsers/c_parser_wrapper.py", line 93, in __init__
    self._reader = parsers.TextReader(src, **kwds)
  File "parsers.pyx", line 581, in pandas._libs.parsers.TextReader.__cinit__
pandas.errors.EmptyDataError: No columns to parse from file
```


## Metadata
- **Skill**: generated
