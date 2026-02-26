# dig2 CWL Generation Report

## dig2

### Tool Description
in silico digestion

### Metadata
- **Docker Image**: quay.io/biocontainers/dig2:1.0--h7b50bb2_7
- **Homepage**: http://www.ms-utils.org/dig2/dig2.html
- **Package**: https://anaconda.org/channels/bioconda/packages/dig2/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/dig2/overview
- **Total Downloads**: 7.4K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
dig2 - in silico digestion

based on dig (c) Magnus Palmblad, Division of Ion Physics, Uppsala University, Sweden, 2001, 2002.
Usage: dig <FASTA sequence database> <settings>

The <settings> file contain all parameters for the enzymatic, chemical or physical digestion/fragmentation.

For and example settings file with comments in <...>, see below:

cleave
aa side name
R C tryptic <trypsin cleaves on the C-terminal side of arginine (R)>
K C tryptic <and also on the C-terminal side of lysine (K)>
-----------------------------------------------------------------
max_missed min_length 
2 4 <allowing 2 missed cleavage sites and requiring at least 4 residues>
-----------------------------------------------------------------
do not cleave
aa side name
P N no_tryptic <trypsin does not cleave N-terminally of proline (P)>
-----------------------------------------------------------------
aa name always modification H C N O P S
C C yes 3 2 1 1 0 <fixed (always=yes) carbamidomethylation ("C", +H3C2NO) of cysteines (C)>
-----------------------------------------------------------------
protein_pI_low protein_pI_high protein_pI_measurement_error
6.9 6.9 0.75 <pI=6.9 with a standard uncertainty 0.75 weighing sequence scores>
-----------------------------------------------------------------
protein_mass_low protein_mass_high protein_mass_measurement_error
1000.0 8000.0 2.0 <only sequences in [1000.0 8000.0] are scored>
-----------------------------------------------------------------
aa retention_coefficient
A 3.977626
R 7.358114
N -14.245315
D -1.465423
C -1.334862
E 4.958673
Q 5.791402
G 10.440263
H -4.162102
I 18.251205
L 16.357631
K -3.632886
M 15.389976
F 14.806949
P 6.934921
S 5.458727
T 11.443512
W 7.696452
Y 10.250202
V 11.726216
O 48.52516 <offset, or t_zero>
-----------------------------------------------------------------

For further information, consult the dig2 manual.
```

