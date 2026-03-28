# ambertools CWL Generation Report

## ambertools_reduce

### Tool Description
Add or remove hydrogens to/from a PDB file, with optimization of hydrogen positions and flips of NQH groups.

### Metadata
- **Docker Image**: quay.io/biocontainers/ambertools:21.10
- **Homepage**: https://github.com/quantaosun/Ambertools-OpenMM-MD
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ambertools/overview
- **Total Downloads**: N/A
- **Last updated**: N/A
- **GitHub**: https://github.com/quantaosun/Ambertools-OpenMM-MD
- **Stars**: 37
### Original Help Text
```text
INFO:    Using cached SIF image
reduce: version 3.3 06/02/2016, Copyright 1997-2016, J. Michael Word
reduce.3.3.160602
arguments: [-flags] filename or -

Suggested usage:
reduce -FLIP myfile.pdb > myfileFH.pdb (do NQH-flips)
reduce -NOFLIP myfile.pdb > myfileH.pdb (do NOT do NQH-flips)

Flags:
-FLIP             add H and rotate and flip NQH groups
-NOFLIP           add H and rotate groups with no NQH flips
-Trim             remove (rather than add) hydrogens

-NUClear          use nuclear X-H distances rather than default
                  electron cloud distances
-NOOH             remove hydrogens on OH and SH groups
-OH               add hydrogens on OH and SH groups (default)

-HIS              create NH hydrogens on HIS rings
                        (usually used with -HIS)
-NOHETh           do not attempt to add NH proton on Het groups
-ROTNH3           allow lysine NH3 to rotate (default)
-NOROTNH3         do not allow lysine NH3 to rotate
-ROTEXist         allow existing rotatable groups (OH, SH, Met-CH3) to rotate
-ROTEXOH          allow existing OH & SH groups to rotate
-ALLALT           process adjustments for all conformations (default)
-ONLYA            only adjust 'A' conformations
-CHARGEs          output charge state for appropriate hydrogen records
-DOROTMET         allow methionine methyl groups to rotate (not recommended)
-NOADJust         do not process any rot or flip adjustments

-NOBUILD#.#       build with a given penalty often 200 or 999
-BUILD            add H, including His sc NH, then rotate and flip groups
                  (except for pre-existing methionine methyl hydrogens)

                  (same as: -OH -ROTEXOH -HIS -FLIP)
-Keep             keep bond lengths as found
-MAXAromdih#      dihedral angle cutoff for aromatic ring planarity check (default=10)
-NBonds#          remove dots if cause within n bonds (default=3)
-Model#           which model to process (default=1)
-Nterm#           max number of nterm residue (default=1)
-DENSity#.#       dot density (in dots/A^2) for VDW calculations (Real, default=16)
-RADius#.#        probe radius (in A) for VDW calculations (Real, default=0)
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
-FIX "filename"   if given, file specifies orientations for adjustable groups
-DB "filename"    file to search for het info
                        (default="/usr/local//dat/reduce_wwPDB_het_dict.txt")
note: can also redirect with unix environment variable: REDUCE_HET_DICT

-STRING           pass reduce a string object from a script, must be quoted
usage: from within a script, reduce -STRING "_name_of_string_variable_"

-Quiet            do not write extra info to the console
-REFerence        display citation reference
-Version          display the version of reduce
-Changes          display the change log
-Help             the more extensive description of command line arguments
```


## ambertools_ante-MMPBSA.py

### Tool Description
A tool to prepare topology files for MMPBSA.py by stripping solvent, ligand, or receptor atoms from a complex topology.

### Metadata
- **Docker Image**: quay.io/biocontainers/ambertools:21.10
- **Homepage**: https://github.com/quantaosun/Ambertools-OpenMM-MD
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: ante-MMPBSA.py [options]

Options:
  -h, --help            show this help message and exit
  -p PRMTOP, --prmtop=PRMTOP
                        Input "dry" complex topology or solvated complex
                        topology
  -c COMPLEX, --complex-prmtop=COMPLEX
                        Complex topology file created by stripping PRMTOP of
                        solvent
  -r RECEPTOR, --receptor-prmtop=RECEPTOR
                        Receptor topology file created by stripping COMPLEX of
                        ligand
  -l LIGAND, --ligand-prmtop=LIGAND
                        Ligand topology file created by stripping COMPLEX of
                        receptor
  -s STRIP_MASK, --strip-mask=STRIP_MASK
                        Amber mask of atoms needed to be stripped from PRMTOP
                        to make the COMPLEX topology file
  -m RECEPTOR_MASK, --receptor-mask=RECEPTOR_MASK
                        Amber mask of atoms needed to be stripped from COMPLEX
                        to create RECEPTOR. Cannot specify with -n/--ligand-
                        mask
  -n LIGAND_MASK, --ligand-mask=LIGAND_MASK
                        Amber mask of atoms needed to be stripped from COMPLEX
                        to create LIGAND. Cannot specify with -m/--receptor-
                        mask
  --radii=RADIUS_SET    PB/GB Radius set to set in the generated topology
                        files. This is equivalent to "set PBRadii <radius>" in
                        LEaP. Options are bondi, mbondi2, mbondi3, amber6, and
                        mbondi and the default is to use the existing radii.
```


## ambertools_MMPBSA.py

### Tool Description
MMPBSA.py calculates binding free energies using end-state free energy methods like MM-PBSA and MM-GBSA.

### Metadata
- **Docker Image**: quay.io/biocontainers/ambertools:21.10
- **Homepage**: https://github.com/quantaosun/Ambertools-OpenMM-MD
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
INFO:    Using cached SIF image
Traceback (most recent call last):
  File "/usr/local/bin/MMPBSA.py", line 41, in <module>
    from MMPBSA_mods import main
  File "/usr/local/lib/python3.9/site-packages/MMPBSA_mods/main.py", line 42, in <module>
    from MMPBSA_mods.commandlineparser import parser
  File "/usr/local/lib/python3.9/site-packages/MMPBSA_mods/commandlineparser.py", line 60, in <module>
    default=os.path.join(os.getenv('AMBERHOME'), 'dat', 'mmpbsa',
  File "/usr/local/lib/python3.9/posixpath.py", line 76, in join
    a = os.fspath(a)
TypeError: expected str, bytes or os.PathLike object, not NoneType
```


## Metadata
- **Skill**: generated
