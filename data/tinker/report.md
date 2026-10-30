# tinker CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| tinker_alchemy | Failed | tool bug: segmentation fault right after the lambda coupling is set, on ethanol and on a water box with the ligand keyword |
| tinker_analyze | PASS |  |
| tinker_anneal | PASS |  |
| tinker_arcedit | PASS |  |
| tinker_bar | PASS |  |
| tinker_correlate | PASS |  |
| tinker_critical | PASS |  |
| tinker_crystal | PASS |  |
| tinker_diffuse | PASS |  |
| tinker_distgeom | Failed | tool bug: the embedding step fails to converge (DEFLATE eigenvalue warnings) and the program writes NaN coordinates then aborts, or segfaults, on ethanol and benzene |
| tinker_dynamic | PASS |  |
| tinker_freefix | PASS |  |
| tinker_gda | PASS |  |
| tinker_intedit | PASS |  |
| tinker_intxyz | PASS |  |
| tinker_minimize | PASS |  |
| tinker_minirot | PASS |  |
| tinker_minrigid | PASS |  |
| tinker_mol2xyz | PASS |  |
| tinker_molxyz | PASS |  |
| tinker_monte | PASS |  |
| tinker_newton | PASS |  |
| tinker_newtrot | PASS |  |
| tinker_nucleic | PASS |  |
| tinker_optimize | PASS |  |
| tinker_optirot | PASS |  |
| tinker_optrigid | PASS |  |
| tinker_path | PASS |  |
| tinker_pdbxyz | PASS |  |
| tinker_polarize | PASS |  |
| tinker_poledit | PASS |  |
| tinker_potential | PASS |  |
| tinker_prmedit | PASS |  |
| tinker_protein | PASS |  |
| tinker_pss | PASS |  |
| tinker_pssrigid | PASS |  |
| tinker_pssrot | PASS |  |
| tinker_radial | PASS |  |
| tinker_saddle | PASS |  |
| tinker_scan | PASS |  |
| tinker_sniffer | PASS |  |
| tinker_spacefill | PASS |  |
| tinker_spectrum | PASS |  |
| tinker_superpose | PASS |  |
| tinker_testgrad | PASS |  |
| tinker_testhess | PASS |  |
| tinker_testpair | PASS |  |
| tinker_testpol | PASS |  |
| tinker_testrot | PASS |  |
| tinker_testsurf | PASS |  |
| tinker_testvir | PASS |  |
| tinker_timer | PASS |  |
| tinker_timerot | PASS |  |
| tinker_torsfit | Not completed | no usable test data: needs Gaussian output logs of several conformations; none available |
| tinker_valence | Not completed | no usable test data: needs a Gaussian output log with frequencies and Hessian; none available (argument order checked only) |
| tinker_vibbig | PASS |  |
| tinker_vibrate | PASS |  |
| tinker_vibrot | PASS |  |
| tinker_xtalfit | PASS |  |
| tinker_xtalmin | PASS |  |
| tinker_xyzedit | PASS |  |
| tinker_xyzint | PASS |  |
| tinker_xyzmol2 | PASS |  |
| tinker_xyzpdb | PASS |  |

## tinker_minimize

### Tool Description
Software Tools for Molecular Design

### Metadata
- **Docker Image**: quay.io/biocontainers/tinker:8.11.3--h8d36177_0
- **Homepage**: https://dasher.wustl.edu/tinker/
- **Package**: https://anaconda.org/channels/bioconda/packages/tinker/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/tinker/overview
- **Total Downloads**: 773
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/TinkerTools/tinker
- **Stars**: N/A
### Original Help Text
```text
######################################################################
   ##########################################################################
  ###                                                                      ###
 ###            Tinker  ---  Software Tools for Molecular Design            ###
 ##                                                                          ##
 ##                        Version 8.11.3   June 2024                        ##
 ##                                                                          ##
 ##               Copyright (c)  Jay William Ponder  1990-2024               ##
 ###                           All Rights Reserved                          ###
  ###                                                                      ###
   ##########################################################################
     ######################################################################


 Enter Cartesian Coordinate File Name :
```


## tinker_newton

### Tool Description
Software Tools for Molecular Design

### Metadata
- **Docker Image**: quay.io/biocontainers/tinker:8.11.3--h8d36177_0
- **Homepage**: https://dasher.wustl.edu/tinker/
- **Package**: https://anaconda.org/channels/bioconda/packages/tinker/overview
- **Validation**: PASS

### Original Help Text
```text
######################################################################
   ##########################################################################
  ###                                                                      ###
 ###            Tinker  ---  Software Tools for Molecular Design            ###
 ##                                                                          ##
 ##                        Version 8.11.3   June 2024                        ##
 ##                                                                          ##
 ##               Copyright (c)  Jay William Ponder  1990-2024               ##
 ###                           All Rights Reserved                          ###
  ###                                                                      ###
   ##########################################################################
     ######################################################################


 Enter Cartesian Coordinate File Name :
```


## tinker_dynamic

### Tool Description
Software Tools for Molecular Design

### Metadata
- **Docker Image**: quay.io/biocontainers/tinker:8.11.3--h8d36177_0
- **Homepage**: https://dasher.wustl.edu/tinker/
- **Package**: https://anaconda.org/channels/bioconda/packages/tinker/overview
- **Validation**: PASS

### Original Help Text
```text
######################################################################
   ##########################################################################
  ###                                                                      ###
 ###            Tinker  ---  Software Tools for Molecular Design            ###
 ##                                                                          ##
 ##                        Version 8.11.3   June 2024                        ##
 ##                                                                          ##
 ##               Copyright (c)  Jay William Ponder  1990-2024               ##
 ###                           All Rights Reserved                          ###
  ###                                                                      ###
   ##########################################################################
     ######################################################################


 Enter Cartesian Coordinate File Name :
```


## tinker_analyze

### Tool Description
Software Tools for Molecular Design

### Metadata
- **Docker Image**: quay.io/biocontainers/tinker:8.11.3--h8d36177_0
- **Homepage**: https://dasher.wustl.edu/tinker/
- **Package**: https://anaconda.org/channels/bioconda/packages/tinker/overview
- **Validation**: PASS

### Original Help Text
```text
######################################################################
   ##########################################################################
  ###                                                                      ###
 ###            Tinker  ---  Software Tools for Molecular Design            ###
 ##                                                                          ##
 ##                        Version 8.11.3   June 2024                        ##
 ##                                                                          ##
 ##               Copyright (c)  Jay William Ponder  1990-2024               ##
 ###                           All Rights Reserved                          ###
  ###                                                                      ###
   ##########################################################################
     ######################################################################


 Enter Cartesian Coordinate File Name :
```


## tinker_xyzpdb

### Tool Description
Software Tools for Molecular Design

### Metadata
- **Docker Image**: quay.io/biocontainers/tinker:8.11.3--h8d36177_0
- **Homepage**: https://dasher.wustl.edu/tinker/
- **Package**: https://anaconda.org/channels/bioconda/packages/tinker/overview
- **Validation**: PASS

### Original Help Text
```text
######################################################################
   ##########################################################################
  ###                                                                      ###
 ###            Tinker  ---  Software Tools for Molecular Design            ###
 ##                                                                          ##
 ##                        Version 8.11.3   June 2024                        ##
 ##                                                                          ##
 ##               Copyright (c)  Jay William Ponder  1990-2024               ##
 ###                           All Rights Reserved                          ###
  ###                                                                      ###
   ##########################################################################
     ######################################################################


 Enter Cartesian Coordinate File Name :
```


## tinker_pdbxyz

### Tool Description
Tinker Software Tools for Molecular Design

### Metadata
- **Docker Image**: quay.io/biocontainers/tinker:8.11.3--h8d36177_0
- **Homepage**: https://dasher.wustl.edu/tinker/
- **Package**: https://anaconda.org/channels/bioconda/packages/tinker/overview
- **Validation**: PASS

### Original Help Text
```text
######################################################################
   ##########################################################################
  ###                                                                      ###
 ###            Tinker  ---  Software Tools for Molecular Design            ###
 ##                                                                          ##
 ##                        Version 8.11.3   June 2024                        ##
 ##                                                                          ##
 ##               Copyright (c)  Jay William Ponder  1990-2024               ##
 ###                           All Rights Reserved                          ###
  ###                                                                      ###
   ##########################################################################
     ######################################################################


 Enter Protein Data Bank File Name :
```


