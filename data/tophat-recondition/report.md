# tophat-recondition CWL Generation Report

## tophat-recondition

### Tool Description
Post-process TopHat unmapped reads. Corrects issues with TopHat unmapped read files.

### Metadata
- **Docker Image**: quay.io/biocontainers/tophat-recondition:1.4--py35_0
- **Homepage**: https://github.com/cbrueffer/tophat-recondition
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/tophat-recondition/overview
- **Total Downloads**: 48.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/cbrueffer/tophat-recondition
- **Stars**: N/A
### Original Help Text
```text
usage: tophat-recondition [-h] [-l LOGFILE] [-m MAPPED_FILE] [-q]
                          [-r RESULT_DIR] [-u UNMAPPED_FILE] [-v]
                          tophat_result_dir

Post-process TopHat unmapped reads. For detailed information on the issues
this software corrects, please consult the software homepage:
https://github.com/cbrueffer/tophat-recondition

positional arguments:
  tophat_result_dir     directory containing TopHat mapped and unmapped read
                        files.

optional arguments:
  -h, --help            show this help message and exit
  -l LOGFILE, --logfile LOGFILE
                        log file (optional, (default: result_dir/tophat-
                        recondition.log)
  -m MAPPED_FILE, --mapped-file MAPPED_FILE
                        Name of the file containing mapped reads (default:
                        accepted_hits.bam)
  -q, --quiet           quiet mode, no console output
  -r RESULT_DIR, --result_dir RESULT_DIR
                        directory to write unmapped_fixup.bam to (default:
                        tophat_output_dir)
  -u UNMAPPED_FILE, --unmapped-file UNMAPPED_FILE
                        Name of the file containing unmapped reads (default:
                        unmapped.bam)
  -v, --version         show program's version number and exit
```

