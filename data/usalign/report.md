# usalign CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| usalign_HwRMSD | PASS | alignment and matrix output correct; the -o option crashes with a segmentation fault |
| usalign_MMalign | PASS |  |
| usalign_NWalign | PASS |  |
| usalign_TMalign | PASS |  |
| usalign_TMscore | PASS |  |
| usalign_USalign | PASS |  |
| usalign_addChainID | PASS |  |
| usalign_cif2pdb | PASS |  |
| usalign_pdb2fasta | PASS |  |
| usalign_pdb2ss | PASS |  |
| usalign_pdb2xyz | PASS |  |
| usalign_pdbAtomName | PASS |  |
| usalign_qTMclust | PASS |  |
| usalign_se | PASS |  |
| usalign_xyz_sfetch | PASS |  |

## usalign_USalign

### Tool Description
Universal Structure Alignment of Proteins and Nucleic Acids

### Metadata
- **Docker Image**: quay.io/biocontainers/usalign:20241201--h503566f_0
- **Homepage**: https://zhanggroup.org/US-align
- **Package**: https://anaconda.org/channels/bioconda/packages/usalign/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/usalign/overview
- **Total Downloads**: 9.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/pylelab/USalign
- **Stars**: N/A
### Original Help Text
```text
********************************************************************
 * US-align (Version 20241108)                                      *
 * Universal Structure Alignment of Proteins and Nucleic Acids      *
 * Reference: C Zhang, M Shine, AM Pyle, Y Zhang. (2022) Nat Methods*
 *            C Zhang, AM Pyle (2022) iScience.                     *
 * Please email comments and suggestions to zhang@zhanggroup.org    *
 ********************************************************************

Usage: USalign PDB1.pdb PDB2.pdb [Options]

Options:
    -mol  Type of molecule(s) to align.
          auto: (default) align both protein and nucleic acids.
          prot: only align proteins in a structure.
          RNA : only align RNA and DNA in a structure.

     -mm  Multimeric alignment option:
          0: (default) alignment of two monomeric structures
          1: alignment of two multi-chain oligomeric structures
          2: alignment of individual chains to an oligomeric structure
             $ USalign -dir1 monomers/ list oligomer.pdb -ter 0 -mm 2
          3: alignment of circularly permuted structure
          4: MSTA, i.e., alignment of multiple monomeric chains into a
             consensus alignment
             $ USalign -dir chains/ list -suffix .pdb -mm 4
          5: fully non-sequential (fNS) alignment
          6: semi-non-sequential (sNS) alignment
          To use -mm 1 or -mm 2, '-ter' option must be 0 or 1.

    -ter  Number of chains to align.
          0: align all chains from all models (recommended for aligning
             biological assemblies, i.e. biounits)
          1: align all chains of the first model (recommended for aligning
             asymmetric units, default for -mm 1,2 and -TMscore 2,6,7)
          2: (default for other cases) only align the first chain
          3: only align the first chain, or the first segment of the
             first chain as marked by the 'TER' string in PDB file

 -TMscore Whether to perform TM-score superposition without structure-based
          alignment. The same as -byresi.
          0: (default) sequence independent structure alignment
          1: superpose two structures by assuming that a pair of residues
             with the same residue index are equivalent between the two
             structures
          2: superpose two complex structures, assuming that a pair of
             residues with the same residue index and the same chain ID
             are equivalent between the two structures
          5: sequence dependent alignment: perform glocal sequence
             alignment followed by TM-score superposition.
             -byresi 5 is the same as -seq
          6: superpose two complex structures by first deriving optimal
             chain mapping, followed by TM-score superposition for residues
             with the same residue ID
          7: sequence dependent alignment of two complex structures:
             perform global sequence alignment of each chain pair, derive
             optimal chain mapping, and then superpose two complex
             structures by TM-score

      -I  Use the final alignment specified by FASTA file 'align.txt'

      -i  Use alignment specified by 'align.txt' as an initial alignment

      -m  Output rotation matrix for superposition, e.g., '-m matrix.txt'
          prints the matrix to 'matrix.txt'; '-m -' prints to stdout.

      -d  TM-score scaled by an assigned d0, e.g., '-d 3.5' reports MaxSub
          score, where d0 is 3.5 Angstrom. -d does not change final alignment.

      -u  TM-score normalized by an assigned length. It should be >= length
          of protein to avoid TM-score >1. -u does not change final alignment.

      -o  Output superposed structure1 to sup.* for PyMOL viewing.
          $ USalign structure1.pdb structure2.pdb -o sup
          $ pymol -d @sup.pml                # C-alpha trace aligned region
          $ pymol -d @sup_all.pml            # C-alpha trace whole chain
          $ pymol -d @sup_atm.pml            # full-atom aligned region
          $ pymol -d @sup_all_atm.pml        # full-atom whole chain
          $ pymol -d @sup_all_atm_lig.pml    # full-atom with all molecules

 -rasmol  Output superposed structure1 to sup.* for RasMol viewing.
          $ USalign structure1.pdb structure2.pdb -rasmol sup
          $ rasmol -script sup               # C-alpha trace aligned region
          $ rasmol -script sup_all           # C-alpha trace whole chain
          $ rasmol -script sup_atm           # full-atom aligned region
          $ rasmol -script sup_all_atm       # full-atom whole chain
          $ rasmol -script sup_all_atm_lig   # full-atom with all molecules

-chimerax Output superposed structure1 to sup.* for ChimeraX viewing.
          $ USalign structure1.pdb structure2.pdb -chimerax sup
          $ chimerax --script sup.cxc             # C-alpha trace aligned region
          $ chimerax --script sup_all.cxc         # C-alpha trace whole chain
          $ chimerax --script sup_atm.cxc         # full-atom aligned region
          $ chimerax --script sup_all_atm.cxc     # full-atom whole chain
          $ chimerax --script sup_all_atm_lig.cxc # full-atom with all molecules

     -do  Output distance of aligned residue pairs

Example usages ('gunzip' program is needed to read .gz compressed files):
    USalign 101m.cif.gz 1mba.pdb             # pairwise monomeric protein alignment
    USalign 1qf6.cif 5yyn.pdb.gz -mol RNA    # pairwise monomeric RNA alignment
    USalign model.pdb native.pdb -TMscore 1  # calculate TM-score between two conformations of a monomer
    USalign 4v4a.cif 4v49.cif -mm 1 -ter 1   # oligomeric alignment for asymmetic units
    USalign 3ksc.pdb1 4lej.pdb1 -mm 1 -ter 0 # oligomeric alignment for biological units
    USalign 1ajk.pdb.gz 2ayh.pdb.gz -mm 3    # circular permutation alignment

Additional options:
      -v  Print the version of US-align

      -a  TM-score normalized by the average length of two structures
          T or F, (default F). -a does not change the final alignment.

   -fast  Fast but slightly inaccurate alignment

    -dir  Perform all-against-all alignment among the list of PDB
          chains listed by 'chain_list' under 'chain_folder'.
          $ USalign -dir chain_folder/ chain_list

   -dir1  Use chain2 to search a list of PDB chains listed by 'chain1_list'
          under 'chain1_folder'.
          $ USalign -dir1 chain1_folder/ chain1_list chain2

   -dir2  Use chain1 to search a list of PDB chains listed by 'chain2_list'
          under 'chain2_folder'
          $ USalign chain1 -dir2 chain2_folder/ chain2_list

 -suffix  (Only when -dir1 and/or -dir2 are set, default is empty)
          add file name suffix to files listed by chain1_list or chain2_list

   -atom  4-character atom name used to represent a residue.
          Default is " C3'" for RNA/DNA and " CA " for proteins
          (note the spaces before and after CA).

  -split  Whether to split PDB file into multiple chains
           0: treat the whole structure as one single chain
              (default for -TMscore 2)
           1: treat each MODEL as a separate chain
           2: (default for other cases) treat each chain as a separate chain

 -outfmt  Output format
           0: (default) full output
           1: fasta format compact output
           2: tabular format very compact output
          -1: full output, but without version or citation information

  -TMcut  -1: (default) do not consider TMcut
          Values in [0.5,1): Do not proceed with TM-align for this
          structure pair if TM-score is unlikely to reach TMcut.
          TMcut is normalized as set by -a option:
          -2: normalized by longer structure length
          -1: normalized by shorter structure length
           0: (default, same as F) normalized by second structure
           1: same as T, normalized by average structure length

 -mirror  Whether to align the mirror image of input structure
           0: (default) do not align mirrored structure
           1: align mirror of Structure_1 to origin Structure_2,
              which usually requires the '-het 1' option:
              $ USalign 4glu.pdb 3p9w.pdb -mirror 1 -het 1

    -het  Whether to align residues marked as 'HETATM' in addition to 'ATOM  '
           0: (default) only align 'ATOM  ' residues
           1: align both 'ATOM  ' and 'HETATM' residues
           2: align both 'ATOM  ' and MSE residues

   -full  Whether to show full pairwise alignment of individual chains for
          -mm 2 or 4. T or F, (default F)

   -se    Do not perform superposition. Useful for extracting alignment from
          superposed structure pairs

 -infmt1  Input format for structure_1
 -infmt2  Input format for structure_2
          -1: (default) automatically detect PDB or PDBx/mmCIF format
           0: PDB format
           1: SPICKER format
           3: PDBx/mmCIF format

-chainmap (only useful for -mm 1) use the final chain mapping 'chainmap.txt'
          specified by user. 'chainmap.txt' is a tab-seperated text with two
          columns, one for each complex

-chain1   Chains to parse in structure_1
-chain2   Chains to parse in structure_2. Use _ for a chain without chain ID.
          Multiple chains can be separated by commas, e.g.,
          USalign -chain1 C,D,E,F 5jdo.pdb -chain2 A,B,C,D 3wtg.pdb -ter 0

-model1   Models to parse in structure_1
-model2   Models to parse in structure_2.
          Multiple models can be separated by commas, e.g.,
          USalign -model1 1,2 1a03.pdb -model2 3,4 1a0n.pdb -ter 0

Advanced usage 1 (generate an image for a pair of superposed structures):
    USalign 1cpc.pdb 1mba.pdb -o sup
    pymol -c -d @sup_all_atm.pml -g sup_all_atm.png

Advanced usage 2 (a quick search of query.pdb against I-TASSER PDB library):
    wget https://zhanggroup.org/library/PDB.tar.bz2
    tar -xjvf PDB.tar.bz2
    USalign query.pdb -dir2 PDB/ PDB/list -suffix .pdb -outfmt 2 -fast
```