## tinker_vibrate

### Tool Description
Software Tools for Molecular Design

### Metadata
- **Docker Image**: quay.io/biocontainers/tinker:8.11.3--h8d36177_0
- **Homepage**: https://dasher.wustl.edu/tinker/
- **Package**: https://anaconda.org/channels/bioconda/packages/tinker/overview
- **Validation**: PASS

### Original Help Text
```text
######################################################################
   ##########################################################################
  ###                                                                      ###
 ###            Tinker  ---  Software Tools for Molecular Design            ###
 ##                                                                          ##
 ##                        Version 8.11.3   June 2024                        ##
 ##                                                                          ##
 ##               Copyright (c)  Jay William Ponder  1990-2024               ##
 ###                           All Rights Reserved                          ###
  ###                                                                      ###
   ##########################################################################
     ######################################################################


 Enter Cartesian Coordinate File Name :
```


## tinker_xyzint

### Tool Description
Tinker Cartesian to internal coordinates: converts a Cartesian coordinate file into an internal coordinate (Z-matrix) file.

### Metadata
- **Docker Image**: quay.io/biocontainers/tinker:8.11.3--h8d36177_0
- **Homepage**: https://dasher.wustl.edu/tinker/
- **Package**: https://anaconda.org/channels/bioconda/packages/tinker/overview
- **Validation**: PASS

### Original Help Text
```text

     ######################################################################
   ##########################################################################
  ###                                                                      ###
 ###            Tinker  ---  Software Tools for Molecular Design            ###
 ##                                                                          ##
 ##                        Version 8.11.3   June 2024                        ##
 ##                                                                          ##
 ##               Copyright (c)  Jay William Ponder  1990-2024               ##
 ###                           All Rights Reserved                          ###
  ###                                                                      ###
   ##########################################################################
     ######################################################################


 Enter Cartesian Coordinate File Name :
```

## tinker_xyzmol2

### Tool Description
Tinker Cartesian to MOL2: converts a Cartesian coordinate file into a Tripos MOL2 file.

### Metadata
- **Docker Image**: quay.io/biocontainers/tinker:8.11.3--h8d36177_0
- **Homepage**: https://dasher.wustl.edu/tinker/
- **Package**: https://anaconda.org/channels/bioconda/packages/tinker/overview
- **Validation**: PASS

### Original Help Text
```text

     ######################################################################
   ##########################################################################
  ###                                                                      ###
 ###            Tinker  ---  Software Tools for Molecular Design            ###
 ##                                                                          ##
 ##                        Version 8.11.3   June 2024                        ##
 ##                                                                          ##
 ##               Copyright (c)  Jay William Ponder  1990-2024               ##
 ###                           All Rights Reserved                          ###
  ###                                                                      ###
   ##########################################################################
     ######################################################################


 Enter Cartesian Coordinate File Name :
```

## tinker_testvir

### Tool Description
Tinker virial test: compares the analytical virial tensor with the numerical one from a small change of the periodic box.

### Metadata
- **Docker Image**: quay.io/biocontainers/tinker:8.11.3--h8d36177_0
- **Homepage**: https://dasher.wustl.edu/tinker/
- **Package**: https://anaconda.org/channels/bioconda/packages/tinker/overview
- **Validation**: PASS

### Original Help Text
```text

     ######################################################################
   ##########################################################################
  ###                                                                      ###
 ###            Tinker  ---  Software Tools for Molecular Design            ###
 ##                                                                          ##
 ##                        Version 8.11.3   June 2024                        ##
 ##                                                                          ##
 ##               Copyright (c)  Jay William Ponder  1990-2024               ##
 ###                           All Rights Reserved                          ###
  ###                                                                      ###
   ##########################################################################
     ######################################################################


 Enter Cartesian Coordinate File Name :
```

## tinker_timer

### Tool Description
Tinker timing test: times energy, gradient and optionally Hessian evaluations of a structure.

### Metadata
- **Docker Image**: quay.io/biocontainers/tinker:8.11.3--h8d36177_0
- **Homepage**: https://dasher.wustl.edu/tinker/
- **Package**: https://anaconda.org/channels/bioconda/packages/tinker/overview
- **Validation**: PASS

### Original Help Text
```text

     ######################################################################
   ##########################################################################
  ###                                                                      ###
 ###            Tinker  ---  Software Tools for Molecular Design            ###
 ##                                                                          ##
 ##                        Version 8.11.3   June 2024                        ##
 ##                                                                          ##
 ##               Copyright (c)  Jay William Ponder  1990-2024               ##
 ###                           All Rights Reserved                          ###
  ###                                                                      ###
   ##########################################################################
     ######################################################################


 Enter Cartesian Coordinate File Name :
```

## tinker_testgrad

### Tool Description
Tinker gradient test: computes the analytical and numerical gradient of the potential energy and compares them.

### Metadata
- **Docker Image**: quay.io/biocontainers/tinker:8.11.3--h8d36177_0
- **Homepage**: https://dasher.wustl.edu/tinker/
- **Package**: https://anaconda.org/channels/bioconda/packages/tinker/overview
- **Validation**: PASS

### Original Help Text
```text

     ######################################################################
   ##########################################################################
  ###                                                                      ###
 ###            Tinker  ---  Software Tools for Molecular Design            ###
 ##                                                                          ##
 ##                        Version 8.11.3   June 2024                        ##
 ##                                                                          ##
 ##               Copyright (c)  Jay William Ponder  1990-2024               ##
 ###                           All Rights Reserved                          ###
  ###                                                                      ###
   ##########################################################################
     ######################################################################


 Enter Cartesian Coordinate File Name :
```

## tinker_testhess

### Tool Description
Tinker Hessian test: computes the analytical and numerical Hessian matrix of the potential energy and compares them.

### Metadata
- **Docker Image**: quay.io/biocontainers/tinker:8.11.3--h8d36177_0
- **Homepage**: https://dasher.wustl.edu/tinker/
- **Package**: https://anaconda.org/channels/bioconda/packages/tinker/overview
- **Validation**: PASS

### Original Help Text
```text

     ######################################################################
   ##########################################################################
  ###                                                                      ###
 ###            Tinker  ---  Software Tools for Molecular Design            ###
 ##                                                                          ##
 ##                        Version 8.11.3   June 2024                        ##
 ##                                                                          ##
 ##               Copyright (c)  Jay William Ponder  1990-2024               ##
 ###                           All Rights Reserved                          ###
  ###                                                                      ###
   ##########################################################################
     ######################################################################


 Enter Cartesian Coordinate File Name :
```

## tinker_testpair

### Tool Description
Tinker pairwise neighbor test: times the double loop, method of lights and neighbor list pair searches and compares the energies they give.

### Metadata
- **Docker Image**: quay.io/biocontainers/tinker:8.11.3--h8d36177_0
- **Homepage**: https://dasher.wustl.edu/tinker/
- **Package**: https://anaconda.org/channels/bioconda/packages/tinker/overview
- **Validation**: PASS

### Original Help Text
```text

     ######################################################################
   ##########################################################################
  ###                                                                      ###
 ###            Tinker  ---  Software Tools for Molecular Design            ###
 ##                                                                          ##
 ##                        Version 8.11.3   June 2024                        ##
 ##                                                                          ##
 ##               Copyright (c)  Jay William Ponder  1990-2024               ##
 ###                           All Rights Reserved                          ###
  ###                                                                      ###
   ##########################################################################
     ######################################################################


 Enter Cartesian Coordinate File Name :
```

## tinker_testpol

### Tool Description
Tinker polarization test: compares the induced dipoles from direct, PCG, OPT and TCG polarization solvers against the exact mutual polarization.

### Metadata
- **Docker Image**: quay.io/biocontainers/tinker:8.11.3--h8d36177_0
- **Homepage**: https://dasher.wustl.edu/tinker/
- **Package**: https://anaconda.org/channels/bioconda/packages/tinker/overview
- **Validation**: PASS

