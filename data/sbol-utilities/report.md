# sbol-utilities CWL Generation Report

## sbol-utilities_sbol-converter

### Tool Description
Converts genetic design files between various formats.

### Metadata
- **Docker Image**: quay.io/biocontainers/sbol-utilities:1.0a16--pyhdfd78af_0
- **Homepage**: https://github.com/SynBioDex/SBOL-utilities
- **Package**: https://anaconda.org/channels/bioconda/packages/sbol-utilities/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/sbol-utilities/overview
- **Total Downloads**: 3.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/SynBioDex/SBOL-utilities
- **Stars**: N/A
### Original Help Text
```text
usage: sbol-converter [-h] [-n NAMESPACE] [-o OUTPUT_FILE] [--verbose]
                      [--allow-genbank-online]
                      input_file_type output_file_type input_file

positional arguments:
  input_file_type       Input file type, options: FASTA, GenBank, SBOL2, SBOL3
                        (default)
  output_file_type      Output file type, options: FASTA, GenBank, SBOL2,
                        SBOL3 (default)
  input_file            Genetic design file used as input

optional arguments:
  -h, --help            show this help message and exit
  -n NAMESPACE, --namespace NAMESPACE
                        Namespace URL, required for conversions from FASTA and
                        GenBank
  -o OUTPUT_FILE, --output OUTPUT_FILE
                        Name of output file to be written
  --verbose, -v         Print running explanation of conversion process
  --allow-genbank-online
                        Perform GenBank conversion using online converter
```


## sbol-utilities_graph-sbol

### Tool Description
Reads an SBOL file and outputs a graph representation.

### Metadata
- **Docker Image**: quay.io/biocontainers/sbol-utilities:1.0a16--pyhdfd78af_0
- **Homepage**: https://github.com/SynBioDex/SBOL-utilities
- **Package**: https://anaconda.org/channels/bioconda/packages/sbol-utilities/overview
- **Validation**: PASS

### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/graph-sbol", line 10, in <module>
    sys.exit(main())
  File "/usr/local/lib/python3.9/site-packages/sbol_utilities/graph_sbol.py", line 155, in main
    doc.read(args_dict['in_file'])
  File "/usr/local/lib/python3.9/site-packages/sbol3/document.py", line 318, in read
    file_format = self._guess_format(location)
  File "/usr/local/lib/python3.9/site-packages/sbol3/document.py", line 286, in _guess_format
    rdf_format = rdflib.util.guess_format(fpath)
  File "/usr/local/lib/python3.9/site-packages/rdflib/util.py", line 404, in guess_format
    return fmap.get(_get_ext(fpath)) or fmap.get(fpath.lower())
  File "/usr/local/lib/python3.9/site-packages/rdflib/util.py", line 421, in _get_ext
    ext = splitext(fpath)[-1]
  File "/usr/local/lib/python3.9/posixpath.py", line 118, in splitext
    p = os.fspath(p)
TypeError: expected str, bytes or os.PathLike object, not NoneType
```


## sbol-utilities_sbol-diff

### Tool Description
Compares two SBOL files and reports differences.

### Metadata
- **Docker Image**: quay.io/biocontainers/sbol-utilities:1.0a16--pyhdfd78af_0
- **Homepage**: https://github.com/SynBioDex/SBOL-utilities
- **Package**: https://anaconda.org/channels/bioconda/packages/sbol-utilities/overview
- **Validation**: PASS

### Original Help Text
```text
usage: sbol-diff [-h] [-s] [--debug] FILE1 FILE2

positional arguments:
  FILE1         First Input File
  FILE2         Second Input File

optional arguments:
  -h, --help    show this help message and exit
  -s, --silent  Generate no output, only status
  --debug       Enable debug logging (default: disabled)
```


## sbol-utilities_sbol-expand-derivations

### Tool Description
Expand derivations in an SBOL file.

### Metadata
- **Docker Image**: quay.io/biocontainers/sbol-utilities:1.0a16--pyhdfd78af_0
- **Homepage**: https://github.com/SynBioDex/SBOL-utilities
- **Package**: https://anaconda.org/channels/bioconda/packages/sbol-utilities/overview
- **Validation**: PASS

### Original Help Text
```text
usage: sbol-expand-derivations [-h] [-x TARGETS] [-o OUTPUT_FILE]
                               [-t FILE_TYPE] [--verbose]
                               input_file

positional arguments:
  input_file            SBOL file used as input

optional arguments:
  -h, --help            show this help message and exit
  -x TARGETS, --expansion-target TARGETS
                        Name of object to be expanded; can be used multiple
                        times. If not listed, will attempt to expand all root
                        derivations
  -o OUTPUT_FILE, --output OUTPUT_FILE
                        Name of SBOL file to be written
  -t FILE_TYPE, --file-type FILE_TYPE
                        Name of SBOL file to output to (excluding type)
  --verbose, -v         Print running explanation of conversion process
```


## sbol-utilities_sbol-calculate-sequences

### Tool Description
Calculates sequences for components in an SBOL file.

### Metadata
- **Docker Image**: quay.io/biocontainers/sbol-utilities:1.0a16--pyhdfd78af_0
- **Homepage**: https://github.com/SynBioDex/SBOL-utilities
- **Package**: https://anaconda.org/channels/bioconda/packages/sbol-utilities/overview
- **Validation**: PASS

### Original Help Text
```text
usage: sbol-calculate-sequences [-h] [-o OUTPUT_FILE] [-t FILE_TYPE]
                                [--verbose]
                                sbol_file

positional arguments:
  sbol_file             SBOL file used as input

optional arguments:
  -h, --help            show this help message and exit
  -o OUTPUT_FILE, --output OUTPUT_FILE
                        Name of SBOL file to be written
  -t FILE_TYPE, --file-type FILE_TYPE
                        Name of SBOL file to output to (excluding type)
  --verbose, -v         Print running explanation of expansion process
```


## sbol-utilities_excel-to-sbol

### Tool Description
Converts an Excel file to SBOL format.

### Metadata
- **Docker Image**: quay.io/biocontainers/sbol-utilities:1.0a16--pyhdfd78af_0
- **Homepage**: https://github.com/SynBioDex/SBOL-utilities
- **Package**: https://anaconda.org/channels/bioconda/packages/sbol-utilities/overview
- **Validation**: PASS

### Original Help Text
```text
usage: excel-to-sbol [-h] [-n NAMESPACE] [-l LOCAL] [-o OUTPUT_FILE]
                     [-t FILE_TYPE] [--verbose]
                     excel_file

positional arguments:
  excel_file            Excel file used as input

optional arguments:
  -h, --help            show this help message and exit
  -n NAMESPACE, --namespace NAMESPACE
                        Namespace for Components in output file
  -l LOCAL, --local LOCAL
                        Local path for Components in output file
  -o OUTPUT_FILE, --output OUTPUT_FILE
                        Name of SBOL file to be written
  -t FILE_TYPE, --file-type FILE_TYPE
                        Name of SBOL file to output to (excluding type)
  --verbose, -v         Print running explanation of conversion process
```


## Metadata
- **Skill**: generated