## usalign_pdb2ss

### Tool Description
Converting PDB file(s) into FASTA format secondary structure sequence.

### Metadata
- **Docker Image**: quay.io/biocontainers/usalign:20241201--h503566f_0
- **Homepage**: https://zhanggroup.org/US-align
- **Package**: https://anaconda.org/channels/bioconda/packages/usalign/overview
- **Validation**: PASS

### Original Help Text
```text
Converting PDB file(s) into FASTA format secondary structure sequence.
Proteins have four states: H E C T (helix, strand, coil, turn)
RNA have three states: < > . (paired with 3', paired with 5', unpaired)

Usage: pdb2ss pdb.pdb > seq.ss

    -dir     Convert all chains listed by 'chain_list' under 'chain_folder'.
             Note that the slash is necessary.
             $ pdb2xyz -dir chain_folder/ chain_list

    -suffix  (Only when -dir is set, default is empty)
             add file name suffix to files listed by chain_list

    -atom    4-character atom name used to represent a residue.
             Default is " C3'" for RNA/DNA and " CA " for proteins
             (note the spaces before and after CA).

    -mol     Molecule type: RNA or protein
             Default is detect molecule type automatically

    -ter     Strings to mark the end of a chain
             3: (default) TER, ENDMDL, END or different chain ID
             2: ENDMDL, END, or different chain ID
             1: ENDMDL or END
             0: end of file

    -split   Whether to split PDB file into multiple chains
             0: (default) treat the whole structure as one single chain
             1: treat each MODEL as a separate chain (-ter should be 0)
             2: treat each chain as a seperate chain (-ter should be <=1)

    -infmt   Input format for chain
            -1: (default) automatically detect PDB or PDBx/mmCIF format
             0: PDB format
             2: xyz format
             3: PDBx/mmCIF format
    -het     Whether to read residues marked as 'HETATM' in addition to 'ATOM  '
             0: (default) only align 'ATOM  ' residues
             1: align both 'ATOM  ' and 'HETATM' residues
```