### Original Help Text
```text

     ######################################################################
   ##########################################################################
  ###                                                                      ###
 ###            Tinker  ---  Software Tools for Molecular Design            ###
 ##                                                                          ##
 ##                        Version 8.11.3   June 2024                        ##
 ##                                                                          ##
 ##               Copyright (c)  Jay William Ponder  1990-2024               ##
 ###                           All Rights Reserved                          ###
  ###                                                                      ###
   ##########################################################################
     ######################################################################


 Enter Cartesian Coordinate File Name :
```

## tinker_testrot

### Tool Description
Tinker torsional gradient test: compares analytical and numerical derivatives of the energy with respect to torsional angles.

### Metadata
- **Docker Image**: quay.io/biocontainers/tinker:8.11.3--h8d36177_0
- **Homepage**: https://dasher.wustl.edu/tinker/
- **Package**: https://anaconda.org/channels/bioconda/packages/tinker/overview
- **Validation**: PASS

### Original Help Text
```text

     ######################################################################
   ##########################################################################
  ###                                                                      ###
 ###            Tinker  ---  Software Tools for Molecular Design            ###
 ##                                                                          ##
 ##                        Version 8.11.3   June 2024                        ##
 ##                                                                          ##
 ##               Copyright (c)  Jay William Ponder  1990-2024               ##
 ###                           All Rights Reserved                          ###
  ###                                                                      ###
   ##########################################################################
     ######################################################################


 Enter Internal Coordinate File Name :
```

## tinker_timerot

### Tool Description
Tinker torsional timing test: times energy, torsional gradient and optionally Hessian evaluations in torsional space.

### Metadata
- **Docker Image**: quay.io/biocontainers/tinker:8.11.3--h8d36177_0
- **Homepage**: https://dasher.wustl.edu/tinker/
- **Package**: https://anaconda.org/channels/bioconda/packages/tinker/overview
- **Validation**: PASS

### Original Help Text
```text

```

## tinker_vibrot

### Tool Description
Tinker torsional vibrational analysis: builds the torsional Hessian and prints its diagonal and eigenvalues.

### Metadata
- **Docker Image**: quay.io/biocontainers/tinker:8.11.3--h8d36177_0
- **Homepage**: https://dasher.wustl.edu/tinker/
- **Package**: https://anaconda.org/channels/bioconda/packages/tinker/overview
- **Validation**: PASS

### Original Help Text
```text

     ######################################################################
   ##########################################################################
  ###                                                                      ###
 ###            Tinker  ---  Software Tools for Molecular Design            ###
 ##                                                                          ##
 ##                        Version 8.11.3   June 2024                        ##
 ##                                                                          ##
 ##               Copyright (c)  Jay William Ponder  1990-2024               ##
 ###                           All Rights Reserved                          ###
  ###                                                                      ###
   ##########################################################################
     ######################################################################


 Enter Internal Coordinate File Name :
```

## tinker_testsurf

### Tool Description
Tinker surface area test: compares the alternative surface area and volume methods (Richmond, Connolly, Kundrot and UnionBall alpha shape) and their derivatives.

### Metadata
- **Docker Image**: quay.io/biocontainers/tinker:8.11.3--h8d36177_0
- **Homepage**: https://dasher.wustl.edu/tinker/
- **Package**: https://anaconda.org/channels/bioconda/packages/tinker/overview
- **Validation**: PASS

### Original Help Text
```text

     ######################################################################
   ##########################################################################
  ###                                                                      ###
 ###            Tinker  ---  Software Tools for Molecular Design            ###
 ##                                                                          ##
 ##                        Version 8.11.3   June 2024                        ##
 ##                                                                          ##
 ##               Copyright (c)  Jay William Ponder  1990-2024               ##
 ###                           All Rights Reserved                          ###
  ###                                                                      ###
   ##########################################################################
     ######################################################################


 Enter Cartesian Coordinate File Name :
```

## tinker_spacefill

### Tool Description
Tinker surface area and volume: computes the van der Waals, accessible or contact-reentrant surface area and volume of a structure.

### Metadata
- **Docker Image**: quay.io/biocontainers/tinker:8.11.3--h8d36177_0
- **Homepage**: https://dasher.wustl.edu/tinker/
- **Package**: https://anaconda.org/channels/bioconda/packages/tinker/overview
- **Validation**: PASS

### Original Help Text
```text

     ######################################################################
   ##########################################################################
  ###                                                                      ###
 ###            Tinker  ---  Software Tools for Molecular Design            ###
 ##                                                                          ##
 ##                        Version 8.11.3   June 2024                        ##
 ##                                                                          ##
 ##               Copyright (c)  Jay William Ponder  1990-2024               ##
 ###                           All Rights Reserved                          ###
  ###                                                                      ###
   ##########################################################################
     ######################################################################


 Enter Cartesian Coordinate File Name :
```

## tinker_protein

### Tool Description
Tinker protein builder: builds internal and Cartesian coordinates of a polypeptide from the amino acid sequence and optional backbone and side chain torsion angles.

### Metadata
- **Docker Image**: quay.io/biocontainers/tinker:8.11.3--h8d36177_0
- **Homepage**: https://dasher.wustl.edu/tinker/
- **Package**: https://anaconda.org/channels/bioconda/packages/tinker/overview
- **Validation**: PASS

### Original Help Text
```text

     ######################################################################
   ##########################################################################
  ###                                                                      ###
 ###            Tinker  ---  Software Tools for Molecular Design            ###
 ##                                                                          ##
 ##                        Version 8.11.3   June 2024                        ##
 ##                                                                          ##
 ##               Copyright (c)  Jay William Ponder  1990-2024               ##
 ###                           All Rights Reserved                          ###
  ###                                                                      ###
   ##########################################################################
     ######################################################################


 Enter Name to be Used for Output Files :
```

## tinker_pss

### Tool Description
Tinker potential smoothing and search: follows a structure along a smoothing schedule (forward and backward) and optionally runs local searches at each smoothing level; every level is written as name.000, name.001, ...

### Metadata
- **Docker Image**: quay.io/biocontainers/tinker:8.11.3--h8d36177_0
- **Homepage**: https://dasher.wustl.edu/tinker/
- **Package**: https://anaconda.org/channels/bioconda/packages/tinker/overview
- **Validation**: PASS

### Original Help Text
```text

     ######################################################################
   ##########################################################################
  ###                                                                      ###
 ###            Tinker  ---  Software Tools for Molecular Design            ###
 ##                                                                          ##
 ##                        Version 8.11.3   June 2024                        ##
 ##                                                                          ##
 ##               Copyright (c)  Jay William Ponder  1990-2024               ##
 ###                           All Rights Reserved                          ###
  ###                                                                      ###
   ##########################################################################
     ######################################################################


 Enter Cartesian Coordinate File Name :
```

## tinker_pssrot

### Tool Description
Tinker potential smoothing and search in torsional space: follows a structure along a smoothing schedule with optional local searches; every level is written as name.000, name.001, ...

### Metadata
- **Docker Image**: quay.io/biocontainers/tinker:8.11.3--h8d36177_0
- **Homepage**: https://dasher.wustl.edu/tinker/
- **Package**: https://anaconda.org/channels/bioconda/packages/tinker/overview
- **Validation**: PASS

### Original Help Text
```text

     ######################################################################
   ##########################################################################
  ###                                                                      ###
 ###            Tinker  ---  Software Tools for Molecular Design            ###
 ##                                                                          ##
 ##                        Version 8.11.3   June 2024                        ##
 ##                                                                          ##
 ##               Copyright (c)  Jay William Ponder  1990-2024               ##
 ###                           All Rights Reserved                          ###
  ###                                                                      ###
   ##########################################################################
     ######################################################################


 Enter Internal Coordinate File Name :
```

## tinker_pssrigid

### Tool Description
Tinker potential smoothing and search for rigid bodies: follows a structure of rigid molecules along a smoothing schedule with optional local searches; every level is written as name.000, name.001, ...

### Metadata
- **Docker Image**: quay.io/biocontainers/tinker:8.11.3--h8d36177_0
- **Homepage**: https://dasher.wustl.edu/tinker/
- **Package**: https://anaconda.org/channels/bioconda/packages/tinker/overview
- **Validation**: PASS

