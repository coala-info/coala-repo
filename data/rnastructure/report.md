# rnastructure CWL Generation Report

## rnastructure_Fold

### Tool Description
Predicts the secondary structure of a nucleic acid sequence using the RNAstructure library.

### Metadata
- **Docker Image**: quay.io/biocontainers/rnastructure:6.5--hde5307d_0
- **Homepage**: http://rna.urmc.rochester.edu/RNAstructure.html
- **Package**: https://anaconda.org/channels/bioconda/packages/rnastructure/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/rnastructure/overview
- **Total Downloads**: 103.4K
- **Last updated**: 2026-02-12
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
USAGE: Fold <sequence file> <CT file> [options]
All flags are case-insensitive, and grouping of flags is not allowed.

=============================
==== Required Parameters ====
=============================
<sequence file>
    The name of a file containing an input sequence. Acceptable formats include
    SEQ, FASTA and raw-sequence plain-text files.
    If the name is a hyphen (-), the file will be read from standard input
    (STDIN).

<CT file>
    The name of a CT file to which output will be written. If the --bracket
    flag is present, output will be written as a dot-bracket file.
    If the file name is a hyphen (-), the structure will be written to standard
    output (STDOUT) instead of a file.

=========================================
==== Option Flags Without Parameters ====
=========================================
-d -D --DNA 
    Specify that the sequence is DNA, and DNA parameters are to be used.
    Default is to use RNA parameters.

--disablecoax 
    Specify that coaxial stacking recusions should not be used. This option
    uses a less realistic energy function in exchange for a faster
    calculation.

-h --help 
    Display the usage details message.

-i -I --isolated 
    Allow isolated base pairs.
    The default is to use a heuristic to forbid isolated base pairs.

-k --bracket 
    Write the predicted structure in dot-bracket notation (DBN) instead of CT
    format.

-mfe -MFE --MFE 
    Specify that only the minimum free energy structure is needed.
    No savefiles can be generated.
    This saves nearly half the calculation time, but provides less
    information.

-q --quiet 
    Suppress unnecessary output. This option is implied when the output file is
    '-' (STDOUT).

-v --version 
    Display version and copyright information for this interface.

-y -Y --simple_iloops 
    Specify that the O(N^3) internal loop search should be used. This speeds up
    the calculation if large internal loops are allowed using the -l option.

======================================
==== Option Flags With Parameters ====
======================================
All parameters must follow their associated flag directly.
Failure to do so may result in aberrant program behavior.

-a --alphabet 
    Specify the name of a folding alphabet and associated nearest neighbor
    parameters. The alphabet is the prefix for the thermodynamic parameter
    files, e.g. "rna" for RNA parameters or "dna" for DNA parameters or a
    custom extended/modified alphabet. The thermodynamic parameters need to
    reside in the at the location indicated by environment variable DATAPATH.
    The default is "rna" (i.e. use RNA parameters). This option overrides the
    --DNA flag.

-boot -B --bootstrap 
    Specify the number of bootstrap iterations to be done to retrieve base pair
    confidence.
    Defaults to no bootstrapping.

-c -C --constraint 
    Specify a constraints file to be applied.
    Default is to have no constraints applied.

-cmct -CMC --CMCT 
    Specify a CMCT constraints file to be applied. These constraints are
    pseudoenergy constraints.
    Default is to have no constraints applied.

-dms -DMS --DMS 
    Specify a DMS restraints file to be applied. These restraints are
    pseudoenergy constraints.
    Default is to have no restraints applied.

-dmsnt -DMSNT -DMSnt --DMSNT 
    Specify a DMS NT restraint file to be applied. These restraints are
    pseudoenergy constraints applied with NT-specific potentials.
    Default is to have no restraints applied.

-dsh -DSH --DSHAPE 
    Specify a differential SHAPE restraints file to be applied. These
    constraints are pseudoenergy restraints.
    Default is to have no restraints applied.

-dsm -DSM --DSHAPEslope 
    Specify a slope used with differential SHAPE restraints.
    Default is 2.11 kcal/mol.

-dso -DSO --doubleOffset 
    Specify a double-stranded offset file, which adds energy bonuses to
    particular double-stranded nucleotides.
    Default is to have no double-stranded offset specified.

-l -L --loop 
    Specify a maximum internal/bulge loop size.
    Default is 30 unpaired numcleotides.

-m -M --maximum 
    Specify a maximum number of structures.
    Default is 20 structures.

-md -MD --maxdistance 
    Specify a maximum pairing distance between nucleotides.
    Default is no restriction on distance between pairs.

