# king-probe CWL Generation Report

## king-probe

### Tool Description
Calculates probe-based interactions and surfaces for molecular structures.

### Metadata
- **Docker Image**: biocontainers/king-probe:v2.16.160404git20180613.a09b012-1-deb_cv1
- **Homepage**: http://people.virginia.edu/~wc9c/KING/
- **Package**: https://anaconda.org/channels/bioconda/packages/king/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/king-probe/overview
- **Total Downloads**: N/A
- **Last updated**: N/A
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Syntax: probe input.pdb >> out.kin
    or: probe [flags] "src pattern" ["target pattern"] pdbfiles... >> out.kin

Flags:
  -SElf  self intersection:   src  -> src (default)
  -Both  intersect both ways: src <=> targ
  -ONce  single intersection: src  -> targ
  -OUt   external van der Waals surface of src (solvent contact surface)

  -AUTObondrot filename    read and process an autobondrot file

  shortcuts:
 <<NO FLAGS>>same as: -4H -mc -het -self "altA ogt33"
  -DEFAULTs  same as: <<NO FLAGS>>, but allows some other flags
  -SCSurface same as: -drop -rad1.4         -out "not water"
  -EXPOsed   same as: -drop -rad1.4         -out      (note: user supplies pattern)
  -ASurface  same as: -drop -rad0.0 -add1.4 -out "not water"
  -ACCESS    same as: -drop -rad0.0 -add1.4 -out      (note: user supplies pattern)
  -SCAN0 same as: -4H -mc -self "alta blt40 ogt33"
  -SCAN1 same as: -4H -once "sc alta blt40 ogt33" "alta blt40 ogt65,(not water ogt33)"

  -DUMPAtominfo   count the atoms in the selection: src

  (note that BOTH and ONCE require two patterns while
   OUT, SELF and DUMPATOMINFO require just one pattern)

  -Implicit    implicit hydrogens
  -Explicit    explicit hydrogens (default)
  -DEnsity#    set dot density (default 16 dots/sq A)
  -Radius#.#   set probe radius (default 0.25 A)
  -ADDvdw#.#   offset added to Van der Waals radii (default 0.0)
  -SCALEvdw#.# scale factor for Van der Waals radii (default 1.0)
  -COSCale#.#  scale C=O carbon Van der Waals radii (default 0.94)
  -SPike       draw spike instead of dots (default)
  -SPike#.#    set spike scale (default=0.5)
  -NOSpike     draw only dots
  -HBRegular#.# max overlap for regular Hbonds(default=0.6)
  -HBCharged#.# max overlap for charged Hbonds(default=0.8)
  -Keep        keep nonselected atoms (default)
  -DRop        drop nonselected atoms
  -LIMit       limit bump dots to max dist when kissing (default)
  -NOLIMit     do not limit bump dots
  -LENs        add lens keyword to kin file
  -NOLENs      do not add lens keyword to kin file (default)
  -MC          include mainchain->mainchain interactions
  -HETs        include dots to non-water HET groups (default)
  -NOHETs      exclude dots to non-water HET groups
  -WATers      include dots to water (default)
  -NOWATers    exclude dots to water
  -WAT2wat     show dots between waters
  -DUMPH2O     include water H? vectorlist in output
  -4H          extend bond chain dot removal to 4 for H (default)
  -3           limit bond chain dot removal to 3
  -2           limit bond chain dot removal to 2
  -1           limit bond chain dot removal to 1
  -IGNORE "pattern" explicit drop: ignore atoms selected by pattern
  -DOCHO       recognize CH..O Hbonds
  -CHO#.#      scale factor for CH..O Hbond score (default=0.5)
  -PolarH      use short radii of polar hydrogens (default)
  -NOPolarH    do not shorten radii of polar hydrogens
  -NUClear     use nuclear position vdW radii
               (default is electron cloud positions)
  -NOFACEhbond do not identify HBonds to aromatic faces

  -Name "name" specify the group name (default "dots")
  -DOTMASTER  group name used as extra master={name} on lists
  -NOGroup     do not generate @group statement in .kin format output
  -KINemage    add @kinemage 1 statement to top of .kin format output

  -Countdots   produce a count of dots-not a dotlist
  -Unformated  output raw dot info
     name:pat:type:srcAtom:targAtom:mingap:gap:spX:spY:spZ:spikeLen:score:stype:ttype:x:y:z:sBval:tBval:
  -CONdense    raw output in condensed format, i.e. one line per source->target atom. Also gives the dot count for that interaction. Works only with -Unformated flag
     name:pat:type:srcAtom:targAtom:dot-count:mingap:gap:spX:spY:spZ:spikeLen:score:stype:ttype:x:y:z:sBval:tBval:
  -OFORMAT     output dot info formatted for display in O
  -XVFORMAT    output dot info formatted for display in XtalView
  -ONELINE     output one line :contacts:by:severity:type:
  -ONEDOTeach  output one dot for each src-to-neighbor
               With -Unformated flag: for H gives angle parent-src-cause,
     name:pat:type:srcAtom:targAtom:XHTangle:mingap:gap:spX:spY:spZ:spikeLen:score:stype:ttype:x:y:z:sBval:tBval:
  -GAPBINs     2nd pointmaster character, -.5...0...+.5
  -NEAREST     apply selection only on nearest neighbor
  -FILTERnearest apply 3rd selection on neighbor
 e.g. -nearest -filternearest patt1 all patt3
  -OCC1filter  final filter exclude any w occ < 1
  -NOALTfilter final filter exclude any alts
  -GAPcolor    color dots by gap amount (default)
  -ATOMcolor   color dots by atom type
  -BASEcolor   color dots by nucleic acid base type
  -COLORBase   color dots by gap and nucleic acid base type
  -OUTCOLor "name" specify the point color for -OUT (default "gray")
  -GAPWeight#  set weight for scoring gaps (default 0.25)
  -BUMPWeight# set relative scale for scoring bumps (default 10.0)
  -HBWeight#   set relative scale for scoring Hbonds (default 4.0)
  -DIVLow#.#   Division for Bump categories    (default -0.4)
  -DIVHigh#.#  Division for Contact categories (default  0.25)
  -DIVWorse#.#  Division for regarding a clash as a worse clash (default  -0.5)
  -SEPWORSE    To separate bad overlaps and worse overlaps (default false, if true, deafult value to separate the worse clashes is -0.5)
  -MINOCCupancy#.#  Occupancy below this is same as zero (default  0.02)
  -ELEMent     add master buttons for different elements in kin output
  -NOHBOUT     do not output contacts for HBonds
  -NOCLASHOUT  do not output contacts for clashes
  -NOVDWOUT    do not output contacts for van der Waals interactions
  -ONLYBADOUT  onlybadout output bad clashes (severe overlap contacts)
  -SUMMARY     output summary list of contacts and clashes
  -ONELINE     output summary list on oneline
  -NOTICKs     do not display the residue name ticker during processing
  -STDBONDs    assume only standard bonding patterns in standard residues
  -NOPARENT    do not bond hydrogens based on table of parent heavy atoms

  -SEGID       use the PDB SegID field to descriminate between residues
  -OLDU        generate old style -u output: kissEdge2BullsEye, etc
  -VErbose     verbose mode (default)
  -DOTDUMP     dump dot info while doing examineDots()
  -REFerence   display reference string
  -CHANGEs     display a list of program changes
  -Quiet       quiet mode

  -Help  show expanded help notice (includes other flags)

  -VERSION   one line version to stdout

