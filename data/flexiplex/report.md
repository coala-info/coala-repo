# flexiplex CWL Generation Report

## flexiplex

### Tool Description
A versatile demultiplexer and search tool for omics data, used for searching and reporting barcodes, UMIs, and flanking sequences in sequencing reads.

### Metadata
- **Docker Image**: quay.io/biocontainers/flexiplex:1.02.5--py313h9948957_1
- **Homepage**: https://github.com/DavidsonGroup/flexiplex/
- **Package**: https://anaconda.org/channels/bioconda/packages/flexiplex/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/flexiplex/overview
- **Total Downloads**: 10.5K
- **Last updated**: 2025-09-09
- **GitHub**: https://github.com/DavidsonGroup/flexiplex
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
INFO:    Inserting Apptainer configuration...
INFO:    Creating SIF file...
FLEXIPLEX 1.02.5
usage: flexiplex [options] [reads_input]

  reads_input: a .fastq or .fasta file. Will read from stdin if empty.

  options: 
     -k known_list   Either 1) a text file of expected barcodes in the first column,
                     one row per barcode, or 2) a comma separate string of barcodes.
                     Without this option, flexiplex will search and report possible barcodes.
                     The generated list can be used for known_list in subsequent runs.
     -i true/false   Replace read ID with barcodes+UMI, remove search strings
                     including flanking sequenence and split read if multiple
                     barcodes found (default: true).
     -s true/false   Sort reads into separate files by barcode (default: false)
     -c true/false   Add a _C suffix to the read identifier of any chimeric reads
                     (default: false). For instance if,
                       @BC_UMI#READID_+1of2
                     is chimeric, it will become:
                       @BC_UMI#READID_+1of2_C
     -n prefix       Prefix for output filenames.
     -e N            Maximum edit distance to barcode (default 2).
     -f N            Maximum edit distance to primer+polyT (default 8).
     -p N            Number of threads (default: 1).

  Specifying adaptor / barcode structure : 
     -x sequence Append flanking sequence to search for
     -b sequence Append the barcode pattern to search for
     -u sequence Append the UMI pattern to search for
     Notes:
          The order of these options matters
          ? - can be used as a wildcard
     When no search pattern x,b,u option is provided, the following default pattern is used: 
          primer: CTACACGACGCTCTTCCGATCT
          barcode: ????????????????
          UMI: ????????????
          polyT: TTTTTTTTT
     which is the same as providing: 
         -x CTACACGACGCTCTTCCGATCT -b ???????????????? -u ???????????? -x TTTTTTTTT

  Predefined search schemes:
    -d 10x3v2		10x version 2 chemistry 3', equivalent to:
				-x CTACACGACGCTCTTCCGATCT -b ???????????????? -u ?????????? -x TTTTTTTTT -f 8 -e 2
    -d 10x3v3		10x version 3 chemistry 3', equivalent to:
				-x CTACACGACGCTCTTCCGATCT -b ???????????????? -u ???????????? -x TTTTTTTTT -f 8 -e 2
    -d 10x5v2		10x version 2 chemistry 5', equivalent to:
				-x CTACACGACGCTCTTCCGATCT -b ???????????????? -u ?????????? -x TTTCTTATATGGG -f 8 -e 2
    -d grep		Simple grep-like search (edit distance up to 2), equivalent to:
				-f 2 -k ? -b '' -u '' -i false

     -h     Print this usage information.

Have a different barcode scheme you would like Flexiplex to work with? Post a request at:
https://github.com/DavidsonGroup/flexiplex/issues

If you use Flexiplex in your research, please cite our paper:
O. Cheng et al., Flexiplex: a versatile demultiplexer and search tool for omics data, Bioinformatics, Volume 40, Issue 3, 2024
```


## Metadata
- **Skill**: generated

## flexiplex_flexiplex-filter

### Tool Description
A tool to filter flexiplex results, typically processing count data from a file or stdin.

### Metadata
- **Docker Image**: quay.io/biocontainers/flexiplex:1.02.5--py313h9948957_1
- **Homepage**: https://github.com/DavidsonGroup/flexiplex/
- **Package**: https://anaconda.org/channels/bioconda/packages/flexiplex/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
FLEXIPLEX-FILTER 1.02
No filename given... getting reads from stdin...
Traceback (most recent call last):
  File "/usr/local/bin/flexiplex-filter", line 11, in <module>
    sys.exit(cli())
             ~~~^^
  File "/usr/local/lib/python3.13/site-packages/flexiplex_filter/main.py", line 481, in cli
    df = read_counts(args.filename)
  File "/usr/local/lib/python3.13/site-packages/flexiplex_filter/main.py", line 192, in read_counts
    df["count"] = df["count"].astype(int)
                  ~~~~~~~~~~~~~~~~~~^^^^^
  File "/usr/local/lib/python3.13/site-packages/pandas/core/generic.py", line 6662, in astype
    new_data = self._mgr.astype(dtype=dtype, copy=copy, errors=errors)
  File "/usr/local/lib/python3.13/site-packages/pandas/core/internals/managers.py", line 430, in astype
    return self.apply(
           ~~~~~~~~~~^
        "astype",
        ^^^^^^^^^
    ...<3 lines>...
        using_cow=using_copy_on_write(),
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    )
    ^
  File "/usr/local/lib/python3.13/site-packages/pandas/core/internals/managers.py", line 363, in apply
    applied = getattr(b, f)(**kwargs)
  File "/usr/local/lib/python3.13/site-packages/pandas/core/internals/blocks.py", line 784, in astype
    new_values = astype_array_safe(values, dtype, copy=copy, errors=errors)
  File "/usr/local/lib/python3.13/site-packages/pandas/core/dtypes/astype.py", line 237, in astype_array_safe
    new_values = astype_array(values, dtype, copy=copy)
  File "/usr/local/lib/python3.13/site-packages/pandas/core/dtypes/astype.py", line 182, in astype_array
    values = _astype_nansafe(values, dtype, copy=copy)
  File "/usr/local/lib/python3.13/site-packages/pandas/core/dtypes/astype.py", line 101, in _astype_nansafe
    return _astype_float_to_int_nansafe(arr, dtype, copy)
  File "/usr/local/lib/python3.13/site-packages/pandas/core/dtypes/astype.py", line 145, in _astype_float_to_int_nansafe
    raise IntCastingNaNError(
        "Cannot convert non-finite values (NA or inf) to integer"
    )
pandas.errors.IntCastingNaNError: Cannot convert non-finite values (NA or inf) to integer
```

