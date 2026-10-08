# esme_pnetcdf_mvapich_4_0_ofi CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| esme_pnetcdf_mvapich_4_0_ofi_cdfdiff | PASS | Fixed image (was another package's), flags from the help and exit code 1 for differences; finds the 360_day vs 365_day calendar difference in two netcdf-c test files. |

## Metadata
- **Skill**: generated

## esme_pnetcdf_mvapich_4_0_ofi_cdfdiff

### Tool Description
Compare the contents of two files in classic netCDF formats.

### Metadata
- **Docker Image**: quay.io/biocontainers/esme_pnetcdf_mvapich_4_0_ofi:1.14.1--hb2a3317_0
- **Homepage**: https://parallel-netcdf.github.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/esme_pnetcdf_mvapich_4_0_ofi/overview
- **Validation**: PASS
### Original Help Text
```text
cdfdiff [-b] [-q] [-h] [-v ...] [-t diff,ratio] file1 file2
  Compare the contents of two files in classic netCDF formats.
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

