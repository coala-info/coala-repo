# msms CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| msms | PASS |  |
| msms_pdb_to_xyzr | PASS |  |
| msms_pdb_to_xyzrn | PASS |  |

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


## msms_pdb_to_xyzr

### Tool Description
Extract x, y, z from a PDB file and generate the radius of each atom (input for msms).

### Metadata
- **Docker Image**: quay.io/biocontainers/msms:2.6.1--h9ee0642_3
- **Homepage**: https://ccsb.scripps.edu/msms/
- **Package**: https://anaconda.org/channels/bioconda/packages/msms/overview
- **Validation**: PASS

### Original Help Text
```text
! /bin/sh
extract x,y,z from PDB file, generate radius of each atom
Hydrogens are presumed to be missing ("united atom" approach) unless -h given
later: options for alternate radius and pattern files
--- Mike Pique, The Scripps Research Institute

input: pdb file as argument or stdin
output: new xyzr file to stdout

Options:

-h: use explicit hydrogen radii instead of default united atom radii

examples:
  pdb_to_xyzr  crambin.pdb > crambin.xyzr

  foo_to_pdb -h mol.foo  | pdb_to_xyzr > mol.xyzr

  foo_to_pdb mol.foo  | pdb_to_xyzr | awk '{print $4}' >   mol.r
```

## msms_pdb_to_xyzrn

### Tool Description
Extract x, y, z from a PDB file and generate the radius of each atom (input for msms).

### Metadata
- **Docker Image**: quay.io/biocontainers/msms:2.6.1--h9ee0642_3
- **Homepage**: https://ccsb.scripps.edu/msms/
- **Package**: https://anaconda.org/channels/bioconda/packages/msms/overview
- **Validation**: PASS

### Original Help Text
```text
! /bin/sh
extract x,y,z from PDB file, generate radius of each atom
Hydrogens are presumed to be missing ("united atom" approach) unless -h given
later: options for alternate radius and pattern files
--- Mike Pique, The Scripps Research Institute

input: pdb file as argument or stdin
output: new xyzr file to stdout

Options:

-h: use explicit hydrogen radii instead of default united atom radii

examples:
  pdb_to_xyzr  crambin.pdb > crambin.xyzr

  foo_to_pdb -h mol.foo  | pdb_to_xyzr > mol.xyzr

  foo_to_pdb mol.foo  | pdb_to_xyzr | awk '{print $4}' >   mol.r
```

## Metadata
- **Skill**: generated