## usalign_MMalign

### Tool Description
MM-align: structural alignment of multi-chain protein complexes.

### Metadata
- **Docker Image**: quay.io/biocontainers/usalign:20241201--h503566f_0
- **Homepage**: https://zhanggroup.org/US-align
- **Package**: https://anaconda.org/channels/bioconda/packages/usalign/overview
- **Validation**: PASS

### Original Help Text
```text
**********************************************************************
 * MM-align (Version 20231222): complex structure alignment           *
 * References: S Mukherjee, Y Zhang. Nucl Acids Res 37(11):e83 (2009) *
 * Please email comments and suggestions to yangzhanglab@umich.edu    *
 **********************************************************************

Usage: MMalign complex1.pdb complex2.pdb [Options]

Options:
    -a    TM-score normalized by the average length of two structures
          T or F, (default F)

    -m    Output MM-align rotation matrix

    -d    TM-score scaled by an assigned d0, e.g. 5 Angstroms

    -o    Output the superposition of complex1.pdb to MM_sup.pdb
          $ MMalign complex1.pdb complex2.pdb -o MM_sup.pdb
          To view superposed full-atom structures:
          $ pymol MM_sup.pdb complex2.pdb

    -full Whether to show full alignment result, including alignment of
          individual chains. T or F, (default F)

    -ter  Whether to read all MODELs in a multi-model structure file
          1: (default) only read the first model, recommended for alignment
             of asymetric units.
          0: read all MODEL, recomended for alignment of biological
             assemblies, i.e., biological units (biounits).

    -v    Print the version of MM-align

    -h    Print the full help message

    (Options -a, -d, -m, -o won't change the final structure alignment)

Example usages:
    MMalign complex1.pdb complex2.pdb
    MMalign complex1.pdb complex2.pdb -d 5.0
    MMalign complex1.pdb complex2.pdb -a T -o complex1.sup
    MMalign complex1.pdb complex2.pdb -m matrix.txt

Additional options:
    -fast    Fast but slightly inaccurate alignment

    -dir1    Use a list of PDB chains listed by 'chain1_list' under
             'chain1_folder' as all chains for the first complex.
             Note that the slash is necessary.
             $ MMalign -dir1 chain1_folder/ chain1_list complex2

    -dir2    Use a list of PDB chains listed by'chain2_list'
             under 'chain2_folder' as all chains for the second complex.
             $ MMalign complex1 -dir2 chain2_folder/ chain2_list

    -suffix  (Only when -dir1 and/or -dir2 are set, default is empty)
             add file name suffix to files listed by chain1_list or chain2_list

    -atom    4-character atom name used to represent a residue.
             Default is " C3'" for RNA/DNA and " CA " for proteins
             (note the spaces before and after CA).

    -mol     Types of molecules to align
Molecule type: RNA or protein
             auto   : (default) align both proteins and nucleic acids
             protein: only align proteins
             RNA    : only align nucleic acids (RNA and DNA)

    -split   Whether to split PDB file into multiple chains
             2: (default) treat each chain as a seperate chain (-ter should be <=1)
             1: treat each MODEL as a separate chain (-ter should be 0)
                and joins all chains in a MODEL into a single chain.

    -outfmt  Output format
             0: (default) full output
             1: fasta format compact output
             2: tabular format very compact output
            -1: full output, but without version or citation information

    -TMcut   -1: (default) do not consider TMcut
             Values in [0.5,1): Do not proceed with TM-align for this
                 structure pair if TM-score is unlikely to reach TMcut.
                 TMcut is normalized is set by -a option:
                 -2: normalized by longer structure length
                 -1: normalized by shorter structure length
                  0: (default, same as F) normalized by second structure
                  1: same as T, normalized by average structure length

    -mirror  Whether to align the mirror image of input structure
             0: (default) do not align mirrored structure
             1: align mirror of chain1 to origin chain2

    -het     Whether to align residues marked as 'HETATM' in addition to 'ATOM  '
             0: (default) only align 'ATOM  ' residues
             1: align both 'ATOM  ' and 'HETATM' residues

    -infmt1  Input format for complex1
    -infmt2  Input format for complex2
            -1: (default) automatically detect PDB or PDBx/mmCIF format
             0: PDB format
             1: SPICKER format
             2: xyz format
             3: PDBx/mmCIF format
```

## usalign_pdb2fasta

### Tool Description
Converting PDB file(s) into FASTA format sequence.

### Metadata
- **Docker Image**: quay.io/biocontainers/usalign:20241201--h503566f_0
- **Homepage**: https://zhanggroup.org/US-align
- **Package**: https://anaconda.org/channels/bioconda/packages/usalign/overview
- **Validation**: PASS

