# fastpca CWL Generation Report

## fastpca

### Tool Description
Calculate principle components from large data files.
Input data should be given as textfiles
with whitespace separated columns or, alternatively as GROMACS .xtc-files.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastpca:0.9.1
- **Homepage**: https://github.com/lettis/FastPCA
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/conda-forge/packages/fastpca/overview
- **Total Downloads**: 17.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/lettis/FastPCA
- **Stars**: N/A
### Original Help Text
```text
unrecognised option '%canonical_option%'
fastpca

Calculate principle components from large data files.
Input data should be given as textfiles
with whitespace separated columns or, alternatively as GROMACS .xtc-files.

options:
  -h [ --help ]              show this help
  -f [ --file ] arg          input (required): either whitespace-separated 
                             ASCII or GROMACS xtc-file.
  -C [ --cov-in ] arg        input (optional): file with already calculated 
                             covariance matrix
  -V [ --vec-in ] arg        input (optional): file with already computed 
                             eigenvectors
  -S [ --stats-in ] arg      input (optional): mean values, sigmas and boundary
                             shifts (shifts only for periodic). Provide this, 
                             if you want to project new data onto a previously 
                             computed principal space. If you do not define the
                             stats of the previous run, means, sigmas and 
                             shifts will be re-computed and the resulting 
                             projections will not be comparable to the previous
                             ones.
  -p [ --proj ] arg          output (optional): file for projected data
  -c [ --cov ] arg           output (optional): file for covariance matrix
  -v [ --vec ] arg           output (optional): file for eigenvectors
  -s [ --stats ] arg         output (optional): mean values, sigmas and 
                             boundary shifts (shifts only for periodic)
  -l [ --val ] arg           output (optional): file for eigenvalues
  -N [ --norm ]              if set, use correlation instead of covariance by 
                             normalizing input (default: false)
  -b [ --buf ] arg (=2)      max. allocatable RAM [Gb] (default: 2)
  -P [ --periodic ]          compute covariance and PCA on a torus (i.e. for 
                             periodic data like dihedral angles)
  -D [ --dynamic-shift ]     use dynamic shifting for periodic projection 
                             correction. (default: fale, i.e. simply shift to 
                             region of lowest density)
  --verbose                  verbose mode (default: not set)
  -n [ --nthreads ] arg (=0) number of OpenMP threads to use. if set to zero, 
                             will use value of OMP_NUM_THREADS (default: 0)
```


## Metadata
- **Skill**: generated
