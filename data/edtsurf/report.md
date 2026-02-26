# edtsurf CWL Generation Report

## edtsurf_EDTSurf

### Tool Description
EDTSurf calculates the solvent accessible surface area (SASA) and the volume of the cavities of a protein.

### Metadata
- **Docker Image**: biocontainers/edtsurf:v0.2009-6-deb_cv1
- **Homepage**: https://github.com/UnixJunkie/EDTSurf
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/edtsurf/overview
- **Total Downloads**: N/A
- **Last updated**: N/A
- **GitHub**: https://github.com/UnixJunkie/EDTSurf
- **Stars**: N/A
### Original Help Text
```text
usage: EDTSurf -i pdbname ...
-o outname
-t 1-MC 2-VCMC
-s 1-VWS 2-SAS 3-MS 4-SES
-c 1-pure 2-atom 3-chain
-p probe radius [0,2.0]
-f scale factor (0,20.0]
-h 1-in and out 2-out 3-in
output1: outname.ply
output2: outname.asa
output3: outname-cav.pdb
```