### Original Help Text
```text

```

## tinker_scan

### Tool Description
Tinker potential surface scan: finds local minima of a structure by normal mode searches and writes each minimum as a numbered structure file or to an archive.

### Metadata
- **Docker Image**: quay.io/biocontainers/tinker:8.11.3--h8d36177_0
- **Homepage**: https://dasher.wustl.edu/tinker/
- **Package**: https://anaconda.org/channels/bioconda/packages/tinker/overview
- **Validation**: PASS

### Original Help Text
```text

```

## tinker_sniffer

### Tool Description
Tinker global optimization by the discrete generalized descent method (SNIFFER): searches for the global energy minimum of a structure.

### Metadata
- **Docker Image**: quay.io/biocontainers/tinker:8.11.3--h8d36177_0
- **Homepage**: https://dasher.wustl.edu/tinker/
- **Package**: https://anaconda.org/channels/bioconda/packages/tinker/overview
- **Validation**: PASS

### Original Help Text
```text

     ######################################################################
   ##########################################################################
  ###                                                                      ###
 ###            Tinker  ---  Software Tools for Molecular Design            ###
 ##                                                                          ##
 ##                        Version 8.11.3   June 2024                        ##
 ##                                                                          ##
 ##               Copyright (c)  Jay William Ponder  1990-2024               ##
 ###                           All Rights Reserved                          ###
  ###                                                                      ###
   ##########################################################################
     ######################################################################


 Enter Cartesian Coordinate File Name :
```

## tinker_saddle

### Tool Description
Tinker transition state location: finds a saddle point between two endpoint structures by synchronous transit and quadratic path methods.

### Metadata
- **Docker Image**: quay.io/biocontainers/tinker:8.11.3--h8d36177_0
- **Homepage**: https://dasher.wustl.edu/tinker/
- **Package**: https://anaconda.org/channels/bioconda/packages/tinker/overview
- **Validation**: PASS

### Original Help Text
```text

```

## tinker_superpose

### Tool Description
Tinker structure superposition: fits the atoms of one structure onto those of a second structure and reports the root mean square deviation.

### Metadata
- **Docker Image**: quay.io/biocontainers/tinker:8.11.3--h8d36177_0
- **Homepage**: https://dasher.wustl.edu/tinker/
- **Package**: https://anaconda.org/channels/bioconda/packages/tinker/overview
- **Validation**: PASS

### Original Help Text
```text

     ######################################################################
   ##########################################################################
  ###                                                                      ###
 ###            Tinker  ---  Software Tools for Molecular Design            ###
 ##                                                                          ##
 ##                        Version 8.11.3   June 2024                        ##
 ##                                                                          ##
 ##               Copyright (c)  Jay William Ponder  1990-2024               ##
 ###                           All Rights Reserved                          ###
  ###                                                                      ###
   ##########################################################################
     ######################################################################


 Enter Cartesian Coordinate File Name :
```

## tinker_xtalmin

### Tool Description
Tinker crystal minimization: minimizes the energy of a crystal with respect to the atom positions and the lattice dimensions.

### Metadata
- **Docker Image**: quay.io/biocontainers/tinker:8.11.3--h8d36177_0
- **Homepage**: https://dasher.wustl.edu/tinker/
- **Package**: https://anaconda.org/channels/bioconda/packages/tinker/overview
- **Validation**: PASS

### Original Help Text
```text

     ######################################################################
   ##########################################################################
  ###                                                                      ###
 ###            Tinker  ---  Software Tools for Molecular Design            ###
 ##                                                                          ##
 ##                        Version 8.11.3   June 2024                        ##
 ##                                                                          ##
 ##               Copyright (c)  Jay William Ponder  1990-2024               ##
 ###                           All Rights Reserved                          ###
  ###                                                                      ###
   ##########################################################################
     ######################################################################


 Enter Cartesian Coordinate File Name :
```

## tinker_xyzedit

### Tool Description
Tinker coordinate file editor: applies one editing operation (renumber, remove or insert atoms, change atom types, assign connectivity, translate, rotate, trim or fill a periodic box, append structures and more) to a coordinate file and writes a new version.

### Metadata
- **Docker Image**: quay.io/biocontainers/tinker:8.11.3--h8d36177_0
- **Homepage**: https://dasher.wustl.edu/tinker/
- **Package**: https://anaconda.org/channels/bioconda/packages/tinker/overview
- **Validation**: PASS

### Original Help Text
```text

     ######################################################################
   ##########################################################################
  ###                                                                      ###
 ###            Tinker  ---  Software Tools for Molecular Design            ###
 ##                                                                          ##
 ##                        Version 8.11.3   June 2024                        ##
 ##                                                                          ##
 ##               Copyright (c)  Jay William Ponder  1990-2024               ##
 ###                           All Rights Reserved                          ###
  ###                                                                      ###
   ##########################################################################
     ######################################################################


 Enter Cartesian Coordinate File Name :
```

## tinker_radial

### Tool Description
Tinker radial distribution function: computes the pairwise g(r) between two atom names or atom types from a coordinate archive.

### Metadata
- **Docker Image**: quay.io/biocontainers/tinker:8.11.3--h8d36177_0
- **Homepage**: https://dasher.wustl.edu/tinker/
- **Package**: https://anaconda.org/channels/bioconda/packages/tinker/overview
- **Validation**: PASS

### Original Help Text
```text

     ######################################################################
   ##########################################################################
  ###                                                                      ###
 ###            Tinker  ---  Software Tools for Molecular Design            ###
 ##                                                                          ##
 ##                        Version 8.11.3   June 2024                        ##
 ##                                                                          ##
 ##               Copyright (c)  Jay William Ponder  1990-2024               ##
 ###                           All Rights Reserved                          ###
  ###                                                                      ###
   ##########################################################################
     ######################################################################


 Enter Coordinate Archive File Name :
```

## tinker_spectrum

### Tool Description
Tinker power spectrum: computes the infrared-like power spectrum from a velocity autocorrelation file written by correlate.

### Metadata
- **Docker Image**: quay.io/biocontainers/tinker:8.11.3--h8d36177_0
- **Homepage**: https://dasher.wustl.edu/tinker/
- **Package**: https://anaconda.org/channels/bioconda/packages/tinker/overview
- **Validation**: PASS

### Original Help Text
```text

     ######################################################################
   ##########################################################################
  ###                                                                      ###
 ###            Tinker  ---  Software Tools for Molecular Design            ###
 ##                                                                          ##
 ##                        Version 8.11.3   June 2024                        ##
 ##                                                                          ##
 ##               Copyright (c)  Jay William Ponder  1990-2024               ##
 ###                           All Rights Reserved                          ###
  ###                                                                      ###
   ##########################################################################
     ######################################################################


 Enter Name of Velocity Autocorrelation File :
```

## tinker_vibbig

### Tool Description
Tinker vibrational analysis of large systems: finds normal modes by an iterative block method (starting at the lowest or highest frequency); the number of roots comes from the vib-roots keyword.

### Metadata
- **Docker Image**: quay.io/biocontainers/tinker:8.11.3--h8d36177_0
- **Homepage**: https://dasher.wustl.edu/tinker/
- **Package**: https://anaconda.org/channels/bioconda/packages/tinker/overview
- **Validation**: PASS

### Original Help Text
```text

     ######################################################################
   ##########################################################################
  ###                                                                      ###
 ###            Tinker  ---  Software Tools for Molecular Design            ###
 ##                                                                          ##
 ##                        Version 8.11.3   June 2024                        ##
 ##                                                                          ##
 ##               Copyright (c)  Jay William Ponder  1990-2024               ##
 ###                           All Rights Reserved                          ###
  ###                                                                      ###
   ##########################################################################
     ######################################################################


 Enter Cartesian Coordinate File Name :
```

## tinker_xtalfit

### Tool Description
Tinker crystal parameter fitting: fits van der Waals, charge, dipole and polarizability parameters to the lattice energies and structures of one or more crystals.

### Metadata
- **Docker Image**: quay.io/biocontainers/tinker:8.11.3--h8d36177_0
- **Homepage**: https://dasher.wustl.edu/tinker/
- **Package**: https://anaconda.org/channels/bioconda/packages/tinker/overview
- **Validation**: PASS

