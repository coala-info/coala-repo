# density-fitness CWL Generation Report

## density-fitness

### Tool Description
Calculates the density fitness score for a given mtz file and coordinates file.

### Metadata
- **Docker Image**: quay.io/biocontainers/density-fitness:1.2.0--h077b44d_0
- **Homepage**: https://github.com/PDB-REDO/density-fitness
- **Package**: https://anaconda.org/channels/bioconda/packages/density-fitness/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/density-fitness/overview
- **Total Downloads**: 545
- **Last updated**: 2025-12-21
- **GitHub**: https://github.com/PDB-REDO/density-fitness
- **Stars**: N/A
### Original Help Text
```text
LIBCIFPP_DATA_DIR has been set to: `/usr/local/share/libcifpp`
density-fitness [options] <mtzfile> <coordinatesfile> [<output>]
  -h [ --help ]                Display help message
  --version                    Print version
  -v [ --verbose ]             Verbose output
  --quiet                      Do not print verbose output at all
  --hklin arg                  mtz file
  --xyzin arg                  coordinates file
  -o [ --output ] arg          Write output to this file instead of stdout
  --output-format arg (=json)  Output format, can be either 'edstats' or 'json'
  --recalc                     Recalculate Fc from FP/SIGFP in mtz file
  --aniso-scaling arg          Anisotropic scaling (none/observed/calculated)
  --no-bulk                    No bulk correction
  --fomap arg                  Fo map file -- 2mFo - DFc
  --dfmap arg                  difference map file -- 2(mFo - DFc)
  --reshi arg                  High resolution
  --reslo arg                  Low resolution
  --sampling-rate arg (=1.5)   Sampling rate
  --electron-scattering        Use electron scattering factors
  --no-edia                    Skip EDIA score calculation
  --use-auth-ids               Write auth_ identities instead of label_
  --mmcif-dictionary arg       Path to the mmcif_pdbx.dic file to use instead 
                               of default
  --compounds arg              Location of the components.cif file from CCD
  --restraint-dict arg         File containing restraints for residues in this 
                               specific target, can be specified multiple times.
  --ccd-dict arg               Dictionary file containing information in CCD 
                               format for residues in this specific target, can 
                               be specified multiple times.
```