### Original Help Text
```text
Converting PDB file(s) into FASTA format sequence.

Usage: pdb2fasta pdb.pdb > seq.fasta

    -dir     Convert all chains listed by 'chain_list' under 'chain_folder'.
             Note that the slash is necessary.
             $ pdb2xyz -dir chain_folder/ chain_list

    -suffix  (Only when -dir is set, default is empty)
             add file name suffix to files listed by chain_list

    -atom    4-character atom name used to represent a residue.
             Default is " C3'" for RNA/DNA and " CA " for proteins
             (note the spaces before and after CA).

    -mol     Type of molecule(s) to align.
             auto: (default) align both protein and nucleic acids.
             prot: only align proteins in a structure.
             RNA : only align RNA and DNA in a structure.

    -ter     Strings to mark the end of a chain
             3: TER, ENDMDL, END or different chain ID
             2: ENDMDL, END, or different chain ID
             1: (default) ENDMDL or END
             0: end of file

    -split   Whether to split PDB file into multiple chains
             0: treat the whole structure as one single chain
             1: treat each MODEL as a separate chain (-ter should be 0)
             2: (default) treat each chain as a seperate chain (-ter should be <=1)

    -het     Whether to read residues marked as 'HETATM' in addition to 'ATOM  '
             0: (default) only align 'ATOM  ' residues
             1: align both 'ATOM  ' and 'HETATM' residues

    -infmt   Input format for chain
            -1: (default) automatically detect PDB or PDBx/mmCIF format
             0: PDB format
             2: xyz format
             3: PDBx/mmCIF format
```

## usalign_se

### Tool Description
Extract sequence alignment from a pair of superposed structures.

### Metadata
- **Docker Image**: quay.io/biocontainers/usalign:20241201--h503566f_0
- **Homepage**: https://zhanggroup.org/US-align
- **Package**: https://anaconda.org/channels/bioconda/packages/usalign/overview
- **Validation**: PASS

### Original Help Text
```text
Extract sequence alignment from a pair of superposed structures.

Usage: se PDB1.pdb PDB2.pdb [Options]

Options:
    -u    TM-score normalized by user assigned length (the same as -L)
          warning: it should be >= minimum length of the two structures
          otherwise, TM-score may be >1

    -a    TM-score normalized by the average length of two structures
          T or F, (default F)

    -i    (Same as -I) use alignment specified in fasta file 'align.txt'

    -d    TM-score scaled by an assigned d0, e.g. 5 Angstroms

    -h    Print the full help message.

    (Options -u, -a, -d won't change the final structure alignment)

Example usages:
    se PDB1.pdb PDB2.pdb
    se PDB1.pdb PDB2.pdb -u 100 -d 5.0 -a T
    se PDB1.pdb PDB2.pdb -i align.txt

Additional options: 
    -dir     Perform all-against-all alignment extraction among the list
             of PDB chains listed by 'chain_list' under 'chain_folder'.
             Note that the slash is necessary.
             $ se -dir chain1_folder/ chain_list

    -dir1    Use chain2 to perform alignment extraction from a list of
             PDB chains listed by 'chain1_list' under 'chain1_folder'.
             Note that the slash is necessary.
             $ se -dir1 chain1_folder/ chain1_list chain2

    -dir2    Use chain2 to perform alignment extraction from a list of
             PDB chains listed by 'chain2_list' under 'chain2_folder'
             $ se chain1 -dir2 chain2_folder/ chain2_list

    -suffix  (Only when -dir1 and/or -dir2 are set, default is empty)
             add file name suffix to files listed by chain1_list or chain2_list

    -atom    4-character atom name used to represent a residue.
             Default is " C3'" for RNA/DNA and " CA " for proteins
             (note the spaces before and after CA).

    -mol     Molecule type: RNA or protein
             Default is detect molecule type automatically

    -ter     Strings to mark the end of a chain
             3: (default) TER, ENDMDL, END or different chain ID
             2: ENDMDL, END, or different chain ID
             1: ENDMDL or END
             0: (default in the first C++ TMalign) end of file

    -split   Whether to split PDB file into multiple chains
             0: (default) treat the whole structure as one single chain
             1: treat each MODEL as a separate chain (-ter should be 0)
             2: treat each chain as a seperate chain (-ter should be <=1)

    -outfmt  Output format
             0: (default) full output
             1: fasta format compact output
             2: tabular format very compact output

    -byresi  Whether to align two structures by residue index.
             The same as -TMscore.
             0: (default) do not align by residue index
             1: (same as TMscore program) align by residue index
             2: (same as TMscore -c, should be used with -ter <=1)
                align by residue index and chain ID
             3: (similar to TMscore -c, should be used with -ter <=1)
                align by residue index and order of chain
             4: sequence dependent alignment: perform Needleman-Wunsch
                global sequence alignment
             5: sequence dependent alignment: perform glocal sequence
                alignment

    -het     Whether to align residues marked as 'HETATM' in addition to 'ATOM  '
             0: (default) only align 'ATOM  ' residues
             1: align both 'ATOM  ' and 'HETATM' residues

    -do      Output distance of aligned residue pairs

    -infmt1  Input format for chain1
    -infmt2  Input format for chain2
            -1: (default) automatically detect PDB or PDBx/mmCIF format
             0: PDB format
             1: SPICKER format
             2: xyz format
             3: PDBx/mmCIF format
```

## usalign_pdbAtomName

### Tool Description
Fix atom name justification in PDB format file.

### Metadata
- **Docker Image**: quay.io/biocontainers/usalign:20241201--h503566f_0
- **Homepage**: https://zhanggroup.org/US-align
- **Package**: https://anaconda.org/channels/bioconda/packages/usalign/overview
- **Validation**: PASS

### Original Help Text
```text
Fix atom name justification in PDB format file.

Usage: pdbAtomName input.pdb output.pdb
```

## usalign_addChainID

### Tool Description
Add chain ID to PDB format file.

### Metadata
- **Docker Image**: quay.io/biocontainers/usalign:20241201--h503566f_0
- **Homepage**: https://zhanggroup.org/US-align
- **Package**: https://anaconda.org/channels/bioconda/packages/usalign/overview
- **Validation**: PASS

### Original Help Text
```text
Add chain ID to PDB format file.

Usage: addChainID input.pdb output.pdb chainID
```

## usalign_TMscore

### Tool Description
TM-score: compare a model with a native structure.

