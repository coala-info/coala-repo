# esme_pnetcdf_mvapich_4_0 CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| esme_pnetcdf_mvapich_4_0_ncmpidiff | PASS | Fixed image (was another package's), flags from the help (-b verbose, -h, -v comma list, -t) and exit code 1 for differences; finds the 360_day vs 365_day calendar difference in two netcdf-c test files. |

## Metadata
- **Skill**: generated

## esme_pnetcdf_mvapich_4_0_ncmpidiff

### Tool Description
Compare the contents of two netCDF files.

### Metadata
- **Docker Image**: quay.io/biocontainers/esme_pnetcdf_mvapich_4_0:1.14.1--hf580d27_0
- **Homepage**: https://parallel-netcdf.github.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/esme_pnetcdf_mvapich_4_0/overview
- **Validation**: PASS
### Original Help Text
```text
ncmpidiff [-b] [-q] [-h] [-v ...] [-t diff,ratio] file1 file2
  Compare the contents of two netCDF files.
  [-b]             Verbose output
  [-q]             quiet mode (no output if two files are the same)
  [-h]             Compare header information only, no variables
  [-v var1[,...]]  Compare variable(s) <var1>,... only
  [-t diff,ratio]  Tolerance: diff is absolute element-wise difference
                   and ratio is relative element-wise difference defined
                   as |x - y|/max(|x|, |y|)
  file1 file2      File names of two input netCDF files to be compared
*PnetCDF library version 1.14.1 of July 31, 2025
```