### Original Help Text
```text

     ######################################################################
   ##########################################################################
  ###                                                                      ###
 ###            Tinker  ---  Software Tools for Molecular Design            ###
 ##                                                                          ##
 ##                        Version 8.11.3   June 2024                        ##
 ##                                                                          ##
 ##               Copyright (c)  Jay William Ponder  1990-2024               ##
 ###                           All Rights Reserved                          ###
  ###                                                                      ###
   ##########################################################################
     ######################################################################


 The Following Parameters can be Fit for each Atom Type :

    (1) Van der Waals Atomic Radius
    (2) Van der Waals Well Depth
    (3) Hydrogen Atom Reduction Factor
    (4) Atomic Partial Charge
    (5) Bond Dipole Moment Magnitude
    (6) Bond Dipole Moment Position
    (7) Atomic Polarizability

 Enter Parameter Type then Atom Class or Type(s) :
```

## tinker_alchemy

### Tool Description
Tinker free energy perturbation: computes the free energy difference for a small change of the lambda coupling parameter by Boltzmann weighting the potential energy difference over the snapshots of a trajectory stored as numbered coordinate files.

### Metadata
- **Docker Image**: quay.io/biocontainers/tinker:8.11.3--h8d36177_0
- **Homepage**: https://dasher.wustl.edu/tinker/
- **Package**: https://anaconda.org/channels/bioconda/packages/tinker/overview
- **Validation**: PASS

### Original Help Text
```text

     ######################################################################
   ##########################################################################
  ###                                                                      ###
 ###            Tinker  ---  Software Tools for Molecular Design            ###
 ##                                                                          ##
 ##                        Version 8.11.3   June 2024                        ##
 ##                                                                          ##
 ##               Copyright (c)  Jay William Ponder  1990-2024               ##
 ###                           All Rights Reserved                          ###
  ###                                                                      ###
   ##########################################################################
     ######################################################################


 Enter Cartesian Coordinate File Name :
```

## tinker_anneal

### Tool Description
Tinker molecular dynamics simulated annealing: runs an optional equilibration phase and then a cooling protocol (linear, sigmoidal or exponential) between a hot and a cold temperature; writes a restart file (.dyn) and a trajectory archive (.arc).

### Metadata
- **Docker Image**: quay.io/biocontainers/tinker:8.11.3--h8d36177_0
- **Homepage**: https://dasher.wustl.edu/tinker/
- **Package**: https://anaconda.org/channels/bioconda/packages/tinker/overview
- **Validation**: PASS

### Original Help Text
```text

     ######################################################################
   ##########################################################################
  ###                                                                      ###
 ###            Tinker  ---  Software Tools for Molecular Design            ###
 ##                                                                          ##
 ##                        Version 8.11.3   June 2024                        ##
 ##                                                                          ##
 ##               Copyright (c)  Jay William Ponder  1990-2024               ##
 ###                           All Rights Reserved                          ###
  ###                                                                      ###
   ##########################################################################
     ######################################################################


 Enter Cartesian Coordinate File Name :
```

## tinker_arcedit

### Tool Description
Tinker coordinate archive editing utility: creates an archive from numbered files, extracts frames, trims atoms, folds or unfolds molecules in the periodic box, and converts between the formatted archive and the DCD binary format.

### Metadata
- **Docker Image**: quay.io/biocontainers/tinker:8.11.3--h8d36177_0
- **Homepage**: https://dasher.wustl.edu/tinker/
- **Package**: https://anaconda.org/channels/bioconda/packages/tinker/overview
- **Validation**: PASS

### Original Help Text
```text

     ######################################################################
   ##########################################################################
  ###                                                                      ###
 ###            Tinker  ---  Software Tools for Molecular Design            ###
 ##                                                                          ##
 ##                        Version 8.11.3   June 2024                        ##
 ##                                                                          ##
 ##               Copyright (c)  Jay William Ponder  1990-2024               ##
 ###                           All Rights Reserved                          ###
  ###                                                                      ###
   ##########################################################################
     ######################################################################


 Enter Coordinate Archive File Name :
```

## tinker_bar

### Tool Description
Tinker thermodynamic perturbation utility: creates a BAR file with the potential energies of two trajectories in two states, and computes free energy (FEP and Bennett acceptance ratio), enthalpy and entropy differences from it.

### Metadata
- **Docker Image**: quay.io/biocontainers/tinker:8.11.3--h8d36177_0
- **Homepage**: https://dasher.wustl.edu/tinker/
- **Package**: https://anaconda.org/channels/bioconda/packages/tinker/overview
- **Validation**: PASS

### Original Help Text
```text

     ######################################################################
   ##########################################################################
  ###                                                                      ###
 ###            Tinker  ---  Software Tools for Molecular Design            ###
 ##                                                                          ##
 ##                        Version 8.11.3   June 2024                        ##
 ##                                                                          ##
 ##               Copyright (c)  Jay William Ponder  1990-2024               ##
 ###                           All Rights Reserved                          ###
  ###                                                                      ###
   ##########################################################################
     ######################################################################


 The Tinker Thermodynamic Perturbation Utility Can :

    (1) Create BAR File with Perturbed Potential Energies
    (2) Compute Thermodynamic Values from Tinker BAR File

 Enter the Number of the Desired Choice :
```

## tinker_correlate

### Tool Description
Tinker correlation function utility: computes the velocity autocorrelation function or the superposition (RMS deviation) correlation function from a series of numbered coordinate cycle files.

### Metadata
- **Docker Image**: quay.io/biocontainers/tinker:8.11.3--h8d36177_0
- **Homepage**: https://dasher.wustl.edu/tinker/
- **Package**: https://anaconda.org/channels/bioconda/packages/tinker/overview
- **Validation**: PASS

### Original Help Text
```text

     ######################################################################
   ##########################################################################
  ###                                                                      ###
 ###            Tinker  ---  Software Tools for Molecular Design            ###
 ##                                                                          ##
 ##                        Version 8.11.3   June 2024                        ##
 ##                                                                          ##
 ##               Copyright (c)  Jay William Ponder  1990-2024               ##
 ###                           All Rights Reserved                          ###
  ###                                                                      ###
   ##########################################################################
     ######################################################################


 The Tinker Correlation Function Utility Can :

    (1) Find Velocity Autocorrelation Function
    (2) Find Superposition Correlation Function

 Enter the Number of the Desired Choice :
```

## tinker_critical

### Tool Description
Tinker search for critical points (minima, maxima and saddle points) of the potential energy surface by least-squares minimization of the gradient; the result is written to a new version of the coordinate file (<name>.xyz_2).

### Metadata
- **Docker Image**: quay.io/biocontainers/tinker:8.11.3--h8d36177_0
- **Homepage**: https://dasher.wustl.edu/tinker/
- **Package**: https://anaconda.org/channels/bioconda/packages/tinker/overview
- **Validation**: PASS

### Original Help Text
```text

     ######################################################################
   ##########################################################################
  ###                                                                      ###
 ###            Tinker  ---  Software Tools for Molecular Design            ###
 ##                                                                          ##
 ##                        Version 8.11.3   June 2024                        ##
 ##                                                                          ##
 ##               Copyright (c)  Jay William Ponder  1990-2024               ##
 ###                           All Rights Reserved                          ###
  ###                                                                      ###
   ##########################################################################
     ######################################################################


 Enter Cartesian Coordinate File Name :
```

## tinker_crystal

### Tool Description
Tinker crystal structure utility: converts between fractional and Cartesian coordinates, moves stray molecules into the unit cell, builds a unit cell from an asymmetric unit and a space group, or builds a block of unit cells; the result is written to a new coordinate file.

### Metadata
- **Docker Image**: quay.io/biocontainers/tinker:8.11.3--h8d36177_0
- **Homepage**: https://dasher.wustl.edu/tinker/
- **Package**: https://anaconda.org/channels/bioconda/packages/tinker/overview
- **Validation**: PASS