### Metadata
- **Docker Image**: quay.io/biocontainers/usalign:20241201--h503566f_0
- **Homepage**: https://zhanggroup.org/US-align
- **Package**: https://anaconda.org/channels/bioconda/packages/usalign/overview
- **Validation**: PASS

### Original Help Text
```text
Brief instruction for running TM-score program:
 (For detail: Zhang & Skolnick, Proteins, 2004 57:702-10)

 1. Run TM-score to compare 'model' and 'native':
     $ TMscore model.pdb native.pdb

 2. Run TM-score to compare two complex structures with multiple chains
     $ TMscore -c model.pdb native.pdb

 2. TM-score normalized with an assigned scale d0 e.g. 5 A:
     $ TMscore model.pdb native.pdb -d 5

 3. TM-score normalized by a specific length, e.g. 120 residues:
     $ TMscore model.pdb native.pdb -l 120

 4. TM-score with superposition output, e.g. 'TM_sup.pdb':
     $ TMscore model.pdb native.pdb -o TM_sup.pdb
    To view superimposed atomic model by PyMOL:
     $ pymol TM_sup.pdb native.pdb

 5. By default, this program assumes that residue pair with the same
    residue index accross the two structure files are equivalent. This
    often requires that the residue index in the input structures are
    renumbered beforehand. Alternatively, residue equivalence can be
    established by sequence alignment:
     $ TMscore model.pdb native.pdb -seq


Additional options:
    -a       TM-score normalized by the average length of two structures
             T or F, (default F)

    -m       Output TM-score rotation matrix

    -d       TM-score scaled by an assigned d0, e.g. 5 Angstroms

    -fast    Fast but slightly inaccurate alignment

    -dir     Perform all-against-all alignment among the list of PDB
             chains listed by 'chain_list' under 'chain_folder'. Note
             that the slash is necessary.
             $ TMscore -dir chain_folder/ chain_list

    -dir1    Use chain2 to search a list of PDB chains listed by 'chain1_list'
             under 'chain1_folder'. Note that the slash is necessary.
             $ TMscore -dir1 chain1_folder/ chain1_list chain2

    -dir2    Use chain1 to search a list of PDB chains listed by 'chain2_list'
             under 'chain2_folder'
             $ TMscore chain1 -dir2 chain2_folder/ chain2_list

    -suffix  (Only when -dir1 and/or -dir2 are set, default is empty)
             add file name suffix to files listed by chain1_list or chain2_list

    -atom    4-character atom name used to represent a residue.
             Default is " C3'" for RNA/DNA and " CA " for proteins
             (note the spaces before and after CA).

    -mol     Molecule type: RNA or protein
             Default is detect molecule type automatically

    -ter     Strings to mark the end of a chain
             3: (default) TER, ENDMDL, END or different chain ID
             2: ENDMDL, END, or different chain ID
             1: ENDMDL or END
             0: (default in the first C++ TMalign) end of file

    -split   Whether to split PDB file into multiple chains
             0: (default) treat the whole structure as one single chain
             1: treat each MODEL as a separate chain (-ter should be 0)
             2: treat each chain as a seperate chain (-ter should be <=1)

    -outfmt  Output format
             0: (default) full output
             1: fasta format compact output
             2: tabular format very compact output
            -1: full output, but without version or citation information

    -mirror  Whether to align the mirror image of input structure
             0: (default) do not align mirrored structure
             1: align mirror of chain1 to origin chain2

    -het     Whether to align residues marked as 'HETATM' in addition to 'ATOM  '
             0: (default) only align 'ATOM  ' residues
             1: align both 'ATOM  ' and 'HETATM' residues

    -infmt1  Input format for chain1
    -infmt2  Input format for chain2
            -1: (default) automatically detect PDB or PDBx/mmCIF format
             0: PDB format
             1: SPICKER format
             2: xyz format
             3: PDBx/mmCIF format
```

## usalign_TMalign

### Tool Description
TM-align: sequence-independent protein structure alignment of two monomeric chains.

### Metadata
- **Docker Image**: quay.io/biocontainers/usalign:20241201--h503566f_0
- **Homepage**: https://zhanggroup.org/US-align
- **Package**: https://anaconda.org/channels/bioconda/packages/usalign/overview
- **Validation**: PASS

