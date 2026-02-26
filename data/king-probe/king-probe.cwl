cwlVersion: v1.2
class: CommandLineTool
baseCommand: probe
label: king-probe
doc: "Calculates probe-based interactions and surfaces for molecular structures.\n\
  \nTool homepage: http://people.virginia.edu/~wc9c/KING/"
inputs:
  - id: input_pdb
    type:
      - 'null'
      - File
    doc: Input PDB file for direct output redirection.
    inputBinding:
      position: 1
  - id: src_pattern
    type:
      - 'null'
      - string
    doc: Source pattern for selection (quoted).
    inputBinding:
      position: 2
  - id: target_pattern
    type:
      - 'null'
      - string
    doc: Target pattern for selection (quoted).
    inputBinding:
      position: 3
  - id: pdbfiles
    type:
      - 'null'
      - type: array
        items: File
    doc: Input PDB files for processing.
    inputBinding:
      position: 4
  - id: access
    type:
      - 'null'
      - boolean
    doc: 'Same as: -drop -rad0.0 -add1.4 -out (note: user supplies pattern).'
    inputBinding:
      position: 105
      prefix: -ACCESS
  - id: add_lens_keyword
    type:
      - 'null'
      - boolean
    doc: Add lens keyword to kin file.
    inputBinding:
      position: 105
      prefix: -LENs
  - id: add_vdw_offset
    type:
      - 'null'
      - float
    doc: Offset added to Van der Waals radii (default 0.0).
    default: 0.0
    inputBinding:
      position: 105
      prefix: -ADDvdw
  - id: asurface
    type:
      - 'null'
      - boolean
    doc: 'Same as: -drop -rad0.0 -add1.4 -out "not water".'
    inputBinding:
      position: 105
      prefix: -ASurface
  - id: atom_color
    type:
      - 'null'
      - boolean
    doc: Color dots by atom type.
    inputBinding:
      position: 105
      prefix: -ATOMcolor
  - id: autobondrot_file
    type:
      - 'null'
      - File
    doc: Read and process an autobondrot file.
    inputBinding:
      position: 105
      prefix: -AUTObondrot
  - id: base_color
    type:
      - 'null'
      - boolean
    doc: Color dots by nucleic acid base type.
    inputBinding:
      position: 105
      prefix: -BASEcolor
  - id: both_intersection
    type:
      - 'null'
      - boolean
    doc: 'Intersect both ways: src <=> targ.'
    inputBinding:
      position: 105
      prefix: -Both
  - id: bump_scoring_weight
    type:
      - 'null'
      - float
    doc: Set relative scale for scoring bumps (default 10.0).
    default: 10.0
    inputBinding:
      position: 105
      prefix: -BUMPWeight
  - id: color_base_gap
    type:
      - 'null'
      - boolean
    doc: Color dots by gap and nucleic acid base type.
    inputBinding:
      position: 105
      prefix: -COLORBase
  - id: condensed_unformatted_output
    type:
      - 'null'
      - boolean
    doc: Raw output in condensed format, i.e. one line per source->target atom. 
      Also gives the dot count for that interaction. Works only with -Unformated
      flag.
    inputBinding:
      position: 105
      prefix: -CONdense
  - id: coscale_vdw
    type:
      - 'null'
      - float
    doc: Scale C=O carbon Van der Waals radii (default 0.94).
    default: 0.94
    inputBinding:
      position: 105
      prefix: -COSCale
  - id: count_dots
    type:
      - 'null'
      - boolean
    doc: Produce a count of dots-not a dotlist.
    inputBinding:
      position: 105
      prefix: -Countdots
  - id: defaults
    type:
      - 'null'
      - boolean
    doc: 'Same as: -4H -mc -het -self "altA ogt33", but allows some other flags.'
    inputBinding:
      position: 105
      prefix: -DEFAULTs
  - id: display_changes
    type:
      - 'null'
      - boolean
    doc: Display a list of program changes.
    inputBinding:
      position: 105
      prefix: -CHANGEs
  - id: display_reference
    type:
      - 'null'
      - boolean
    doc: Display reference string.
    inputBinding:
      position: 105
      prefix: -REFerence
  - id: division_high_contact
    type:
      - 'null'
      - float
    doc: Division for Contact categories (default 0.25).
    default: 0.25
    inputBinding:
      position: 105
      prefix: -DIVHigh
  - id: division_low_bump
    type:
      - 'null'
      - float
    doc: Division for Bump categories (default -0.4).
    default: -0.4
    inputBinding:
      position: 105
      prefix: -DIVLow
  - id: division_worse_clash
    type:
      - 'null'
      - float
    doc: Division for regarding a clash as a worse clash (default -0.5).
    default: -0.5
    inputBinding:
      position: 105
      prefix: -DIVWorse
  - id: dot_density
    type:
      - 'null'
      - int
    doc: Set dot density (default 16 dots/sq A).
    default: 16
    inputBinding:
      position: 105
      prefix: -DEnsity
  - id: dotmaster_group
    type:
      - 'null'
      - boolean
    doc: Group name used as extra master={name} on lists.
    inputBinding:
      position: 105
      prefix: -DOTMASTER
  - id: drop_nonselected
    type:
      - 'null'
      - boolean
    doc: Drop nonselected atoms.
    inputBinding:
      position: 105
      prefix: -DRop
  - id: dump_atom_info
    type:
      - 'null'
      - boolean
    doc: 'Count the atoms in the selection: src.'
    inputBinding:
      position: 105
      prefix: -DUMPAtominfo
  - id: dump_dots_examine
    type:
      - 'null'
      - boolean
    doc: Dump dot info while doing examineDots().
    inputBinding:
      position: 105
      prefix: -DOTDUMP
  - id: dump_water_h_vectors
    type:
      - 'null'
      - boolean
    doc: Include water H? vectorlist in output.
    inputBinding:
      position: 105
      prefix: -DUMPH2O
  - id: element_master_buttons
    type:
      - 'null'
      - boolean
    doc: Add master buttons for different elements in kin output.
    inputBinding:
      position: 105
      prefix: -ELEMent
  - id: exclude_het_dots
    type:
      - 'null'
      - boolean
    doc: Exclude dots to non-water HET groups.
    inputBinding:
      position: 105
      prefix: -NOHETs
  - id: exclude_water_dots
    type:
      - 'null'
      - boolean
    doc: Exclude dots to water.
    inputBinding:
      position: 105
      prefix: -NOWATers
  - id: expanded_help
    type:
      - 'null'
      - boolean
    doc: Show expanded help notice (includes other flags).
    inputBinding:
      position: 105
      prefix: -Help
  - id: explicit_hydrogens
    type:
      - 'null'
      - boolean
    doc: Explicit hydrogens (default).
    default: true
    inputBinding:
      position: 105
      prefix: -Explicit
  - id: exposed
    type:
      - 'null'
      - boolean
    doc: 'Same as: -drop -rad1.4 -out (note: user supplies pattern).'
    inputBinding:
      position: 105
      prefix: -EXPOsed
  - id: extend_bond_chain_h
    type:
      - 'null'
      - boolean
    doc: Extend bond chain dot removal to 4 for H (default).
    default: true
    inputBinding:
      position: 105
      prefix: -4H
  - id: external_surface
    type:
      - 'null'
      - boolean
    doc: External van der Waals surface of src (solvent contact surface).
    inputBinding:
      position: 105
      prefix: -OUt
  - id: filter_nearest
    type:
      - 'null'
      - boolean
    doc: Apply 3rd selection on neighbor. e.g. -nearest -filternearest patt1 all
      patt3.
    inputBinding:
      position: 105
      prefix: -FILTERnearest
  - id: gap_bins
    type:
      - 'null'
      - boolean
    doc: 2nd pointmaster character, -.5...0...+.5.
    inputBinding:
      position: 105
      prefix: -GAPBINs
  - id: gap_color
    type:
      - 'null'
      - boolean
    doc: Color dots by gap amount (default).
    default: true
    inputBinding:
      position: 105
      prefix: -GAPcolor
  - id: gap_scoring_weight
    type:
      - 'null'
      - float
    doc: Set weight for scoring gaps (default 0.25).
    default: 0.25
    inputBinding:
      position: 105
      prefix: -GAPWeight
  - id: group_name
    type:
      - 'null'
      - string
    doc: Specify the group name (default "dots").
    default: dots
    inputBinding:
      position: 105
      prefix: -Name
  - id: hbond_scoring_weight
    type:
      - 'null'
      - float
    doc: Set relative scale for scoring Hbonds (default 4.0).
    default: 4.0
    inputBinding:
      position: 105
      prefix: -HBWeight
  - id: ignore_pattern
    type:
      - 'null'
      - string
    doc: 'Explicit drop: ignore atoms selected by pattern.'
    inputBinding:
      position: 105
      prefix: -IGNORE
  - id: implicit_hydrogens
    type:
      - 'null'
      - boolean
    doc: Implicit hydrogens.
    inputBinding:
      position: 105
      prefix: -Implicit
  - id: include_het_dots
    type:
      - 'null'
      - boolean
    doc: Include dots to non-water HET groups (default).
    default: true
    inputBinding:
      position: 105
      prefix: -HETs
  - id: include_mainchain_interactions
    type:
      - 'null'
      - boolean
    doc: Include mainchain->mainchain interactions.
    inputBinding:
      position: 105
      prefix: -MC
  - id: include_water_dots
    type:
      - 'null'
      - boolean
    doc: Include dots to water (default).
    default: true
    inputBinding:
      position: 105
      prefix: -WATERS
  - id: keep_nonselected
    type:
      - 'null'
      - boolean
    doc: Keep nonselected atoms (default).
    default: true
    inputBinding:
      position: 105
      prefix: -Keep
  - id: kinemage_header
    type:
      - 'null'
      - boolean
    doc: Add @kinemage 1 statement to top of .kin format output.
    inputBinding:
      position: 105
      prefix: -KINemage
  - id: limit_bond_chain_h_to_1
    type:
      - 'null'
      - boolean
    doc: Limit bond chain dot removal to 1.
    inputBinding:
      position: 105
      prefix: '-1'
  - id: limit_bond_chain_h_to_2
    type:
      - 'null'
      - boolean
    doc: Limit bond chain dot removal to 2.
    inputBinding:
      position: 105
      prefix: '-2'
  - id: limit_bond_chain_h_to_3
    type:
      - 'null'
      - boolean
    doc: Limit bond chain dot removal to 3.
    inputBinding:
      position: 105
      prefix: '-3'
  - id: limit_bump_dots
    type:
      - 'null'
      - boolean
    doc: Limit bump dots to max dist when kissing (default).
    default: true
    inputBinding:
      position: 105
      prefix: -LIMit
  - id: max_overlap_charged_hbonds
    type:
      - 'null'
      - float
    doc: Max overlap for charged Hbonds (default=0.8).
    default: 0.8
    inputBinding:
      position: 105
      prefix: -HBCharged
  - id: max_overlap_regular_hbonds
    type:
      - 'null'
      - float
    doc: Max overlap for regular Hbonds (default=0.6).
    default: 0.6
    inputBinding:
      position: 105
      prefix: -HBRegular
  - id: min_occupancy
    type:
      - 'null'
      - float
    doc: Occupancy below this is same as zero (default 0.02).
    default: 0.02
    inputBinding:
      position: 105
      prefix: -MINOCCupancy
  - id: nearest_neighbor
    type:
      - 'null'
      - boolean
    doc: Apply selection only on nearest neighbor.
    inputBinding:
      position: 105
      prefix: -NEAREST
  - id: no_alt_filter
    type:
      - 'null'
      - boolean
    doc: Final filter exclude any alts.
    inputBinding:
      position: 105
      prefix: -NOALTfilter
  - id: no_clash_output
    type:
      - 'null'
      - boolean
    doc: Do not output contacts for clashes.
    inputBinding:
      position: 105
      prefix: -NOCLASHOUT
  - id: no_face_hbond
    type:
      - 'null'
      - boolean
    doc: Do not identify HBonds to aromatic faces.
    inputBinding:
      position: 105
      prefix: -NOFACEhbond
  - id: no_group_statement
    type:
      - 'null'
      - boolean
    doc: Do not generate @group statement in .kin format output.
    inputBinding:
      position: 105
      prefix: -NOGroup
  - id: no_hbond_output
    type:
      - 'null'
      - boolean
    doc: Do not output contacts for HBonds.
    inputBinding:
      position: 105
      prefix: -NOHBOUT
  - id: no_lens_keyword
    type:
      - 'null'
      - boolean
    doc: Do not add lens keyword to kin file (default).
    default: true
    inputBinding:
      position: 105
      prefix: -NOLENs
  - id: no_limit_bump_dots
    type:
      - 'null'
      - boolean
    doc: Do not limit bump dots.
    inputBinding:
      position: 105
      prefix: -NOLIMit
  - id: no_parent_bonding
    type:
      - 'null'
      - boolean
    doc: Do not bond hydrogens based on table of parent heavy atoms.
    inputBinding:
      position: 105
      prefix: -NOPARENT
  - id: no_polar_hydrogens
    type:
      - 'null'
      - boolean
    doc: Do not shorten radii of polar hydrogens.
    inputBinding:
      position: 105
      prefix: -NOPolarH
  - id: no_residue_ticker
    type:
      - 'null'
      - boolean
    doc: Do not display the residue name ticker during processing.
    inputBinding:
      position: 105
      prefix: -NOTICKs
  - id: no_spike
    type:
      - 'null'
      - boolean
    doc: Draw only dots.
    inputBinding:
      position: 105
      prefix: -NOSpike
  - id: no_vdw_output
    type:
      - 'null'
      - boolean
    doc: Do not output contacts for van der Waals interactions.
    inputBinding:
      position: 105
      prefix: -NOVDWOUT
  - id: nuclear_vdw_radii
    type:
      - 'null'
      - boolean
    doc: Use nuclear position vdW radii (default is electron cloud positions).
    inputBinding:
      position: 105
      prefix: -NUClear
  - id: occ1_filter
    type:
      - 'null'
      - boolean
    doc: Final filter exclude any w occ < 1.
    inputBinding:
      position: 105
      prefix: -OCC1filter
  - id: oformat_output
    type:
      - 'null'
      - boolean
    doc: Output dot info formatted for display in O.
    inputBinding:
      position: 105
      prefix: -OFORMAT
  - id: old_u_output
    type:
      - 'null'
      - boolean
    doc: 'Generate old style -u output: kissEdge2BullsEye, etc.'
    inputBinding:
      position: 105
      prefix: -OLDU
  - id: once_intersection
    type:
      - 'null'
      - boolean
    doc: 'Single intersection: src -> targ.'
    inputBinding:
      position: 105
      prefix: -ONCe
  - id: onedot_each
    type:
      - 'null'
      - boolean
    doc: 'Output one dot for each src-to-neighbor. With -Unformated flag: for H gives
      angle parent-src-cause.'
    inputBinding:
      position: 105
      prefix: -ONEDOTeach
  - id: oneline_output
    type:
      - 'null'
      - boolean
    doc: Output one line :contacts:by:severity:type:.
    inputBinding:
      position: 105
      prefix: -ONELINE
  - id: oneline_summary
    type:
      - 'null'
      - boolean
    doc: Output summary list on oneline.
    inputBinding:
      position: 105
      prefix: -ONELINE
  - id: only_bad_clashes_output
    type:
      - 'null'
      - boolean
    doc: Onlybadout output bad clashes (severe overlap contacts).
    inputBinding:
      position: 105
      prefix: -ONLYBADOUT
  - id: outcolor_name
    type:
      - 'null'
      - string
    doc: Specify the point color for -OUT (default "gray").
    default: gray
    inputBinding:
      position: 105
      prefix: -OUTCOLor
  - id: polar_hydrogens
    type:
      - 'null'
      - boolean
    doc: Use short radii of polar hydrogens (default).
    default: true
    inputBinding:
      position: 105
      prefix: -PolarH
  - id: probe_radius
    type:
      - 'null'
      - float
    doc: Set probe radius (default 0.25 A).
    default: 0.25
    inputBinding:
      position: 105
      prefix: -Radius
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Quiet mode.
    inputBinding:
      position: 105
      prefix: -Quiet
  - id: recognize_cho_hbonds
    type:
      - 'null'
      - boolean
    doc: Recognize CH..O Hbonds.
    inputBinding:
      position: 105
      prefix: -DOCHO
  - id: scale_cho_hbond_score
    type:
      - 'null'
      - float
    doc: Scale factor for CH..O Hbond score (default=0.5).
    default: 0.5
    inputBinding:
      position: 105
      prefix: -CHO
  - id: scale_vdw
    type:
      - 'null'
      - float
    doc: Scale factor for Van der Waals radii (default 1.0).
    default: 1.0
    inputBinding:
      position: 105
      prefix: -SCALEvdw
  - id: scan0
    type:
      - 'null'
      - boolean
    doc: 'Same as: -4H -mc -self "alta blt40 ogt33".'
    inputBinding:
      position: 105
      prefix: -SCAN0
  - id: scan1
    type:
      - 'null'
      - boolean
    doc: 'Same as: -4H -once "sc alta blt40 ogt33" "alta blt40 ogt65,(not water ogt33)".'
    inputBinding:
      position: 105
      prefix: -SCAN1
  - id: scsurface
    type:
      - 'null'
      - boolean
    doc: 'Same as: -drop -rad1.4 -out "not water".'
    inputBinding:
      position: 105
      prefix: -SCSurface
  - id: self_intersection
    type:
      - 'null'
      - boolean
    doc: 'Self intersection: src -> src (default).'
    inputBinding:
      position: 105
      prefix: -SElf
  - id: separate_worse_clashes
    type:
      - 'null'
      - boolean
    doc: To separate bad overlaps and worse overlaps (default false, if true, 
      deafult value to separate the worse clashes is -0.5).
    default: false
    inputBinding:
      position: 105
      prefix: -SEPWORSE
  - id: show_water_dots
    type:
      - 'null'
      - boolean
    doc: Show dots between waters.
    inputBinding:
      position: 105
      prefix: -WAT2wat
  - id: spike
    type:
      - 'null'
      - boolean
    doc: Draw spike instead of dots (default).
    default: true
    inputBinding:
      position: 105
      prefix: -SPike
  - id: spike_scale
    type:
      - 'null'
      - float
    doc: Set spike scale (default=0.5).
    default: 0.5
    inputBinding:
      position: 105
      prefix: -SPike
  - id: standard_bonding_patterns
    type:
      - 'null'
      - boolean
    doc: Assume only standard bonding patterns in standard residues.
    inputBinding:
      position: 105
      prefix: -STDBONDs
  - id: summary_output
    type:
      - 'null'
      - boolean
    doc: Output summary list of contacts and clashes.
    inputBinding:
      position: 105
      prefix: -SUMMARY
  - id: unformatted_output
    type:
      - 'null'
      - boolean
    doc: Output raw dot info.
    inputBinding:
      position: 105
      prefix: -Unformated
  - id: use_segid
    type:
      - 'null'
      - boolean
    doc: Use the PDB SegID field to discriminate between residues.
    inputBinding:
      position: 105
      prefix: -SEGID
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose mode (default).
    default: true
    inputBinding:
      position: 105
      prefix: -VErbose
  - id: xvformat_output
    type:
      - 'null'
      - boolean
    doc: Output dot info formatted for display in XtalView.
    inputBinding:
      position: 105
      prefix: -XVFORMAT
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      biocontainers/king-probe:v2.16.160404git20180613.a09b012-1-deb_cv1
stdout: king-probe.out