### Original Help Text
```text

     ######################################################################
   ##########################################################################
  ###                                                                      ###
 ###            Tinker  ---  Software Tools for Molecular Design            ###
 ##                                                                          ##
 ##                        Version 8.11.3   June 2024                        ##
 ##                                                                          ##
 ##               Copyright (c)  Jay William Ponder  1990-2024               ##
 ###                           All Rights Reserved                          ###
  ###                                                                      ###
   ##########################################################################
     ######################################################################


 Enter Cartesian Coordinate File Name :
```

## tinker_diffuse

### Tool Description
Tinker self-diffusion constant of a liquid or solution: computes the mean squared displacement of molecular centers from a periodic coordinate archive and the diffusion constant from it.

### Metadata
- **Docker Image**: quay.io/biocontainers/tinker:8.11.3--h8d36177_0
- **Homepage**: https://dasher.wustl.edu/tinker/
- **Package**: https://anaconda.org/channels/bioconda/packages/tinker/overview
- **Validation**: PASS

### Original Help Text
```text

     ######################################################################
   ##########################################################################
  ###                                                                      ###
 ###            Tinker  ---  Software Tools for Molecular Design            ###
 ##                                                                          ##
 ##                        Version 8.11.3   June 2024                        ##
 ##                                                                          ##
 ##               Copyright (c)  Jay William Ponder  1990-2024               ##
 ###                           All Rights Reserved                          ###
  ###                                                                      ###
   ##########################################################################
     ######################################################################


 Enter Coordinate Archive File Name :
```

## tinker_distgeom

### Tool Description
Tinker distance geometry: generates structures consistent with the distance bounds, chirality and planarity restraints of a molecule; the structures are written to numbered files (<name>.001, ...).

### Metadata
- **Docker Image**: quay.io/biocontainers/tinker:8.11.3--h8d36177_0
- **Homepage**: https://dasher.wustl.edu/tinker/
- **Package**: https://anaconda.org/channels/bioconda/packages/tinker/overview
- **Validation**: PASS

### Original Help Text
```text

     ######################################################################
   ##########################################################################
  ###                                                                      ###
 ###            Tinker  ---  Software Tools for Molecular Design            ###
 ##                                                                          ##
 ##                        Version 8.11.3   June 2024                        ##
 ##                                                                          ##
 ##               Copyright (c)  Jay William Ponder  1990-2024               ##
 ###                           All Rights Reserved                          ###
  ###                                                                      ###
   ##########################################################################
     ######################################################################


 Enter Cartesian Coordinate File Name :
```

## tinker_freefix

### Tool Description
Tinker free energy of a harmonic (flat-bottom) or Boresch restraint: calculates the analytical volume integral and the restraint free energy, entropy and enthalpy.

### Metadata
- **Docker Image**: quay.io/biocontainers/tinker:8.11.3--h8d36177_0
- **Homepage**: https://dasher.wustl.edu/tinker/
- **Package**: https://anaconda.org/channels/bioconda/packages/tinker/overview
- **Validation**: PASS

### Original Help Text
```text

     ######################################################################
   ##########################################################################
  ###                                                                      ###
 ###            Tinker  ---  Software Tools for Molecular Design            ###
 ##                                                                          ##
 ##                        Version 8.11.3   June 2024                        ##
 ##                                                                          ##
 ##               Copyright (c)  Jay William Ponder  1990-2024               ##
 ###                           All Rights Reserved                          ###
  ###                                                                      ###
   ##########################################################################
     ######################################################################


 Choose Harmonic Restraint or Boresch Restraint [H] :
```

## tinker_gda

### Tool Description
Tinker Gaussian density annealing (GDA) global optimization: smooths the potential energy surface with Gaussian density functions, anneals from low to high inverse temperature (beta) and finishes with a minimization; one structure per trial is written to numbered files (<name>.001, ...).

### Metadata
- **Docker Image**: quay.io/biocontainers/tinker:8.11.3--h8d36177_0
- **Homepage**: https://dasher.wustl.edu/tinker/
- **Package**: https://anaconda.org/channels/bioconda/packages/tinker/overview
- **Validation**: PASS

### Original Help Text
```text

     ######################################################################
   ##########################################################################
  ###                                                                      ###
 ###            Tinker  ---  Software Tools for Molecular Design            ###
 ##                                                                          ##
 ##                        Version 8.11.3   June 2024                        ##
 ##                                                                          ##
 ##               Copyright (c)  Jay William Ponder  1990-2024               ##
 ###                           All Rights Reserved                          ###
  ###                                                                      ###
   ##########################################################################
     ######################################################################


 Enter Cartesian Coordinate File Name :
```

## tinker_intedit

### Tool Description
Tinker Z-matrix internal coordinate editor: shows and changes bond lengths, bond angles, dihedral angles, chirality and atom types in an internal coordinate file; the commands are read from standard input and EXIT writes a new version of the file (<name>.int_2).

### Metadata
- **Docker Image**: quay.io/biocontainers/tinker:8.11.3--h8d36177_0
- **Homepage**: https://dasher.wustl.edu/tinker/
- **Package**: https://anaconda.org/channels/bioconda/packages/tinker/overview
- **Validation**: PASS

### Original Help Text
```text

     ######################################################################
   ##########################################################################
  ###                                                                      ###
 ###            Tinker  ---  Software Tools for Molecular Design            ###
 ##                                                                          ##
 ##                        Version 8.11.3   June 2024                        ##
 ##                                                                          ##
 ##               Copyright (c)  Jay William Ponder  1990-2024               ##
 ###                           All Rights Reserved                          ###
  ###                                                                      ###
   ##########################################################################
     ######################################################################


 Enter Internal Coordinate File Name :
```

## tinker_intxyz

### Tool Description
Tinker conversion of a Z-matrix internal coordinate file (.int) to a Cartesian coordinate file (.xyz).

### Metadata
- **Docker Image**: quay.io/biocontainers/tinker:8.11.3--h8d36177_0
- **Homepage**: https://dasher.wustl.edu/tinker/
- **Package**: https://anaconda.org/channels/bioconda/packages/tinker/overview
- **Validation**: PASS

### Original Help Text
```text

     ######################################################################
   ##########################################################################
  ###                                                                      ###
 ###            Tinker  ---  Software Tools for Molecular Design            ###
 ##                                                                          ##
 ##                        Version 8.11.3   June 2024                        ##
 ##                                                                          ##
 ##               Copyright (c)  Jay William Ponder  1990-2024               ##
 ###                           All Rights Reserved                          ###
  ###                                                                      ###
   ##########################################################################
     ######################################################################


 Enter Internal Coordinate File Name :
```

## tinker_minirot

### Tool Description
Tinker limited-memory BFGS energy minimization in torsional space; reads a Z-matrix internal coordinate file (.int) and writes the minimized internal coordinates to a new version (<name>.int_2).

### Metadata
- **Docker Image**: quay.io/biocontainers/tinker:8.11.3--h8d36177_0
- **Homepage**: https://dasher.wustl.edu/tinker/
- **Package**: https://anaconda.org/channels/bioconda/packages/tinker/overview
- **Validation**: PASS

### Original Help Text
```text

     ######################################################################
   ##########################################################################
  ###                                                                      ###
 ###            Tinker  ---  Software Tools for Molecular Design            ###
 ##                                                                          ##
 ##                        Version 8.11.3   June 2024                        ##
 ##                                                                          ##
 ##               Copyright (c)  Jay William Ponder  1990-2024               ##
 ###                           All Rights Reserved                          ###
  ###                                                                      ###
   ##########################################################################
     ######################################################################


 Enter Internal Coordinate File Name :
```

## tinker_minrigid

### Tool Description
Tinker limited-memory BFGS energy minimization of rigid bodies; the rigid bodies are defined with GROUP keywords in the key file, and the minimized coordinates are written to a new version of the coordinate file (<name>.xyz_2).

### Metadata
- **Docker Image**: quay.io/biocontainers/tinker:8.11.3--h8d36177_0
- **Homepage**: https://dasher.wustl.edu/tinker/
- **Package**: https://anaconda.org/channels/bioconda/packages/tinker/overview
- **Validation**: PASS

### Original Help Text
```text

     ######################################################################
   ##########################################################################
  ###                                                                      ###
 ###            Tinker  ---  Software Tools for Molecular Design            ###
 ##                                                                          ##
 ##                        Version 8.11.3   June 2024                        ##
 ##                                                                          ##
 ##               Copyright (c)  Jay William Ponder  1990-2024               ##
 ###                           All Rights Reserved                          ###
  ###                                                                      ###
   ##########################################################################
     ######################################################################


 Enter Cartesian Coordinate File Name :
```

