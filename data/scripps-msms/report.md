# scripps-msms CWL Generation Report

## scripps-msms

### Tool Description
FAIL to generate CWL: scripps-msms not found in Singularity image. The image may not provide this executable.

### Metadata
- **Docker Image**: quay.io/biocontainers/scripps-msms:2.6.1--h9ee0642_0
- **Homepage**: https://ccsb.scripps.edu/msms/
- **Package**: https://anaconda.org/channels/bioconda/packages/scripps-msms/overview
- **Validation**: FAIL (generation failed)

- **Conda**: https://anaconda.org/channels/bioconda/packages/scripps-msms/overview
- **Total Downloads**: 241
- **Last updated**: 2025-05-27
- **GitHub**: N/A
- **Stars**: N/A
### Generation Failed

FAIL to generate CWL: scripps-msms not found in Singularity image. The image may not provide this executable.


### Validation Errors

- FAIL to generate CWL: scripps-msms not found in Singularity image. The image may not provide this executable.



### Original Help Text
```text

```


## Metadata
- **Skill**: generated

## scripps-msms_msms

### Tool Description
MSMS (Molecular Surface Masking System) computes the Solvent Excluded Surface (SES) of a set of spheres representing a molecule.

### Metadata
- **Docker Image**: quay.io/biocontainers/scripps-msms:2.6.1--h9ee0642_0
- **Homepage**: https://ccsb.scripps.edu/msms/
- **Package**: https://anaconda.org/channels/bioconda/packages/scripps-msms/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
Usage : msms parameters 
  -probe_radius float : probe sphere radius, [1.5]
  -density float      : surface points density, [1.0]
  -hdensity float     : surface points high density, [3.0]
  -surface <tses,ases>: triangulated or Analytical SES, [tses]
  -no_area            : turns off the analytical surface area computation
  -socketName servicename : socket connection from a client
  -socketPort portNumber : socket connection from a client
  -xdr                : use xdr encoding over socket
  -sinetd             : inetd server connection
  -noh                : ignore atoms with radius 1.2
  -no_rest_on_pbr     : no restart if pb. during triangulation
  -no_rest            : no restart if pb. are encountered
  -if filename        : sphere input file
  -of filename        : output for triangulated surface
  -af filename        : area file
  -no_header         : do not add comment line to the output
  -free_vertices      : turns on computation for isolated RS vertices
  -all_components     : compute all the surfaces components
  -one_cavity #atoms at1 [at2][at3] : Compute the surface for an internal                        cavity for which at least one atom is specified
```

