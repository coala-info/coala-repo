# reduce CWL Generation Report

## reduce

### Tool Description
Add hydrogens, correct geometry, and optimize sidechain conformations of protein structures.

### Metadata
- **Docker Image**: quay.io/biocontainers/reduce:4.15--py39h2de1943_4
- **Homepage**: https://github.com/rlabduke/reduce
- **Package**: https://anaconda.org/channels/bioconda/packages/reduce/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/reduce/overview
- **Total Downloads**: 14.8K
- **Last updated**: 2026-01-06
- **GitHub**: https://github.com/rlabduke/reduce
- **Stars**: N/A
### Original Help Text
```text
reduce: version 4.15 4/8/2025, Copyright 1997-2016, J. Michael Word; 2020-2025 Richardson Lab at Duke University
reduce.4.15.250408
arguments: [-flags] filename or -

Suggested usage:
reduce -FLIP myfile.pdb > myfileFH.pdb (do NQH-flips)
reduce -NOFLIP myfile.pdb > myfileH.pdb (do NOT do NQH-flips)

Flags:
-FLIP             add H and rotate and flip NQH groups
-NOFLIP           add H and rotate groups with no NQH flips
-Trim             remove (rather than add) hydrogens and skip all optimizations

-FLIP             Same as -HIS -OH -ROTEXOH plus demand flipping all HNQs
                  Use other -NO* flags later to turn off individual behaviors if needed
-BUILD            Same as -FLIP
-NUClear          use nuclear X-H distances rather than default
                  electron cloud distances
-NOOH             remove hydrogens on OH and SH groups
-OH               add hydrogens on OH and SH groups (default)

-HIS              create NH hydrogens on HIS rings
                        (usually used with -HIS)
-NOHETh           do not attempt to add NH proton on Het groups
-ROTNH3           allow lysine NH3 to rotate (default)
-NOROTNH3         do not allow lysine NH3 to rotate
-ROTEXist         allow existing rotatable groups (OH, SH, Met-CH3) to rotate (default)
-NOROTEXist       do not allow existing rotatable groups (OH, SH, Met-CH3) to rotate
-ROTEXOH          allow existing OH & SH groups to rotate (default)
-NOROTEXOH        do not allow existing OH & SH groups to rotate
-ALLALT           process adjustments for all conformations (default)
-ONLYA            only adjust 'A' conformations
-CHARGEs          output charge state for appropriate hydrogen records
-NOADJust         do not process any rot or flip adjustments

-NOBUILD#.#       build with a given penalty often 200 or 999
-BUILD            add H, including His sc NH, then rotate and flip groups
                  (except for pre-existing methionine methyl hydrogens)

                  (same as: -OH -ROTEXOH -HIS -FLIP)
-Keep             keep bond lengths as found
-MAXAromdih#      dihedral angle cutoff for aromatic ring planarity check (default=10)
-NBonds#          remove dots if cause within n bonds (default=3)
-Nterm#           max number of nterm residue (default=1)
-DENSity#.#       dot density (in dots/A^2) for VDW calculations (Real, default=16)
-RADius#.#        probe radius (in A) for VDW calculations (Real, default=0.25)
-OCCcutoff#.#     occupancy cutoff for adjustments (default=0.01)
-H2OOCCcutoff#.#  occupancy cutoff for water atoms (default=0.66)
-H2OBcutoff#      B-factor  cutoff for water atoms (Integer, default=40)
-PENalty#.#       fraction of std. bias towards original orientation (default=1)
-HBREGcutoff#.#   over this gap regular HBonds bump (default=0.6)
-HBCHargedcut#.#  over this gap charged HBonds bump (default=0.8)
-BADBumpcut#.#    at this gap a bump is 'bad' (default=0.4)
-METALBump#.#     H 'bumps' metals at radius plus this (default=0.865)
-NONMETALBump#.#  'bumps' nonmetal at radius plus this (default=0.125)
-SEGIDmap "seg,c..."  assign chainID based on segment identifier field
-Xplor            use Xplor conventions for naming polar hydrogens
-OLDpdb 	      use the pre-remediation names for hydrogens
-BBmodel	      expects a backbone only model and will build HA hydrogens on Calpha truncated residues
-NOCon            drop conect records
-LIMIT#           max seconds to spend in exhaustive search (default=600)
-NOTICKs          do not display the set orientation ticker during processing
-SHOWSCore        display scores for each orientation considered during processing
-DROP_HYDROGENS_ON_ATOM_RECORDS drop hydrogens on incoming ATOM records before other processing
-DROP_HYDROGENS_ON_OTHER_RECORDS drop hydrogens on incoming non-ATOM records before other processing
-NO_ADD_WATER_HYDROGENS don't add hydrogens on incoming HOH records but do other processing
                   (the default is to add water hydrogens even if hydrogens have been dropped)
-NO_ADD_OTHER_HYDROGENS don't add hydrogens on incoming non-HOH records but do other processing
                   (the default is to add other hydrogens even if hydrogens have been dropped)
-NOOPT            do not perform optimizations, only drop/add hydrogens
-FIX "filename"   if given, file specifies orientations for adjustable groups
-DB "filename"    file to search for het info
                        (default="/usr/local/share/reduce/reduce_wwPDB_het_dict.txt")
note: can also redirect with unix environment variable: REDUCE_HET_DICT

-STRING           pass reduce a string object from a script, must be quoted
-DUMPATOMS FILE   dump the atoms, along with extra information about them, to FILE
usage: from within a script, reduce -STRING "_name_of_string_variable_"

-Quiet            do not write extra info to the console
-REFerence        display citation reference
-Version          display the version of reduce
-Changes          display the change log
-Help             the more extensive description of command line arguments
```


## Metadata
- **Skill**: generated
