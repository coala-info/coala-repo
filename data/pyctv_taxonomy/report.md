# pyctv_taxonomy CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| pyctv_taxonomy_download | Failed | tool bug: the ICTV site now answers its HEAD request with a redirect that has no Content-Disposition header, so pyctv stops with FATAL; it also saves the workbook inside its read-only install folder |
| pyctv_taxonomy_list | Failed | tool bug: list first checks the ICTV site for the workbook and stops with the same missing Content-Disposition FATAL error; no workbook is shipped in the image |

## pyctv_taxonomy_download

### Tool Description
Download the current ICTV Virus Metadata Resource (VMR) workbook.

### Metadata
- **Docker Image**: quay.io/biocontainers/pyctv_taxonomy:0.25--pyhdfd78af_0
- **Homepage**: https://github.com/linsalrob/pyctv
- **Package**: https://anaconda.org/channels/bioconda/packages/pyctv_taxonomy/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pyctv.py [-h] [-s] [-g] [-r] [-f] [-v] {download,list,version}

Parse the current workbook and get a list

positional arguments:
  {download,list,version}
                        Command to run

options:
  -h, --help            show this help message and exit
  -v, --verbose         verbose output

  -s, --semi            Print semi-colon separated taxonomy
  -g, --genbank         Print GenBank IDs and taxonomy
  -r, --refseq          Print RefSeq IDs and taxonomy

  -f, --force           Force an update, even if you have the newest file
```

## pyctv_taxonomy_list

### Tool Description
Parse the current ICTV Virus Metadata Resource (VMR) workbook and print a list of virus taxonomy.

### Metadata
- **Docker Image**: quay.io/biocontainers/pyctv_taxonomy:0.25--pyhdfd78af_0
- **Homepage**: https://github.com/linsalrob/pyctv
- **Package**: https://anaconda.org/channels/bioconda/packages/pyctv_taxonomy/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pyctv.py [-h] [-s] [-g] [-r] [-f] [-v] {download,list,version}

Parse the current workbook and get a list

positional arguments:
  {download,list,version}
                        Command to run

options:
  -h, --help            show this help message and exit
  -v, --verbose         verbose output

  -s, --semi            Print semi-colon separated taxonomy
  -g, --genbank         Print GenBank IDs and taxonomy
  -r, --refseq          Print RefSeq IDs and taxonomy

  -f, --force           Force an update, even if you have the newest file
```

