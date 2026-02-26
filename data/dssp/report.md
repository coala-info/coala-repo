# dssp CWL Generation Report

## dssp

### Tool Description
Calculate secondary structure for PDB or mmCIF files.

### Metadata
- **Docker Image**: biocontainers/dssp:v3.0.0-3b1-deb_cv1
- **Homepage**: https://github.com/PDB-REDO/dssp
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/conda-forge/packages/dssp/overview
- **Total Downloads**: 86.7K
- **Last updated**: 2026-02-18
- **GitHub**: https://github.com/PDB-REDO/dssp
- **Stars**: N/A
### Original Help Text
```text
mkdssp 3.0.0 options:
  -h [ --help ]         Display help message
  -i [ --input ] arg    Input PDB file (.pdb) or mmCIF file (.cif/.mcif), 
                        optionally compressed by gzip (.gz) or bzip2 (.bz2)
  -o [ --output ] arg   Output file, optionally compressed by gzip (.gz) or 
                        bzip2 (.bz2). Use 'stdout' to output to screen
  -v [ --verbose ]      Verbose output
  --version             Print version and citation info
  -d [ --debug ] arg    Debug level (for even more verbose output)


Examples: 

To calculate the secondary structure for the file 1crn.pdb and
write the result to a file called 1crn.dssp, you type:

  dssp -i 1crn.pdb -o 1crn.dssp
```

