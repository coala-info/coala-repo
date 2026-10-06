# barseqcount CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| barseqcount_analyze | Not completed | needs the count report and CSV from barseqcount count, which cannot be produced because count crashes in this image; no public test data exists. |
| barseqcount_count | Failed | image problem: barseqcount count crashes when creating its configuration file because the bundled dmbiolib 0.3.10 changed conf_start(), and a hand-written configuration on synthetic data crashes with KeyError in barcode assignment. |

## barseqcount_count

### Tool Description
Counts barcodes in sequencing data.

### Metadata
- **Docker Image**: quay.io/biocontainers/barseqcount:0.1.5--pyhdfd78af_0
- **Homepage**: https://github.com/damienmarsic/barseqcount
- **Package**: https://anaconda.org/channels/bioconda/packages/barseqcount/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/barseqcount/overview
- **Total Downloads**: 5.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/damienmarsic/barseqcount
- **Stars**: N/A
### Original Help Text
```text
Traceback (most recent call last):
  File "<frozen runpy>", line 198, in _run_module_as_main
  File "<frozen runpy>", line 88, in _run_code
  File "/usr/local/lib/python3.11/site-packages/barseqcount.py", line 1086, in <module>
    main()
  File "/usr/local/lib/python3.11/site-packages/barseqcount.py", line 30, in main
    count(args)
  File "/usr/local/lib/python3.11/site-packages/barseqcount.py", line 40, in count
    countconf(fname,args)
  File "/usr/local/lib/python3.11/site-packages/barseqcount.py", line 978, in countconf
    content,dirname,rfiles=dbl.conf_start(z)
                           ^^^^^^^^^^^^^^^^^
TypeError: conf_start() missing 1 required positional argument: 'title'
```


## barseqcount_analyze

### Tool Description
Analyze barseqcount results

### Metadata
- **Docker Image**: quay.io/biocontainers/barseqcount:0.1.5--pyhdfd78af_0
- **Homepage**: https://github.com/damienmarsic/barseqcount
- **Package**: https://anaconda.org/channels/bioconda/packages/barseqcount/overview
- **Validation**: PASS

### Original Help Text
```text
usage: barseqcount.py analyze [-h] [-c CONFIGURATION_FILE] [-n]
                              [-f FILE_FORMAT]

options:
  -h, --help            show this help message and exit
  -c CONFIGURATION_FILE, --configuration_file CONFIGURATION_FILE
                        Configuration file for the barseqcount analyze program
                        (default: barseqcount_analyze.conf), will be created
                        if absent
  -n, --new             Create new configuration file and rename existing one
  -f FILE_FORMAT, --file_format FILE_FORMAT
                        Save each figure in separate file with choice of
                        format instead of the default single multipage pdf
                        file. Choices: svg, png, jpg, pdf, ps, eps, pgf, raw,
                        rgba, tif
```


## Metadata
- **Skill**: not generated

