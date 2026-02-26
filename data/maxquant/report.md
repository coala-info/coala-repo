# maxquant CWL Generation Report

## maxquant

### Tool Description
Complete run of an existing mqpar.xml file

### Metadata
- **Docker Image**: quay.io/biocontainers/maxquant:2.0.3.0--py310hdfd78af_1
- **Homepage**: http://www.coxdocs.org/doku.php?id=maxquant:start
- **Package**: https://anaconda.org/channels/bioconda/packages/maxquant/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/maxquant/overview
- **Total Downloads**: 141.9K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
MaxQuantCmd 2.0.3.0
Copyright © Max-Planck-Institute of Biochemistry 2021

ERROR(S):
  Option 'h' is unknown.
  Option 'e, partial-processing-end' is defined with a bad format.
  A required value not bound to option name is missing.
USAGE:
Complete run of an existing mqpar.xml file:
  MaxQuantCmd.exe mqpar.xml
Print job ids/names table:
  MaxQuantCmd.exe --dryrun mqpar.xml
Rerunning second and third parts of the analysis:
  MaxQuantCmd.exe --partial-processing-end=3 --partial-processing=1 mqpar.xml
Changing folder location for fasta files and raw files for a given mqpar file:
  MaxQuantCmd.exe --changeFolder="<new mqpar.xml>" "<new folder with fasta
  files>" "<new folder with raw files>" mqpar.xml

  -p, --partial-processing        (Default: 1) Start processing from the
                                  specified job id. Can be used to continue/redo
                                  parts of the processing. Job id's can be
                                  obtained in the MaxQuant GUI partial
                                  processing view or from --dryrun option. The
                                  first job id is 1.

  -e, --partial-processing-end    (Default: 2147483647) Finish processing at the
                                  specified job id. 1-based indexing is used.

  -n, --dryrun                    Print job ids and job names table.

  -c, --create                    Create a template of MaxQuant parameter file.

  -f, --changeFolder              Change folder location for fasta and raw files
                                  (presuming all raw files are in the same
                                  folder). Expecting three locations separated
                                  by space. 1) path to the mqpar file 2) path to
                                  the fasta file(s) 3) path to the raw files.

  --help                          Display this help screen.

  --version                       Display version information.

  mqpar (pos. 0)                  Required. Path to the mqpar.xml file. If you
                                  do not have an mqpar.xml, you can generate one
                                  using the MaxQuant GUI or use --create option.
```