### Original Help Text
```text
**********************************************************************
 * TM-align (Version 20240303): protein and RNA structure alignment   *
 * References: Y Zhang, J Skolnick. Nucl Acids Res 33, 2302-9 (2005)  *
 *             S Gong, C Zhang, Y Zhang. Bioinformatics, bz282 (2019) *
 * Please email comments and suggestions to yangzhanglab@umich.edu    *
 **********************************************************************

Usage: TMalign PDB1.pdb PDB2.pdb [Options]

Options:
    -u    TM-score normalized by user assigned length (the same as -L)
          warning: it should be >= minimum length of the two structures
          otherwise, TM-score may be >1

    -a    TM-score normalized by the average length of two structures
          T or F, (default F)

    -i    Start with an alignment specified in fasta file 'align.txt'

    -I    Stick to the alignment specified in 'align.txt'

    -m    Output TM-align rotation matrix

    -d    TM-score scaled by an assigned d0, e.g. 5 Angstroms

    -o    Output the superposition of PDB1.pdb to TM_sup.pdb
          $ TMalign PDB1.pdb PDB2.pdb -o TM_sup.pdb
          To view superposed full-atom structures:
          $ pymol TM_sup.pdb PDB2.pdb

    -v    Print the version of TM-align

    -h    Print the full help message, including options not available
          in standard TM-align program

    (Options -u, -a, -d, -o won't change the final structure alignment)

Example usages:
    TMalign PDB1.pdb PDB2.pdb
    TMalign PDB1.pdb PDB2.pdb -u 100 -d 5.0
    TMalign PDB1.pdb PDB2.pdb -a T -o PDB1.sup
    TMalign PDB1.pdb PDB2.pdb -i align.txt
    TMalign PDB1.pdb PDB2.pdb -m matrix.txt

Additional options:
    -fast    Fast but slightly inaccurate alignment

    -dir     Perform all-against-all alignment among the list of PDB
             chains listed by 'chain_list' under 'chain_folder'. Note
             that the slash is necessary.
             $ TMalign -dir chain_folder/ chain_list

    -dir1    Use chain2 to search a list of PDB chains listed by 'chain1_list'
             under 'chain1_folder'. Note that the slash is necessary.
             $ TMalign -dir1 chain1_folder/ chain1_list chain2

    -dir2    Use chain1 to search a list of PDB chains listed by 'chain2_list'
             under 'chain2_folder'
             $ TMalign chain1 -dir2 chain2_folder/ chain2_list

    -pair    (Only when -dir1 and -dir2 are set, default is no) whether to
             perform pair alignment rather than all-against-all alignment

    -suffix  (Only when -dir1 and/or -dir2 are set, default is empty)
             add file name suffix to files listed by chain1_list or chain2_list

    -atom    4-character atom name used to represent a residue.
             Default is " C3'" for RNA/DNA and " CA " for proteins
             (note the spaces before and after CA).

    -mol     Molecule type: RNA or protein
             Default is detect molecule type automatically

    -ter     Strings to mark the end of a chain
             3: (default) TER, ENDMDL, END or different chain ID
             2: ENDMDL, END, or different chain ID
             1: ENDMDL or END
             0: (default in the first C++ TMalign) end of file

    -split   Whether to split PDB file into multiple chains
             0: (default) treat the whole structure as one single chain
             1: treat each MODEL as a separate chain (-ter should be 0)
             2: treat each chain as a seperate chain (-ter should be <=1)

    -outfmt  Output format
             0: (default) full output
             1: fasta format compact output
             2: tabular format very compact output
            -1: full output, but without version or citation information

    -byresi  Whether to assume residue index correspondence between the
             two structures. The same as -TMscore.
             0: (default) sequence independent alignment
             1: (same as TMscore program) sequence-dependent superposition,
                i.e. align by residue index
             2: (same as TMscore -c, should be used with -ter <=1)
                align by residue index and chain ID
             3: (similar to TMscore -c, should be used with -ter <=1)
                align by residue index and order of chain
             5: sequence dependent alignment: perform glocal sequence
                alignment followed by TM-score superposition.
                -byresi 5 is thee same as -seq

    -TMcut   -1: (default) do not consider TMcut
             Values in [0.5,1): Do not proceed with TM-align for this
                 structure pair if TM-score is unlikely to reach TMcut.
                 TMcut is normalized is set by -a option:
                 -2: normalized by longer structure length
                 -1: normalized by shorter structure length
                  0: (default, same as F) normalized by second structure
                  1: same as T, normalized by average structure length

    -cp      ALignment with circular permutation

    -mirror  Whether to align the mirror image of input structure
             0: (default) do not align mirrored structure
             1: align mirror of chain1 to origin chain2

    -het     Whether to align residues marked as 'HETATM' in addition to 'ATOM  '
             0: (default) only align 'ATOM  ' residues
             1: align both 'ATOM  ' and 'HETATM' residues

    -infmt1  Input format for chain1
    -infmt2  Input format for chain2
            -1: (default) automatically detect PDB or PDBx/mmCIF format
             0: PDB format
             1: SPICKER format
             2: xyz format
             3: PDBx/mmCIF format
```

## usalign_xyz_sfetch

### Tool Description
Index or fetch entries of an xyz file.

### Metadata
- **Docker Image**: quay.io/biocontainers/usalign:20241201--h503566f_0
- **Homepage**: https://zhanggroup.org/US-align
- **Package**: https://anaconda.org/channels/bioconda/packages/usalign/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: xyz_sfetch ca.xyz
    Index all entries in xyz file 'ca.xyz' into 'ca.xyz.index'.
    Output file name inferred from input file name.

Usage: xyz_sfetch ca.xyz list > subset.xyz
    From xyz file 'ca.xyz' and respective index file 'ca.xyz.index',
    fetch all entries listed by 'list'. Output them to 'subset.xyz'.
```

## usalign_NWalign

### Tool Description
Pairwise sequence alignment between two sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/usalign:20241201--h503566f_0
- **Homepage**: https://zhanggroup.org/US-align
- **Package**: https://anaconda.org/channels/bioconda/packages/usalign/overview
- **Validation**: PASS

### Original Help Text
```text
Pairwise sequence alignment between two sequences.

Usage: NWalign PDB1.pdb PDB2.pdb [Options]

Options:
    -h       Print the full help message

    -glocal  Global or local alignment
             0: (default) Needleman-Wunsch algorithm for global alignment
             1: glocal-query alignment
             2: glocal-both alignment
             3: Smith-Waterman algorithm for local alignment

    -infmt1  Input format for chain1
    -infmt2  Input format for chain2
            -1: (default) automatically detect PDB or PDBx/mmCIF format
             0: PDB format
             2: xyz format
             3: PDBx/mmCIF format
             4: FASTA format sequence