--name 
    Specify a name for the sequence. This will override the name in the
    sequence file.

-p -P --percent 
    Specify a maximum percent energy difference.
    Default is 10 percent (specified as 10, not 0.1).

-s -S --save 
    Specify the name of a save file, needed for dotplots and refolding.
    Default is not to generate a save file.

-sh -SH --SHAPE 
    Specify a SHAPE restraints file to be applied. These constraints are
    pseudoenergy restraints.
    Default is to have no restraints applied.

-si -SI --SHAPEintercept 
    Specify an intercept used with SHAPE restraints.
    Default is -0.6 kcal/mol.

-sm -SM --SHAPEslope 
    Specify a slope used with SHAPE renstraints.
    Default is 1.8 kcal/mol.

-sso -SSO --singleOffset 
    Specify a single-stranded offset file, which adds energy bonuses to
    particular single-stranded nucleotides.
    Default is to have no single-stranded offset specified.

-t -T --temperature 
    Specify the temperature at which calculation takes place in Kelvin.
    Default is 310.15 K, which is 37 degrees C.

-usi -USI --unpairedSHAPEintercept 
    Specify an intercept used with unpaired SHAPE constraints.
    Default is 0 kcal/mol.

-usm -USM --unpairedSHAPEslope 
    Specify a slope used with unpaired SHAPE constraints.
    Default is 0 kcal/mol.

-w -W --window 
    Specify a window size.
    Default is determined by the length of the sequence.

--warnings --warn 
    Set the behavior for non-critical warnings (e.g. related to invalid
    nucleotide positions or duplicate data points in SHAPE data). Valid values
    are: 
      * on  -- Warnings are written to standard output. (default)
      * err -- Warnings are sent to STDERR. This can be used in automated scripts
        etc to detect problems.
      * off -- Do not display warnings at all (not recommended).

-x -X --experimentalPairBonus 
    Input text file with bonuses (in kcal) as a matrix. As with SHAPE, bonuses
    will be applied twice to internal base pairs, once to edge base pairs, and
    not at all to single stranded regions.
    Default is no experimental pair bonus file specified.

-xo 
    Specify an intercept (overall offset) to use with the 2D experimental pair
    bonus file.
    Default is 0.0 (no change to input bonuses).

-xs 
    Specify a number to multiply the experimental pair bonus matrix by.
    Default is 1.0 (no change to input bonuses).
```


## rnastructure_partition

### Tool Description
Partition function calculation for RNA/DNA sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/rnastructure:6.5--hde5307d_0
- **Homepage**: http://rna.urmc.rochester.edu/RNAstructure.html
- **Package**: https://anaconda.org/channels/bioconda/packages/rnastructure/overview
- **Validation**: PASS

### Original Help Text
```text
USAGE: partition <sequence file> <pfs file> [options]
All flags are case-insensitive, and grouping of flags is not allowed.

=============================
==== Required Parameters ====
=============================
<sequence file>
    The name of a file containing an input sequence. Acceptable formats include
    SEQ, FASTA and raw-sequence plain-text files.
    If the name is a hyphen (-), the file will be read from standard input
    (STDIN).

<pfs file>
    The name of a partition function save file (PFS) to which output will be
    written.

=========================================
==== Option Flags Without Parameters ====
=========================================
-d -D --DNA 
    Specify that the sequence is DNA, and DNA parameters are to be used.
    Default is to use RNA parameters.

--disablecoax 
    Specify that coaxial stacking recusions should not be used. This option
    uses a less realistic energy function in exchange for a faster
    calculation.

-h --help 
    Display the usage details message.

-i --isolated 
    Specify that isolated pairs are allowed.
    The default is to use a heuristic to attempt to forbid isolated pairs
    during structure prediction.

-q --quiet 
    Suppress progress display and other unnecessary output.

-v --version 
    Display version and copyright information for this interface.

======================================
==== Option Flags With Parameters ====
======================================
All parameters must follow their associated flag directly.
Failure to do so may result in aberrant program behavior.

-a --alphabet 
    Specify the name of a folding alphabet and associated nearest neighbor
    parameters. The alphabet is the prefix for the thermodynamic parameter
    files, e.g. "rna" for RNA parameters or "dna" for DNA parameters or a
    custom extended/modified alphabet. The thermodynamic parameters need to
    reside in the at the location indicated by environment variable DATAPATH.
    The default is "rna" (i.e. use RNA parameters). This option overrides the
    --DNA flag.

-c -C --constraint 
    Specify a constraints file to be applied.
    Default is to have no constraints applied.