## tinker_mol2xyz

### Tool Description
Tinker conversion of a Tripos MOL2 structure to a Cartesian coordinate file (.xyz).

### Metadata
- **Docker Image**: quay.io/biocontainers/tinker:8.11.3--h8d36177_0
- **Homepage**: https://dasher.wustl.edu/tinker/
- **Package**: https://anaconda.org/channels/bioconda/packages/tinker/overview
- **Validation**: PASS

### Original Help Text
```text

     ######################################################################
   ##########################################################################
  ###                                                                      ###
 ###            Tinker  ---  Software Tools for Molecular Design            ###
 ##                                                                          ##
 ##                        Version 8.11.3   June 2024                        ##
 ##                                                                          ##
 ##               Copyright (c)  Jay William Ponder  1990-2024               ##
 ###                           All Rights Reserved                          ###
  ###                                                                      ###
   ##########################################################################
     ######################################################################


 Enter a Tripos MOL2 File Name :
```

## tinker_molxyz

### Tool Description
Tinker conversion of an MDL MOL (Molfile) structure to a Cartesian coordinate file (.xyz).

### Metadata
- **Docker Image**: quay.io/biocontainers/tinker:8.11.3--h8d36177_0
- **Homepage**: https://dasher.wustl.edu/tinker/
- **Package**: https://anaconda.org/channels/bioconda/packages/tinker/overview
- **Validation**: PASS

### Original Help Text
```text

     ######################################################################
   ##########################################################################
  ###                                                                      ###
 ###            Tinker  ---  Software Tools for Molecular Design            ###
 ##                                                                          ##
 ##                        Version 8.11.3   June 2024                        ##
 ##                                                                          ##
 ##               Copyright (c)  Jay William Ponder  1990-2024               ##
 ###                           All Rights Reserved                          ###
  ###                                                                      ###
   ##########################################################################
     ######################################################################


 Enter a MDL MOL File Name :
```

## tinker_monte

### Tool Description
Tinker Monte Carlo minimization (basin hopping) of a structure with Cartesian or torsional random moves; accepted minima are written to a trajectory archive (.arc).

### Metadata
- **Docker Image**: quay.io/biocontainers/tinker:8.11.3--h8d36177_0
- **Homepage**: https://dasher.wustl.edu/tinker/
- **Package**: https://anaconda.org/channels/bioconda/packages/tinker/overview
- **Validation**: PASS

### Original Help Text
```text

     ######################################################################
   ##########################################################################
  ###                                                                      ###
 ###            Tinker  ---  Software Tools for Molecular Design            ###
 ##                                                                          ##
 ##                        Version 8.11.3   June 2024                        ##
 ##                                                                          ##
 ##               Copyright (c)  Jay William Ponder  1990-2024               ##
 ###                           All Rights Reserved                          ###
  ###                                                                      ###
   ##########################################################################
     ######################################################################


 Enter Cartesian Coordinate File Name :
```

## tinker_newtrot

### Tool Description
Tinker truncated Newton energy minimization in torsional space (automatic, Newton, TNCG or DTNCG); reads a Z-matrix internal coordinate file (.int) and writes the minimized internal coordinates to a new version (<name>.int_2).

### Metadata
- **Docker Image**: quay.io/biocontainers/tinker:8.11.3--h8d36177_0
- **Homepage**: https://dasher.wustl.edu/tinker/
- **Package**: https://anaconda.org/channels/bioconda/packages/tinker/overview
- **Validation**: PASS

### Original Help Text
```text

     ######################################################################
   ##########################################################################
  ###                                                                      ###
 ###            Tinker  ---  Software Tools for Molecular Design            ###
 ##                                                                          ##
 ##                        Version 8.11.3   June 2024                        ##
 ##                                                                          ##
 ##               Copyright (c)  Jay William Ponder  1990-2024               ##
 ###                           All Rights Reserved                          ###
  ###                                                                      ###
   ##########################################################################
     ######################################################################


 Enter Internal Coordinate File Name :
```

## tinker_nucleic

### Tool Description
Tinker nucleic acid builder: builds the Cartesian and internal coordinates of a DNA or RNA strand or double helix (A-, B- or Z-form) from a nucleotide sequence; writes sequence (.seq), internal coordinate (.int) and Cartesian coordinate (.xyz) files.

### Metadata
- **Docker Image**: quay.io/biocontainers/tinker:8.11.3--h8d36177_0
- **Homepage**: https://dasher.wustl.edu/tinker/
- **Package**: https://anaconda.org/channels/bioconda/packages/tinker/overview
- **Validation**: PASS

### Original Help Text
```text

     ######################################################################
   ##########################################################################
  ###                                                                      ###
 ###            Tinker  ---  Software Tools for Molecular Design            ###
 ##                                                                          ##
 ##                        Version 8.11.3   June 2024                        ##
 ##                                                                          ##
 ##               Copyright (c)  Jay William Ponder  1990-2024               ##
 ###                           All Rights Reserved                          ###
  ###                                                                      ###
   ##########################################################################
     ######################################################################


 Enter Name to be Used for Output Files :
```

## tinker_optimize

### Tool Description
Tinker optimally conditioned variable metric energy minimization of a structure; the minimized coordinates are written to a new version of the coordinate file (<name>.xyz_2).

### Metadata
- **Docker Image**: quay.io/biocontainers/tinker:8.11.3--h8d36177_0
- **Homepage**: https://dasher.wustl.edu/tinker/
- **Package**: https://anaconda.org/channels/bioconda/packages/tinker/overview
- **Validation**: PASS

### Original Help Text
```text

     ######################################################################
   ##########################################################################
  ###                                                                      ###
 ###            Tinker  ---  Software Tools for Molecular Design            ###
 ##                                                                          ##
 ##                        Version 8.11.3   June 2024                        ##
 ##                                                                          ##
 ##               Copyright (c)  Jay William Ponder  1990-2024               ##
 ###                           All Rights Reserved                          ###
  ###                                                                      ###
   ##########################################################################
     ######################################################################


 Enter Cartesian Coordinate File Name :
```

## tinker_optirot

### Tool Description
Tinker optimally conditioned variable metric energy minimization in torsional space; reads a Z-matrix internal coordinate file (.int) and writes the minimized internal coordinates to a new version (<name>.int_2).

### Metadata
- **Docker Image**: quay.io/biocontainers/tinker:8.11.3--h8d36177_0
- **Homepage**: https://dasher.wustl.edu/tinker/
- **Package**: https://anaconda.org/channels/bioconda/packages/tinker/overview
- **Validation**: PASS

### Original Help Text
```text

     ######################################################################
   ##########################################################################
  ###                                                                      ###
 ###            Tinker  ---  Software Tools for Molecular Design            ###
 ##                                                                          ##
 ##                        Version 8.11.3   June 2024                        ##
 ##                                                                          ##
 ##               Copyright (c)  Jay William Ponder  1990-2024               ##
 ###                           All Rights Reserved                          ###
  ###                                                                      ###
   ##########################################################################
     ######################################################################


 Enter Internal Coordinate File Name :
```

## tinker_optrigid

### Tool Description
Tinker optimally conditioned variable metric energy minimization of rigid bodies; the rigid bodies are defined with GROUP keywords in the key file, and the minimized coordinates are written to a new version of the coordinate file (<name>.xyz_2).

### Metadata
- **Docker Image**: quay.io/biocontainers/tinker:8.11.3--h8d36177_0
- **Homepage**: https://dasher.wustl.edu/tinker/
- **Package**: https://anaconda.org/channels/bioconda/packages/tinker/overview
- **Validation**: PASS

### Original Help Text
```text

     ######################################################################
   ##########################################################################
  ###                                                                      ###
 ###            Tinker  ---  Software Tools for Molecular Design            ###
 ##                                                                          ##
 ##                        Version 8.11.3   June 2024                        ##
 ##                                                                          ##
 ##               Copyright (c)  Jay William Ponder  1990-2024               ##
 ###                           All Rights Reserved                          ###
  ###                                                                      ###
   ##########################################################################
     ######################################################################


 Enter Cartesian Coordinate File Name :
```