Additional options:
    -dir     Perform all-against-all alignment among the list of PDB
             chains listed by 'chain_list' under 'chain_folder'. Note
             that the slash is necessary.
             $ NWalign -dir chain_folder/ chain_list

    -dir1    Use chain2 to search a list of PDB chains listed by 'chain1_list'
             under 'chain1_folder'. Note that the slash is necessary.
             $ NWalign -dir1 chain1_folder/ chain1_list chain2

    -dir2    Use chain1 to search a list of PDB chains listed by 'chain2_list'
             under 'chain2_folder'
             $ NWalign chain1 -dir2 chain2_folder/ chain2_list

    -suffix  (Only when -dir1 and/or -dir2 are set, default is empty)
             add file name suffix to files listed by chain1_list or chain2_list

    -atom    4-character atom name used to represent a residue.
             Default is " C3'" for RNA/DNA and " CA " for proteins
             (note the spaces before and after CA).

    -mol     Molecule type: RNA or protein
             Default is detect molecule type automatically

    -ter     Strings to mark the end of a chain
             3: (default) TER, ENDMDL, END or different chain ID
             2: ENDMDL, END, or different chain ID
             1: ENDMDL or END
             0: (default in the first C++ TMalign) end of file

             For FASTA intput (-infmt1/-infmt2 4), -ter 0 means read all
             sequences; -ter >=1 means read the first sequence only.
    -split   Whether to split PDB file into multiple chains
             0: (default) treat the whole structure as one single chain
             1: treat each MODEL as a separate chain (-ter should be 0)
             2: treat each chain as a seperate chain (-ter should be <=1)

             For FASTA intput, -split 0 means concatenate all sequences into
             one read all sequence; -split >=1 means each sequence is an
             individual entry.
    -het     Whether to align residues marked as 'HETATM' in addition to 'ATOM  '
             0: (default) only align 'ATOM  ' residues
             1: align both 'ATOM  ' and 'HETATM' residues

    -outfmt  Output format
             0: (default) full output
             1: fasta format compact output
             2: tabular format very compact output
```

## usalign_pdb2xyz

### Tool Description
Converting PDB or PDBx/mmCIF file(s) into xyz format.

### Metadata
- **Docker Image**: quay.io/biocontainers/usalign:20241201--h503566f_0
- **Homepage**: https://zhanggroup.org/US-align
- **Package**: https://anaconda.org/channels/bioconda/packages/usalign/overview
- **Validation**: PASS

### Original Help Text
```text
Converting PDB or PDBx/mmCIF file(s) into xyz format.

Usage: pdb2xyz pdb.pdb > ca.xyz

    -dir     Convert all chains listed by 'chain_list' under 'chain_folder'.
             Note that the slash is necessary.
             $ pdb2xyz -dir chain_folder/ chain_list

    -suffix  (Only when -dir is set, default is empty)
             add file name suffix to files listed by chain_list

    -atom    4-character atom name used to represent a residue.
             Default is " C3'" for RNA/DNA and " CA " for proteins
             (note the spaces before and after CA).

    -ter     Strings to mark the end of a chain
             3: (default) TER, ENDMDL, END or different chain ID
             2: ENDMDL, END, or different chain ID
             1: ENDMDL or END
             0: end of file

    -split   Whether to split PDB file into multiple chains
             0: (default) treat the whole structure as one single chain
             1: treat each MODEL as a separate chain (-ter should be 0)
             2: treat each chain as a seperate chain (-ter should be <=1)

    -het     Whether to read residues marked as 'HETATM' in addition to 'ATOM  '
             0: (default) only align 'ATOM  ' residues
             1: align both 'ATOM  ' and 'HETATM' residues

    -infmt   Input format for chain2
            -1: (default) automatically detect PDB or PDBx/mmCIF format
             3: PDBx/mmCIF format
```

## usalign_qTMclust

### Tool Description
Structure clustering by sequence-independent structure alignment.

### Metadata
- **Docker Image**: quay.io/biocontainers/usalign:20241201--h503566f_0
- **Homepage**: https://zhanggroup.org/US-align
- **Package**: https://anaconda.org/channels/bioconda/packages/usalign/overview
- **Validation**: PASS

### Original Help Text
```text
qTMclust: Structure Clustering by Sequence-Indepedent Structure Alignment

Usage 1: (alignment within a folder of PDB files)
    qTMclust -dir chain_folder/ chain_list -TMcut 0.5 -o cluster.txt

Usage 2: (alignment within chains or within models of a single PDB file)
    qTMclust -split 2 -ter 1 multichain.pdb -TMcut 0.5 -o cluster.txt
    qTMclust -split 1 -ter 0 multimodel.pdb -TMcut 0.5 -o cluster.txt

Options:
    -TMcut   TM-score cutoff in the range of [0.45,1) for considering two
             structures being similar. Default is 0.5.

    -s       Which TM-score to use when aligning structures with different lengths?
             1: the larger TM-score, i.e. normalized by shorter length
             2: (default) the smaller TM-score, i.e. normalized by longer length
             3: average of the two TM-scores
             4: harmonic average of the two TM-scores
             5: geometric average of the two TM-scores
             6: root mean square of the two TM-scores

    -o       Output the cluster result to file.
             Default is print result to screen.

    -dir     Perform all-against-all alignment among the list of PDB
             chains listed by 'chain_list' under 'chain_folder'. Note
             that the slash is necessary.
             $ qTMclust -dir chain_folder/ chain_list

    -suffix  (Only when -dir is set, default is empty)
             add file name suffix to files listed by chain_list

    -ter     Strings to mark the end of a chain
             3: (default) TER, ENDMDL, END or different chain ID
             2: ENDMDL, END, or different chain ID
             1: ENDMDL or END
             0: end of file

    -split   Whether to split PDB file into multiple chains
             0: (default) treat the whole structure as one single chain
             1: treat each MODEL as a separate chain (-ter should be 0)
             2: treat each chain as a seperate chain (-ter should be <=1)

    -init    tentative clustering

    -h       Print the full help message, including additional options.


Additional options:
    -fast    Fast but slightly inaccurate final alignment

    -atom    4-character atom name used to represent a residue.
             Default is " C3'" for RNA/DNA and " CA " for proteins
             (note the spaces before and after CA).

    -mol     Molecule type: RNA or protein
             Default is detect molecule type automatically

    -het     Whether to align residues marked as 'HETATM' in addition to 'ATOM  '
             0: (default) only align 'ATOM  ' residues
             1: align both 'ATOM  ' and 'HETATM' residues

    -infmt   Input format
            -1: (default) automatically detect PDB or PDBx/mmCIF format
             0: PDB format
             1: SPICKER format
             2: xyz format
             3: PDBx/mmCIF format
    -chain   Chains to parse in structure_2. Use _ for a chain without chain ID.
             Multiple chains can be separated by commas, e.g.,
             USalign -chain1 C,D,E,F 5jdo.pdb -chain2 A,B,C,D 3wtg.pdb -ter 0