-dso -DSO --doubleOffset 
    Specify a double-stranded offset file, which adds energy bonuses to
    particular double-stranded nucleotides.
    Default is to have no double-stranded offset specified.

-md -MD --maxdistance 
    Specify a maximum pairing distance between nucleotides.
    Default is no restriction on distance between pairs.

-sh -SH --SHAPE 
    Specify a SHAPE constraints file to be applied. These constraints are
    pseudoenergy constraints.
    Default is to have no constraints applied.

-si -SI --SHAPEintercept 
    Specify an intercept used with SHAPE constraints.
    Default is -0.6 kcal/mol.

-sm -SM --SHAPEslope 
    Specify a slope used with SHAPE constraints.
    Default is 1.8 kcal/mol.

-t -T --temperature 
    Specify the temperature at which calculation takes place in Kelvin.
    Default is 310.15 K, which is 37 degrees C.

-x -X --experimentalPairBonus 
    Input text file with bonuses (in kcal) as a matrix. As with SHAPE, bonuses
    will be applied twice to internal base pairs, once to edge base pairs, and
    not at all to single stranded regions.
    Default is no experimental pair bonus file specified.

-xo 
    Specify an intercept (overall offset) to use with the 2D experimental pair
    bonus file.
    Default is 0.0 (no change to input bonuses).

-xs 
    Specify a number to multiply the experimental pair bonus matrix by.
    Default is 1.0 (no change to input bonuses).
```


## rnastructure_ProbabilityPlot

### Tool Description
Generates plots from base pairing probability data.

### Metadata
- **Docker Image**: quay.io/biocontainers/rnastructure:6.5--hde5307d_0
- **Homepage**: http://rna.urmc.rochester.edu/RNAstructure.html
- **Package**: https://anaconda.org/channels/bioconda/packages/rnastructure/overview
- **Validation**: PASS

### Original Help Text
```text
USAGE: ProbabilityPlot <input file> <output file> [options]
All flags are case-insensitive, and grouping of flags is not allowed.

=============================
==== Required Parameters ====
=============================
<input file>
    The name of the input file that holds base pairing probabilities. This file
    may be one of the following file types. 1) Partition function save file
    (binary file). 2) Matrix file (plain text). Note that in order to use a
    matrix file, the "--matrix" flag must be specified. 3) Dot plot file (plain
    text). This file is in the standard format exported by all dot plot
    interfaces when the "text" option is used. Note that in order to use a dot
    plot file, the "--log10" flag must be specified.

<output file>
    The name of a file to which output will be written. Depending on the
    options selected, this may be one of the following file types. 1) A
    Postscript image file. 2) An SVG image file. 3) A plain text file.

=========================================
==== Option Flags Without Parameters ====
=========================================
-h --help 
    Display the usage details message.

--log10 
    Specifies that the input file format is a dot plot text file of log10 base
    pair probabilities. Giving this flag with one of the text options would
    give a file identical to the input file.

--matrix 
    Specifies that the input file format is a plain text matrix of base pair
    probabilities.

--svg 
    Specify that the output file should be an SVG image file, rather than a
    Postscript image file.

-t -T --text 
    Specifies that output should be a dot plot (text) file.

-v --version 
    Display version and copyright information for this interface.

======================================
==== Option Flags With Parameters ====
======================================
All parameters must follow their associated flag directly.
Failure to do so may result in aberrant program behavior.

