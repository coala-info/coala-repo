# pcasuite CWL Generation Report

## pcasuite

### Tool Description
FAIL to generate CWL: pcasuite not found in Singularity image. The image may not provide this executable.

### Metadata
- **Docker Image**: quay.io/biocontainers/pcasuite:1.0.0--h7baada4_6
- **Homepage**: https://mmb.irbbarcelona.org/gitlab/andrio/pcasuite
- **Package**: https://anaconda.org/channels/bioconda/packages/pcasuite/overview
- **Validation**: FAIL (generation failed)

- **Conda**: https://anaconda.org/channels/bioconda/packages/pcasuite/overview
- **Total Downloads**: 3.6K
- **Last updated**: 2025-09-18
- **GitHub**: N/A
- **Stars**: N/A
### Generation Failed

FAIL to generate CWL: pcasuite not found in Singularity image. The image may not provide this executable.


### Validation Errors

- FAIL to generate CWL: pcasuite not found in Singularity image. The image may not provide this executable.



### Original Help Text
```text

```


## Metadata
- **Skill**: generated

## pcasuite_pcazip

### Tool Description
Compresses amber format trajectory files using Principal Component Analysis (PCA).

### Metadata
- **Docker Image**: quay.io/biocontainers/pcasuite:1.0.0--h7baada4_6
- **Homepage**: https://mmb.irbbarcelona.org/gitlab/andrio/pcasuite
- **Package**: https://anaconda.org/channels/bioconda/packages/pcasuite/overview
- **Validation**: PASS
### Original Help Text
```text
Usage:
pcazip -i infile -o outfile -n natoms
     [-v] [--mask maskfile] [-e nev] [-q qual] [--pdb pdbfile]
Details:
-i infile   | amber format trajectory input file
-o outfile  | compressed output file
-n natoms   | number of atoms in a snapshot
-v          | verbose diagnostics
-m mfile    | pdb format mask file - only atoms in this file
            | will be included in the compression. Atom
            | numbers (2nd field) must be correct!
-M string   | ptraj-like format mask
-e nev      | Include nev eigenvectors.
-q qual     | Include enough eigenvectors to capture qual%
            | (1<=qual<=99) of the total variance
-g          | Use a gaussian RMSd for fitting
-p          | Use a PDB file for atom number and name extraction
-h          | Shows this help
Note: in the absence of any -q or -e option, default is to
      include enough eiegnevectors to capture 90% of variance
```

## pcasuite_pcaunzip

### Tool Description
Decompress PCA data from a file

### Metadata
- **Docker Image**: quay.io/biocontainers/pcasuite:1.0.0--h7baada4_6
- **Homepage**: https://mmb.irbbarcelona.org/gitlab/andrio/pcasuite
- **Package**: https://anaconda.org/channels/bioconda/packages/pcasuite/overview
- **Validation**: PASS
### Original Help Text
```text
Usage:
pcaunzip -i infile [-o outfile] [--pdb] [--verbose] [--help]
```

## pcasuite_pczdump

### Tool Description
Extract information and perform calculations on PCZ files

### Metadata
- **Docker Image**: quay.io/biocontainers/pcasuite:1.0.0--h7baada4_6
- **Homepage**: https://mmb.irbbarcelona.org/gitlab/andrio/pcasuite
- **Package**: https://anaconda.org/channels/bioconda/packages/pcasuite/overview
- **Validation**: PASS
### Original Help Text
```text
Usage:
pczdump -i infile [-o outfile]
	--info           : Show general information about the file
	--avg            : Show the average structure
	--evals          : Show the eigenvalues
	--evec iv        : Show the <iv> eigenvector
	--proj iv        : Show the projections for <iv> eigenvector
	--rms iref       : Compute the RMS of the traj. against frame <iref>
	--fluc iv        : Compute atomic fluctuations for <iv> evec (0 for all)
	--bfactor        : Give the fluctuation values as B-factors
	--anim iv        : Animate the average structure along <iv> eigenvector
	--lindemann      : Compute Lindemann coefficient
	--collectivity iv: Compute a collectivity coefficient for <iv> evec
	--forcecte temp  : Compute force constants for temperature <temp>
	--hinge          : Look for hinge points (need a file with atom names
	                   and gaussian RMS applied
	--mahref         : Trajectory file to use in the Mahalanobis distance
	                   calculus
	--mahnev         : Number of eigenvectors to use in the Mahalanobis
	                   distance calculus
	--mask <mask>    : ptraj-like selection mask
	--pdb            : Ask for output in PDB format (if suitable)
	--verbose        : Show info about progress
	--help           : Show this message
```

