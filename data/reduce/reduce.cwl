cwlVersion: v1.2
class: CommandLineTool
baseCommand: reduce
label: reduce
doc: "Add hydrogens, correct geometry, and optimize sidechain conformations of protein
  structures.\n\nTool homepage: https://github.com/rlabduke/reduce"
inputs:
  - id: flags
    type:
      - 'null'
      - type: array
        items: string
    doc: Flags to control the behavior of reduce
    inputBinding:
      position: 1
  - id: filename
    type:
      - 'null'
      - File
    doc: Input PDB file or '-' to read from stdin
    inputBinding:
      position: 2
  - id: allalt
    type:
      - 'null'
      - boolean
    doc: Process adjustments for all conformations (default)
    inputBinding:
      position: 103
      prefix: -ALLALT
  - id: bad_ઇbumpcut
    type:
      - 'null'
      - float
    doc: At this gap a bump is 'bad'
    default: 0.4
    inputBinding:
      position: 103
      prefix: -BADBumpcut#.#
  - id: bbmodel
    type:
      - 'null'
      - boolean
    doc: Expects a backbone only model and will build HA hydrogens on Calpha 
      truncated residues
    inputBinding:
      position: 103
      prefix: -BBmodel
  - id: build
    type:
      - 'null'
      - boolean
    doc: Same as -FLIP
    inputBinding:
      position: 103
      prefix: -BUILD
  - id: changes
    type:
      - 'null'
      - boolean
    doc: Display the change log
    inputBinding:
      position: 103
      prefix: -Changes
  - id: charges
    type:
      - 'null'
      - boolean
    doc: Output charge state for appropriate hydrogen records
    inputBinding:
      position: 103
      prefix: -CHARGEs
  - id: db
    type:
      - 'null'
      - File
    doc: File to search for het info
    default: /usr/local/share/reduce/reduce_wwPDB_het_dict.txt
    inputBinding:
      position: 103
      prefix: -DB "filename"
  - id: density
    type:
      - 'null'
      - float
    doc: Dot density (in dots/A^2) for VDW calculations
    default: 16.0
    inputBinding:
      position: 103
      prefix: -DENSity#.#
  - id: drop_hydrogens_on_atom_records
    type:
      - 'null'
      - boolean
    doc: Drop hydrogens on incoming ATOM records before other processing
    inputBinding:
      position: 103
      prefix: -DROP_HYDROGENS_ON_ATOM_RECORDS
  - id: drop_hydrogens_on_other_records
    type:
      - 'null'
      - boolean
    doc: Drop hydrogens on incoming non-ATOM records before other processing
    inputBinding:
      position: 103
      prefix: -DROP_HYDROGENS_ON_OTHER_RECORDS
  - id: fix
    type:
      - 'null'
      - File
    doc: If given, file specifies orientations for adjustable groups
    inputBinding:
      position: 103
      prefix: -FIX "filename"
  - id: flip
    type:
      - 'null'
      - boolean
    doc: Add H and rotate and flip NQH groups
    inputBinding:
      position: 103
      prefix: -FLIP
  - id: h2obcutoff
    type:
      - 'null'
      - int
    doc: B-factor cutoff for water atoms
    default: 40
    inputBinding:
      position: 103
      prefix: -H2OBcutoff#
  - id: h2oocccutoff
    type:
      - 'null'
      - float
    doc: Occupancy cutoff for water atoms
    default: 0.66
    inputBinding:
      position: 103
      prefix: -H2OOCCcutoff#.#
  - id: hbchargedcut
    type:
      - 'null'
      - float
    doc: Over this gap charged HBonds bump
    default: 0.8
    inputBinding:
      position: 103
      prefix: -HBCHargedcut#.#
  - id: hbregcutoff
    type:
      - 'null'
      - float
    doc: Over this gap regular HBonds bump
    default: 0.6
    inputBinding:
      position: 103
      prefix: -HBREGcutoff#.#
  - id: his
    type:
      - 'null'
      - boolean
    doc: Create NH hydrogens on HIS rings (usually used with -HIS)
    inputBinding:
      position: 103
      prefix: -HIS
  - id: keep
    type:
      - 'null'
      - boolean
    doc: Keep bond lengths as found
    inputBinding:
      position: 103
      prefix: -Keep
  - id: limit
    type:
      - 'null'
      - int
    doc: Max seconds to spend in exhaustive search
    default: 600
    inputBinding:
      position: 103
      prefix: -LIMIT#
  - id: maxaromdih
    type:
      - 'null'
      - int
    doc: Dihedral angle cutoff for aromatic ring planarity check
    default: 10
    inputBinding:
      position: 103
      prefix: -MAXAromdih#
  - id: metalbump
    type:
      - 'null'
      - float
    doc: H 'bumps' metals at radius plus this
    default: 0.865
    inputBinding:
      position: 103
      prefix: -METALBump#.#
  - id: nbonds
    type:
      - 'null'
      - int
    doc: Remove dots if cause within n bonds
    default: 3
    inputBinding:
      position: 103
      prefix: -NBonds#
  - id: no_add_other_hydrogens
    type:
      - 'null'
      - boolean
    doc: Don't add hydrogens on incoming non-HOH records but do other processing
    inputBinding:
      position: 103
      prefix: -NO_ADD_OTHER_HYDROGENS
  - id: no_add_water_hydrogens
    type:
      - 'null'
      - boolean
    doc: Don't add hydrogens on incoming HOH records but do other processing
    inputBinding:
      position: 103
      prefix: -NO_ADD_WATER_HYDROGENS
  - id: noadjust
    type:
      - 'null'
      - boolean
    doc: Do not process any rot or flip adjustments
    inputBinding:
      position: 103
      prefix: -NOADJust
  - id: nobuild_penalty
    type:
      - 'null'
      - float
    doc: Build with a given penalty often 200 or 999
    inputBinding:
      position: 103
      prefix: -NOBUILD#.#
  - id: nocon
    type:
      - 'null'
      - boolean
    doc: Drop conect records
    inputBinding:
      position: 103
      prefix: -NOCon
  - id: noflip
    type:
      - 'null'
      - boolean
    doc: Add H and rotate groups with no NQH flips
    inputBinding:
      position: 103
      prefix: -NOFLIP
  - id: noheth
    type:
      - 'null'
      - boolean
    doc: Do not attempt to add NH proton on Het groups
    inputBinding:
      position: 103
      prefix: -NOHETh
  - id: nonmetalbump
    type:
      - 'null'
      - float
    doc: "'Bumps' nonmetal at radius plus this"
    default: 0.125
    inputBinding:
      position: 103
      prefix: -NONMETALBump#.#
  - id: nooh
    type:
      - 'null'
      - boolean
    doc: Remove hydrogens on OH and SH groups
    inputBinding:
      position: 103
      prefix: -NOOH
  - id: noopt
    type:
      - 'null'
      - boolean
    doc: Do not perform optimizations, only drop/add hydrogens
    inputBinding:
      position: 103
      prefix: -NOOPT
  - id: norotexist
    type:
      - 'null'
      - boolean
    doc: Do not allow existing rotatable groups (OH, SH, Met-CH3) to rotate
    inputBinding:
      position: 103
      prefix: -NOROTEXist
  - id: norotexoh
    type:
      - 'null'
      - boolean
    doc: Do not allow existing OH & SH groups to rotate
    inputBinding:
      position: 103
      prefix: -NOROTEXOH
  - id: norotnh3
    type:
      - 'null'
      - boolean
    doc: Do not allow lysine NH3 to rotate
    inputBinding:
      position: 103
      prefix: -NOROTNH3
  - id: noticks
    type:
      - 'null'
      - boolean
    doc: Do not display the set orientation ticker during processing
    inputBinding:
      position: 103
      prefix: -NOTICKs
  - id: nterm
    type:
      - 'null'
      - int
    doc: Max number of nterm residue
    default: 1
    inputBinding:
      position: 103
      prefix: -Nterm#
  - id: nuclear
    type:
      - 'null'
      - boolean
    doc: Use nuclear X-H distances rather than default electron cloud distances
    inputBinding:
      position: 103
      prefix: -NUClear
  - id: occcutoff
    type:
      - 'null'
      - float
    doc: Occupancy cutoff for adjustments
    default: 0.01
    inputBinding:
      position: 103
      prefix: -OCCcutoff#.#
  - id: oh
    type:
      - 'null'
      - boolean
    doc: Add hydrogens on OH and SH groups (default)
    inputBinding:
      position: 103
      prefix: -OH
  - id: oldpdb
    type:
      - 'null'
      - boolean
    doc: Use the pre-remediation names for hydrogens
    inputBinding:
      position: 103
      prefix: -OLDpdb
  - id: onlya
    type:
      - 'null'
      - boolean
    doc: Only adjust 'A' conformations
    inputBinding:
      position: 103
      prefix: -ONLYA
  - id: penalty
    type:
      - 'null'
      - float
    doc: Fraction of std. bias towards original orientation
    default: 1.0
    inputBinding:
      position: 103
      prefix: -PENalty#.#
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Do not write extra info to the console
    inputBinding:
      position: 103
      prefix: -Quiet
  - id: radius
    type:
      - 'null'
      - float
    doc: Probe radius (in A) for VDW calculations
    default: 0.25
    inputBinding:
      position: 103
      prefix: -RADius#.#
  - id: reference
    type:
      - 'null'
      - boolean
    doc: Display citation reference
    inputBinding:
      position: 103
      prefix: -REFerence
  - id: rotexist
    type:
      - 'null'
      - boolean
    doc: Allow existing rotatable groups (OH, SH, Met-CH3) to rotate (default)
    inputBinding:
      position: 103
      prefix: -ROTEXist
  - id: rotexoh
    type:
      - 'null'
      - boolean
    doc: Allow existing OH & SH groups to rotate (default)
    inputBinding:
      position: 103
      prefix: -ROTEXOH
  - id: rotnh3
    type:
      - 'null'
      - boolean
    doc: Allow lysine NH3 to rotate (default)
    inputBinding:
      position: 103
      prefix: -ROTNH3
  - id: segidmap
    type:
      - 'null'
      - string
    doc: Assign chainID based on segment identifier field
    inputBinding:
      position: 103
      prefix: -SEGIDmap "seg,c..."
  - id: showscore
    type:
      - 'null'
      - boolean
    doc: Display scores for each orientation considered during processing
    inputBinding:
      position: 103
      prefix: -SHOWSCore
  - id: string
    type:
      - 'null'
      - string
    doc: Pass reduce a string object from a script, must be quoted
    inputBinding:
      position: 103
      prefix: -STRING
  - id: trim
    type:
      - 'null'
      - boolean
    doc: Remove (rather than add) hydrogens and skip all optimizations
    inputBinding:
      position: 103
      prefix: -Trim
  - id: xplor
    type:
      - 'null'
      - boolean
    doc: Use Xplor conventions for naming polar hydrogens
    inputBinding:
      position: 103
      prefix: -Xplor
outputs:
  - id: dumpatoms_file
    type:
      - 'null'
      - File
    doc: Dump the atoms, along with extra information about them, to FILE
    outputBinding:
      glob: $(inputs.dumpatoms_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/reduce:4.15--py39h2de1943_4