## tinker_path

### Tool Description
Tinker reaction path: finds a minimum energy path between a reactant and a product structure by a sequence of constrained optimizations of intermediate points; the path points are written to numbered files named after the product (<name>.001, ...).

### Metadata
- **Docker Image**: quay.io/biocontainers/tinker:8.11.3--h8d36177_0
- **Homepage**: https://dasher.wustl.edu/tinker/
- **Package**: https://anaconda.org/channels/bioconda/packages/tinker/overview
- **Validation**: PASS

### Original Help Text
```text

     ######################################################################
   ##########################################################################
  ###                                                                      ###
 ###            Tinker  ---  Software Tools for Molecular Design            ###
 ##                                                                          ##
 ##                        Version 8.11.3   June 2024                        ##
 ##                                                                          ##
 ##               Copyright (c)  Jay William Ponder  1990-2024               ##
 ###                           All Rights Reserved                          ###
  ###                                                                      ###
   ##########################################################################
     ######################################################################


 Enter Cartesian Coordinate File Name :
```

## tinker_polarize

### Tool Description
Tinker molecular polarizability: prints the additive and the interactive (induced dipole) polarizability tensor of a molecule from its atomic dipole polarizabilities.

### Metadata
- **Docker Image**: quay.io/biocontainers/tinker:8.11.3--h8d36177_0
- **Homepage**: https://dasher.wustl.edu/tinker/
- **Package**: https://anaconda.org/channels/bioconda/packages/tinker/overview
- **Validation**: PASS

### Original Help Text
```text

     ######################################################################
   ##########################################################################
  ###                                                                      ###
 ###            Tinker  ---  Software Tools for Molecular Design            ###
 ##                                                                          ##
 ##                        Version 8.11.3   June 2024                        ##
 ##                                                                          ##
 ##               Copyright (c)  Jay William Ponder  1990-2024               ##
 ###                           All Rights Reserved                          ###
  ###                                                                      ###
   ##########################################################################
     ######################################################################


 Enter Cartesian Coordinate File Name :
```

## tinker_poledit

### Tool Description
Tinker multipole editing utility: sets up atomic multipoles from quantum mechanical output, alters local coordinate frames, or removes the intramolecular polarization; writes a new coordinate file and a new key file with the multipole and polarization parameters.

### Metadata
- **Docker Image**: quay.io/biocontainers/tinker:8.11.3--h8d36177_0
- **Homepage**: https://dasher.wustl.edu/tinker/
- **Package**: https://anaconda.org/channels/bioconda/packages/tinker/overview
- **Validation**: PASS

### Original Help Text
```text

     ######################################################################
   ##########################################################################
  ###                                                                      ###
 ###            Tinker  ---  Software Tools for Molecular Design            ###
 ##                                                                          ##
 ##                        Version 8.11.3   June 2024                        ##
 ##                                                                          ##
 ##               Copyright (c)  Jay William Ponder  1990-2024               ##
 ###                           All Rights Reserved                          ###
  ###                                                                      ###
   ##########################################################################
     ######################################################################


 The Tinker Multipole Editing Utility Can :

    (1) Use Multipoles from Stone GDMA Output
    (2) Use Multipoles from Multiwfn MBIS Output
    (3) Alter Local Coordinate Frame Definitions
    (4) Remove the Intramolecular Polarization

 Enter the Number of the Desired Choice :
```

## tinker_potential

### Tool Description
Tinker electrostatic potential utility: creates grid points around a molecule, reads a quantum mechanical potential from a Gaussian CUBE file, calculates the model potential on a grid, compares potentials, or fits electrostatic parameters to a target grid.

### Metadata
- **Docker Image**: quay.io/biocontainers/tinker:8.11.3--h8d36177_0
- **Homepage**: https://dasher.wustl.edu/tinker/
- **Package**: https://anaconda.org/channels/bioconda/packages/tinker/overview
- **Validation**: PASS

### Original Help Text
```text

     ######################################################################
   ##########################################################################
  ###                                                                      ###
 ###            Tinker  ---  Software Tools for Molecular Design            ###
 ##                                                                          ##
 ##                        Version 8.11.3   June 2024                        ##
 ##                                                                          ##
 ##               Copyright (c)  Jay William Ponder  1990-2024               ##
 ###                           All Rights Reserved                          ###
  ###                                                                      ###
   ##########################################################################
     ######################################################################


 The Tinker Electrostatic Potential Utility Can :

    (1) Create Grid Points for Computing Potential
    (2) Get QM Potential from a Gaussian CUBE File
    (3) Calculate the Model Potential for a System
    (4) Compare Two Model Potentials for a System
    (5) Compare a Model Potential to a Target Grid
    (6) Fit Electrostatic Parameters to Target Grid

 Enter the Number of the Desired Choice :
```

## tinker_prmedit

### Tool Description
Tinker force field parameter editing facility: formats, reorders and renumbers the records of a parameter file, and sorts multipole or biotype parameters; writes parameter.prm, multipole.prm or biotype.prm.

### Metadata
- **Docker Image**: quay.io/biocontainers/tinker:8.11.3--h8d36177_0
- **Homepage**: https://dasher.wustl.edu/tinker/
- **Package**: https://anaconda.org/channels/bioconda/packages/tinker/overview
- **Validation**: PASS

### Original Help Text
```text

     ######################################################################
   ##########################################################################
  ###                                                                      ###
 ###            Tinker  ---  Software Tools for Molecular Design            ###
 ##                                                                          ##
 ##                        Version 8.11.3   June 2024                        ##
 ##                                                                          ##
 ##               Copyright (c)  Jay William Ponder  1990-2024               ##
 ###                           All Rights Reserved                          ###
  ###                                                                      ###
   ##########################################################################
     ######################################################################


 Enter Parameter File Name [<Enter>=NONE] :
```

## tinker_torsfit

### Tool Description
Tinker torsion parameter fitting: fits torsional force field parameters to relative quantum mechanical conformational energies from Gaussian output files.

### Metadata
- **Docker Image**: quay.io/biocontainers/tinker:8.11.3--h8d36177_0
- **Homepage**: https://dasher.wustl.edu/tinker/
- **Package**: https://anaconda.org/channels/bioconda/packages/tinker/overview
- **Validation**: PASS

### Original Help Text
```text

     ######################################################################
   ##########################################################################
  ###                                                                      ###
 ###            Tinker  ---  Software Tools for Molecular Design            ###
 ##                                                                          ##
 ##                        Version 8.11.3   June 2024                        ##
 ##                                                                          ##
 ##               Copyright (c)  Jay William Ponder  1990-2024               ##
 ###                           All Rights Reserved                          ###
  ###                                                                      ###
   ##########################################################################
     ######################################################################


 Enter Cartesian Coordinate File Name :
```

## tinker_valence

### Tool Description
Tinker valence parameter utility: sets initial valence force field parameters from quantum mechanical data, compares quantum and force field frequencies, or fits force or structure parameters to quantum results read from a Gaussian output file.

### Metadata
- **Docker Image**: quay.io/biocontainers/tinker:8.11.3--h8d36177_0
- **Homepage**: https://dasher.wustl.edu/tinker/
- **Package**: https://anaconda.org/channels/bioconda/packages/tinker/overview
- **Validation**: PASS

### Original Help Text
```text

     ######################################################################
   ##########################################################################
  ###                                                                      ###
 ###            Tinker  ---  Software Tools for Molecular Design            ###
 ##                                                                          ##
 ##                        Version 8.11.3   June 2024                        ##
 ##                                                                          ##
 ##               Copyright (c)  Jay William Ponder  1990-2024               ##
 ###                           All Rights Reserved                          ###
  ###                                                                      ###
   ##########################################################################
     ######################################################################


 The Tinker Valence Parameter Utility Can :

    (1) Set Initial Values for Valence Parameters
    (2) Compare QM and MM Vibrational Frequencies
    (3) Force Fit of Parameters to QM Results
    (4) Structure Fit of Parameters to QM Results

 Enter the Number of the Desired Choice :
```

## Metadata
- **Skill**: generated