--desc 
    Configure the output of descriptions. Valid values are: (1) "" or "~none"
    -- Do not write a description (2) "~file" -- If the default description
    corresponds to a file or path, use only the base name of the path (i.e. no
    directory or file extension). (3) "~~" or "~default" -- Use the default
    description (this is the same as not specifying the flag) (4)
    "~list|DESC1|DESC2|DESC3" -- use this syntax when the output is expected to
    have more than one plot. It specifies a list of descriptions will be
    applied in the order given. The character immediately after "~list" will be
    used as the separator (i.e. it need not be the bar (|) character. (5) Any
    other value is assumed to be the literal description you want to have
    displayed in the plot legend.

-e -E --entries 
    Specifies the number of colors in the dot plot.
    Default is 5 colors. Minimum is 3 colors. Maximum is 15 colors.

-max -MAX --maximum 
    Specifies the maximum value that is viewable in the plot.
    Default is the largest allowable point in a given data file. If the given
    value is greater than the default, it is ignored.

-min -MIN --minimum 
    Specifies the minimum value that is viewable in the plot.
    Default is the smallest allowable point in a given data file. If the given
    value is less than the default, it is ignored.
```


## rnastructure_bifold

### Tool Description
Calculates the secondary structure of two RNA or DNA sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/rnastructure:6.5--hde5307d_0
- **Homepage**: http://rna.urmc.rochester.edu/RNAstructure.html
- **Package**: https://anaconda.org/channels/bioconda/packages/rnastructure/overview
- **Validation**: PASS

### Original Help Text
```text
USAGE: bifold <seq file 1> <seq file 2> <ct file> [options]
All flags are case-insensitive, and grouping of flags is not allowed.

=============================
==== Required Parameters ====
=============================
<seq file 1>
    The name of a file containing a first input sequence.

<seq file 2>
    The name of a file containing a second input sequence.

<ct file>
    The name of a CT file to which output will be written.

=========================================
==== Option Flags Without Parameters ====
=========================================
-d -D --DNA 
    Specify that the sequence is DNA, and DNA parameters are to be used.
    Default is to use RNA parameters.

-h --help 
    Display the usage details message.

-i -I --intramolecular 
    Forbid intramolecular pairs (pairs within the same strand).
    Default is to allow intramolecular pairs.

--list 
    Specify that the input is a list, rather than two sequences.

-v --version 
    Display version and copyright information for this interface.

======================================
==== Option Flags With Parameters ====
======================================
All parameters must follow their associated flag directly.
Failure to do so may result in aberrant program behavior.

-a --alphabet 
    Specify the name of a folding alphabet and associated nearest neighbor
    parameters. The alphabet is the prefix for the thermodynamic parameter
    files, e.g. "rna" for RNA parameters or "dna" for DNA parameters or a
    custom extended/modified alphabet. The thermodynamic parameters need to
    reside in the at the location indicated by environment variable DATAPATH.
    The default is "rna" (i.e. use RNA parameters). This option overrides the
    --DNA flag.

-l -L --loop 
    Specify a maximum internal/bulge loop size.
    Default is 30 unpaired numcleotides.

-m -M --maximum 
    Specify a maximum number of structures.
    Default is 20 structures.

-p -P --percent 
    Specify a maximum percent energy difference.
    Default is 10 percent (specified as 10, not 0.1).

-s -S --save 
    Specify the name of a save file, needed for dotplots and refolding.
    Default is not to generate a save file.

-t -T --temperature 
    Specify the temperature at which calculation takes place in Kelvin.
    Default is 310.15 K, which is 37 degrees C.

-w -W --window 
    Specify a window size.
    Default is 0 nucleotides.
```


## rnastructure_ct2dot

### Tool Description
Convert a CT structure file to dot-bracket format.

### Metadata
- **Docker Image**: quay.io/biocontainers/rnastructure:6.5--hde5307d_0
- **Homepage**: http://rna.urmc.rochester.edu/RNAstructure.html
- **Package**: https://anaconda.org/channels/bioconda/packages/rnastructure/overview
- **Validation**: PASS

### Original Help Text
```text
USAGE: ct2dot <ct file> <structure number> <bracket file> [options]
All flags are case-insensitive, and grouping of flags is not allowed.

=============================
==== Required Parameters ====
=============================
<ct file>
    The name of a file containing the CT structure to convert.
    If the name is a hyphen (-) the file will be read from standard input
    (STDIN).

<structure number>
    The number, one-indexed, of the structure to convert in the CT file (use -1
    or "ALL" to convert all structures).

<bracket file>
    The name of a dot bracket file to which output will be written.
    If the name is a hyphen (-), the converted file will be written to standard
    output (STDOUT) instead of a file.

=========================================
==== Option Flags Without Parameters ====
=========================================
-h --help 
    Display the usage details message.

-q --quiet 
    Suppress unnecessary output. This option is implied when the output file is
    '-' (STDOUT).

-v --version 
    Display version and copyright information for this interface.

======================================
==== Option Flags With Parameters ====
======================================
All parameters must follow their associated flag directly.
Failure to do so may result in aberrant program behavior.

-f --format 
    A number or name that indicates how subsequent sub-structures are formatted
    (relevant only when more than one structure is being written).
    Valid values are:
      (1) simple -- Susbequent structures (after the first one) are written with
        a Structure-Line  '(((....)))' only -- (no title or sequence)
      (2) side   -- A structure label is appended to the right side of each
        Structure-Line e.g. '(((....)))  ENERGY= -3.6  E.coli'.
      (3) multi  -- Susbequent structures are each written with a Title-Line
        '>TITLE' followed by a Structure-Line.
      (4) full   -- All structures written with a full header, including a
        '>TITLE' line followed by a Sequence-Line and then a Structure-Line.
    The default is 'multi'.
```


## Metadata
- **Skill**: generated