```

## usalign_HwRMSD

### Tool Description
Partial implementation of the HwRMSD method for sequence-guided structure alignment.

### Metadata
- **Docker Image**: quay.io/biocontainers/usalign:20241201--h503566f_0
- **Homepage**: https://zhanggroup.org/US-align
- **Package**: https://anaconda.org/channels/bioconda/packages/usalign/overview
- **Validation**: PASS

### Original Help Text
```text
Partial implement of HwRMSD method for sequence-guided structure alignment.

Usage: HwRMSD PDB1.pdb PDB2.pdb [Options]

Options:
    -u    TM-score normalized by user assigned length (the same as -L)
          warning: it should be >= minimum length of the two structures
          otherwise, TM-score may be >1

    -a    TM-score normalized by the average length of two structures
          T or F, (default F)

    -i    Start with an alignment specified in fasta file 'align.txt'

    -I    Stick to the alignment specified in 'align.txt'

    -m    Output HwRMSD rotation matrix

    -d    TM-score scaled by an assigned d0, e.g. 5 Angstroms

    -o    Output the superposition of PDB1.pdb to TM_sup.pdb
          $ HwRMSD PDB1.pdb PDB2.pdb -o TM_sup.pdb
          To view superposed full-atom structures:
          $ pymol TM_sup.pdb PDB2.pdb

    -h    Print the full help message

    (Options -u, -a, -d, -o won't change the final structure alignment)

Example usages:
    HwRMSD PDB1.pdb PDB2.pdb
    HwRMSD PDB1.pdb PDB2.pdb -u 100 -d 5.0
    HwRMSD PDB1.pdb PDB2.pdb -a T -o PDB1.sup
    HwRMSD PDB1.pdb PDB2.pdb -i align.txt
    HwRMSD PDB1.pdb PDB2.pdb -m matrix.txt

Additional options:
    -dir     Perform all-against-all alignment among the list of PDB
             chains listed by 'chain_list' under 'chain_folder'. Note
             that the slash is necessary.
             $ HwRMSD -dir chain_folder/ chain_list

    -dir1    Use chain2 to search a list of PDB chains listed by 'chain1_list'
             under 'chain1_folder'. Note that the slash is necessary.
             $ HwRMSD -dir1 chain1_folder/ chain1_list chain2

    -dir2    Use chain1 to search a list of PDB chains listed by 'chain2_list'
             under 'chain2_folder'
             $ HwRMSD chain1 -dir2 chain2_folder/ chain2_list

    -suffix  (Only when -dir1 and/or -dir2 are set, default is empty)
             add file name suffix to files listed by chain1_list or chain2_list

    -atom    4-character atom name used to represent a residue.
             Default is " C3'" for RNA/DNA and " CA " for proteins
             (note the spaces before and after CA).

    -mol     Molecule type: RNA or protein
             Default is detect molecule type automatically

    -ter     Strings to mark the end of a chain
             3: (default) TER, ENDMDL, END or different chain ID
             2: ENDMDL, END, or different chain ID
             1: ENDMDL or END
             0: (default in the first C++ TMalign) end of file

    -split   Whether to split PDB file into multiple chains
             0: (default) treat the whole structure as one single chain
             1: treat each MODEL as a separate chain (-ter should be 0)
             2: treat each chain as a seperate chain (-ter should be <=1)

    -outfmt  Output format
             0: (default) full output
             1: fasta format compact output
             2: tabular format very compact output
            -1: full output, but without version or citation information

    -byresi  Whether to assume residue index correspondence between the
             two structures.
             0: (default) sequence independent alignment
             1: (same as TMscore program) sequence-dependent superposition,
                i.e. align by residue index
             2: (same as TMscore -c, should be used with -ter <=1)
                align by residue index and chain ID
             3: (similar to TMscore -c, should be used with -ter <=1)
                align by residue index and order of chain

    -glocal  Global or local alignment
             0: (default) Needleman-Wunsch algorithm for global alignment
             1: glocal-query alignment
             2: glocal-both alignment
             3: Smith-Waterman algorithm for local alignment

    -iter    Alignment-superposition iterations. Default is 10

    -seq     Type of sequence used to make initial alignment
             1: amino acid/nucleotide sequence
             2: secondary structure
             3: (default) sequence + secondary structure

    -het     Whether to align residues marked as 'HETATM' in addition to 'ATOM  '
             0: (default) only align 'ATOM  ' residues
             1: align both 'ATOM  ' and 'HETATM' residues

    -infmt1  Input format for chain1
    -infmt2  Input format for chain2
            -1: (default) automatically detect PDB or PDBx/mmCIF format
             0: PDB format
             1: SPICKER format
             2: xyz format
             3: PDBx/mmCIF format
```

## usalign_cif2pdb

### Tool Description
Converting mmCIF file to PDB file(s).

### Metadata
- **Docker Image**: quay.io/biocontainers/usalign:20241201--h503566f_0
- **Homepage**: https://zhanggroup.org/US-align
- **Package**: https://anaconda.org/channels/bioconda/packages/usalign/overview
- **Validation**: PASS

### Original Help Text
```text
Converting mmCIF file to PDB file(s)

Usage: cif2pdb input.cif output.pdb

    -chain   Specify auth chain ID to convert:
             $ cif2pdb input.cif output.pdb -chain A

    -mol     macromolecule type. default is all macromolecules.
             1: protein only
             2: RNA only
             4: DNA only

    -split   Whether to split PDB file into multiple chains
             0: (default) do not split; output a single PDB
             1: output one PDB file per chain

    -het     Whether to read residues marked as 'HETATM' in addition to 'ATOM  '
             0: only 'ATOM  ' residues
             1: (default) 'ATOM  ' and 'HETATM' for MSE
             2: 'ATOM  ' and all 'HETATM', excluding HOH
             3: 'ATOM  ' and all 'HETATM', including HOH
             If -het >=1, MSE will be converted to MET
```

