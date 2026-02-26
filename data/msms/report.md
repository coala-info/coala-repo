# msms CWL Generation Report

## msms

### Tool Description
Compute molecular surfaces

### Metadata
- **Docker Image**: quay.io/biocontainers/msms:2.6.1--h9ee0642_3
- **Homepage**: https://github.com/MotorolaMobilityLLC/kernel-msm
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/msms/overview
- **Total Downloads**: 18.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/MotorolaMobilityLLC/kernel-msm
- **Stars**: N/A
### Original Help Text
```text
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


## Metadata
- **Skill**: generated
