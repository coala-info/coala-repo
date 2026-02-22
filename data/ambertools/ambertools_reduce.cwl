cwlVersion: v1.2
class: CommandLineTool
baseCommand: reduce
label: ambertools_reduce
doc: "Add or remove hydrogens to/from a PDB file, with optimization of hydrogen positions
  and flips of NQH groups.\n\nTool homepage: https://github.com/quantaosun/Ambertools-OpenMM-MD"
inputs:
  - id: input_file
    type: File
    doc: Input PDB filename or - for stdin
    inputBinding:
      position: 1
  - id: all_alt
    type:
      - 'null'
      - boolean
    doc: process adjustments for all conformations (default)
    default: true
    inputBinding:
      position: 102
      prefix: -ALLALT
  - id: bad_bump_cut
    type:
      - 'null'
      - float
    doc: at this gap a bump is 'bad'
    default: 0.4
    inputBinding:
      position: 102
      prefix: -BADBumpcut
  - id: bb_model
    type:
      - 'null'
      - boolean
    doc: expects a backbone only model and will build HA hydrogens on Calpha 
      truncated residues
    inputBinding:
      position: 102
      prefix: -BBmodel
  - id: build
    type:
      - 'null'
      - boolean
    doc: add H, including His sc NH, then rotate and flip groups
    inputBinding:
      position: 102
      prefix: -BUILD
  - id: charges
    type:
      - 'null'
      - boolean
    doc: output charge state for appropriate hydrogen records
    inputBinding:
      position: 102
      prefix: -CHARGEs
  - id: db_file
    type:
      - 'null'
      - File
    doc: file to search for het info
    default: /usr/local//dat/reduce_wwPDB_het_dict.txt
    inputBinding:
      position: 102
      prefix: -DB
  - id: density
    type:
      - 'null'
      - float
    doc: dot density (in dots/A^2) for VDW calculations
    default: 16.0
    inputBinding:
      position: 102
      prefix: -DENSity
  - id: do_rot_met
    type:
      - 'null'
      - boolean
    doc: allow methionine methyl groups to rotate (not recommended)
    inputBinding:
      position: 102
      prefix: -DOROTMET
  - id: fix_file
    type:
      - 'null'
      - File
    doc: if given, file specifies orientations for adjustable groups
    inputBinding:
      position: 102
      prefix: -FIX
  - id: flip
    type:
      - 'null'
      - boolean
    doc: add H and rotate and flip NQH groups
    inputBinding:
      position: 102
      prefix: -FLIP
  - id: h2o_b_cutoff
    type:
      - 'null'
      - int
    doc: B-factor cutoff for water atoms
    default: 40
    inputBinding:
      position: 102
      prefix: -H2OBcutoff
  - id: h2o_occ_cutoff
    type:
      - 'null'
      - float
    doc: occupancy cutoff for water atoms
    default: 0.66
    inputBinding:
      position: 102
      prefix: -H2OOCCcutoff
  - id: hb_charged_cut
    type:
      - 'null'
      - float
    doc: over this gap charged HBonds bump
    default: 0.8
    inputBinding:
      position: 102
      prefix: -HBCHargedcut
  - id: hb_reg_cutoff
    type:
      - 'null'
      - float
    doc: over this gap regular HBonds bump
    default: 0.6
    inputBinding:
      position: 102
      prefix: -HBREGcutoff
  - id: his
    type:
      - 'null'
      - boolean
    doc: create NH hydrogens on HIS rings
    inputBinding:
      position: 102
      prefix: -HIS
  - id: keep
    type:
      - 'null'
      - boolean
    doc: keep bond lengths as found
    inputBinding:
      position: 102
      prefix: -Keep
  - id: limit
    type:
      - 'null'
      - int
    doc: max seconds to spend in exhaustive search
    default: 600
    inputBinding:
      position: 102
      prefix: -LIMIT
  - id: max_arom_dih
    type:
      - 'null'
      - int
    doc: dihedral angle cutoff for aromatic ring planarity check
    default: 10
    inputBinding:
      position: 102
      prefix: -MAXAromdih
  - id: metal_bump
    type:
      - 'null'
      - float
    doc: H 'bumps' metals at radius plus this
    default: 0.865
    inputBinding:
      position: 102
      prefix: -METALBump
  - id: model
    type:
      - 'null'
      - int
    doc: which model to process
    default: 1
    inputBinding:
      position: 102
      prefix: -Model
  - id: n_bonds
    type:
      - 'null'
      - int
    doc: remove dots if cause within n bonds
    default: 3
    inputBinding:
      position: 102
      prefix: -NBonds
  - id: n_term
    type:
      - 'null'
      - int
    doc: max number of nterm residue
    default: 1
    inputBinding:
      position: 102
      prefix: -Nterm
  - id: no_adjust
    type:
      - 'null'
      - boolean
    doc: do not process any rot or flip adjustments
    inputBinding:
      position: 102
      prefix: -NOADJust
  - id: no_build_penalty
    type:
      - 'null'
      - float
    doc: build with a given penalty often 200 or 999
    inputBinding:
      position: 102
      prefix: -NOBUILD
  - id: no_con
    type:
      - 'null'
      - boolean
    doc: drop conect records
    inputBinding:
      position: 102
      prefix: -NOCon
  - id: no_flip
    type:
      - 'null'
      - boolean
    doc: add H and rotate groups with no NQH flips
    inputBinding:
      position: 102
      prefix: -NOFLIP
  - id: no_heth
    type:
      - 'null'
      - boolean
    doc: do not attempt to add NH proton on Het groups
    inputBinding:
      position: 102
      prefix: -NOHETh
  - id: no_oh
    type:
      - 'null'
      - boolean
    doc: remove hydrogens on OH and SH groups
    inputBinding:
      position: 102
      prefix: -NOOH
  - id: no_rot_nh3
    type:
      - 'null'
      - boolean
    doc: do not allow lysine NH3 to rotate
    inputBinding:
      position: 102
      prefix: -NOROTNH3
  - id: no_ticks
    type:
      - 'null'
      - boolean
    doc: do not display the set orientation ticker during processing
    inputBinding:
      position: 102
      prefix: -NOTICKs
  - id: non_metal_bump
    type:
      - 'null'
      - float
    doc: "'bumps' nonmetal at radius plus this"
    default: 0.125
    inputBinding:
      position: 102
      prefix: -NONMETALBump
  - id: nuclear
    type:
      - 'null'
      - boolean
    doc: use nuclear X-H distances rather than default electron cloud distances
    inputBinding:
      position: 102
      prefix: -NUClear
  - id: occ_cutoff
    type:
      - 'null'
      - float
    doc: occupancy cutoff for adjustments
    default: 0.01
    inputBinding:
      position: 102
      prefix: -OCCcutoff
  - id: oh
    type:
      - 'null'
      - boolean
    doc: add hydrogens on OH and SH groups (default)
    default: true
    inputBinding:
      position: 102
      prefix: -OH
  - id: old_pdb
    type:
      - 'null'
      - boolean
    doc: use the pre-remediation names for hydrogens
    inputBinding:
      position: 102
      prefix: -OLDpdb
  - id: only_a
    type:
      - 'null'
      - boolean
    doc: only adjust 'A' conformations
    inputBinding:
      position: 102
      prefix: -ONLYA
  - id: penalty
    type:
      - 'null'
      - float
    doc: fraction of std. bias towards original orientation
    default: 1.0
    inputBinding:
      position: 102
      prefix: -PENalty
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: do not write extra info to the console
    inputBinding:
      position: 102
      prefix: -Quiet
  - id: radius
    type:
      - 'null'
      - float
    doc: probe radius (in A) for VDW calculations
    default: 0.0
    inputBinding:
      position: 102
      prefix: -RADius
  - id: rot_ex_oh
    type:
      - 'null'
      - boolean
    doc: allow existing OH & SH groups to rotate
    inputBinding:
      position: 102
      prefix: -ROTEXOH
  - id: rot_exist
    type:
      - 'null'
      - boolean
    doc: allow existing rotatable groups (OH, SH, Met-CH3) to rotate
    inputBinding:
      position: 102
      prefix: -ROTEXist
  - id: rot_nh3
    type:
      - 'null'
      - boolean
    doc: allow lysine NH3 to rotate (default)
    default: true
    inputBinding:
      position: 102
      prefix: -ROTNH3
  - id: segid_map
    type:
      - 'null'
      - string
    doc: assign chainID based on segment identifier field
    inputBinding:
      position: 102
      prefix: -SEGIDmap
  - id: show_score
    type:
      - 'null'
      - boolean
    doc: display scores for each orientation considered during processing
    inputBinding:
      position: 102
      prefix: -SHOWSCore
  - id: string_input
    type:
      - 'null'
      - string
    doc: pass reduce a string object from a script, must be quoted
    inputBinding:
      position: 102
      prefix: -STRING
  - id: trim
    type:
      - 'null'
      - boolean
    doc: remove (rather than add) hydrogens
    inputBinding:
      position: 102
      prefix: -Trim
  - id: xplor
    type:
      - 'null'
      - boolean
    doc: use Xplor conventions for naming polar hydrogens
    inputBinding:
      position: 102
      prefix: -Xplor
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ambertools:21.10
stdout: ambertools_reduce.out