Pattern elements:  (should be put in quotes on the command line)
   FILE#     within file #
   MODEL#    within model #
   CHAINaa   within chain a
   SEGaaaa   segment identifier aaaa (where _ represents blank)
   ALTa      alternate conformation a
   ATOMaaaa  atom name aaaa (where _ represents blank)
             (all 4 characters are used so H would be ATOM_H__)
   RESaaa    residue aaa
   #         residue #
   #a        residue #, insert a
   #-#       residue range # (insert codes ignored)
   a         residue type by one letter codes   (eg. y)
   aaa       residue type by three letter codes (eg. tyr)
   ALL,PROTEIN,MC,SC,BASE,ALPHA,BETA,NITROGEN,CARBON,OXYGEN,
   SULFUR,PHOSPHORUS,HYDROGEN,METAL,POLAR,NONPOLAR,CHARGED,
   DONOR,ACCEPTOR,AROMATIC,METHYLENE,METHYL,HET,WATER,DNA,RNA
             all or a subset of the atoms
   OLT#      Occupancy less than # (integer percent)
   OGT#      Occupancy greater than # (integer percent)
   BLT#      B-value less than # (integer)
   BGT#      B-value greater than # (integer)
   INSa      Insert code a (where _ represents blank)
   
   WITHIN #.# OF #.#, #.#, #.#   atoms within distance from point
   
   Patterns can be combined into comma separated lists
   such as "trp,phe,tyr" meaning TRP or PHE or TYR.
   
   Patterns that are sepatated by blanks must all be true
   such as "chainb 1-5" meaning residues 1 to 5 in chain B.
   
   You can also group patterns with parenthesis, separate
   multiple patterns with | meaning 'or' and choose the
   complement with NOT as in "not file1" meaning not in file 1.

   An autobondrot file is similar to other PDB input files
   but it includes information identifying atoms subject to rotations
   and other transformations.

   Example autobondrot file fragment showing Calpha-Cbeta bond rotation
   and a periodic torsion penalty function for this rotation
     ATOM      1  CB  TYR    61      34.219  17.937   4.659  1.00  0.00
     bondrot:chi1:78.7:  0:359:5:33.138:18.517: 5.531:34.219:17.937: 4.659
     cos:-3:60:3:
     ATOM      1 1HB  TYR    61      34.766  18.777   4.206  1.00  0.00
     ATOM      1 2HB  TYR    61      34.927  17.409   5.315  1.00  0.00
     ATOM      1  CG  TYR    61      33.836  16.989   3.546  1.00  0.00
     ...
   Autobondrot commands use colons to separate values
   Transformations: BONDROT:id:currAng:start:end:stepSz:x1:y1:z1:x2:y2:z2
                    TRANS:  id:currpos:start:end:stepSz:x1:y1:z1:x2:y2:z2
                    NULL  # dummy
   Bias functions:  COS:scale:phaseOffset:frequency
                    POLY:scale:offset:polynomialDegree
                    CONST:value
   Branching:       SAVE and RESTORE or "(" and ")"
           (e.g. to rotate each Chi and the methyls for isoleucine the
            sequence is: rotChi1/SAVE/rotChi2/rotCD1/RESTORE/rotCG2)
   Set orientation: GO:angle1:angle2:...
   Include files:   @filename
   Comments:        # comment text

probe: version 2.16.160404, Copyright 1996-2016, J. Michael Word
```


## Metadata
- **Skill**: generated
