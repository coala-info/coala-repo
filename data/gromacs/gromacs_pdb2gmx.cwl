cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gmx
  - pdb2gmx
label: gromacs_pdb2gmx
doc: "Convert a .pdb (or .gro) file to GROMACS format: adds hydrogens, generates coordinates and a topology.\n\nTool homepage: https://www.gromacs.org/"
inputs:
  - id: input_structure
    type: File
    doc: "Structure file: gro g96 pdb brk ent esp tpr (gmx default protein.pdb)"
    inputBinding:
      position: 101
      prefix: -f
  - id: output_structure
    type:
      - 'null'
      - string
    doc: "Output structure file: gro g96 pdb brk ent esp"
    default: conf.gro
    inputBinding:
      position: 101
      prefix: -o
  - id: topology
    type:
      - 'null'
      - string
    doc: "Output topology file"
    default: topol.top
    inputBinding:
      position: 101
      prefix: -p
  - id: posre_itp
    type:
      - 'null'
      - string
    doc: "Output include file with position restraints"
    default: posre.itp
    inputBinding:
      position: 101
      prefix: -i
  - id: index_output
    type:
      - 'null'
      - string
    doc: "Output index file (optional)"
    inputBinding:
      position: 101
      prefix: -n
  - id: cleaned_output
    type:
      - 'null'
      - string
    doc: "Output cleaned structure file (optional)"
    inputBinding:
      position: 101
      prefix: -q
  - id: chainsep
    type:
      - 'null'
      - string
    doc: "Condition in PDB files when a new chain should be started (adding termini): id_or_ter, id_and_ter, ter, id, interactive"
    inputBinding:
      position: 101
      prefix: -chainsep
  - id: merge
    type:
      - 'null'
      - string
    doc: "Merge multiple chains into a single [moleculetype]: no, all, interactive"
    inputBinding:
      position: 101
      prefix: -merge
  - id: ff
    type:
      - 'null'
      - string
    doc: "Force field, interactive by default. Use the short name of a <forcefield>.ff directory"
    inputBinding:
      position: 101
      prefix: -ff
  - id: water
    type:
      - 'null'
      - string
    doc: "Water model to use: select, none, spc, spce, tip3p, tip4p, tip5p, tips3p"
    inputBinding:
      position: 101
      prefix: -water
  - id: inter
    type:
      - 'null'
      - boolean
    doc: "Set the next 8 options to interactive"
    inputBinding:
      position: 101
      prefix: -inter
  - id: ss
    type:
      - 'null'
      - boolean
    doc: "Interactive SS bridge selection"
    inputBinding:
      position: 101
      prefix: -ss
  - id: ter
    type:
      - 'null'
      - boolean
    doc: "Interactive termini selection, instead of charged (default)"
    inputBinding:
      position: 101
      prefix: -ter
  - id: lys
    type:
      - 'null'
      - boolean
    doc: "Interactive lysine selection, instead of charged"
    inputBinding:
      position: 101
      prefix: -lys
  - id: arg
    type:
      - 'null'
      - boolean
    doc: "Interactive arginine selection, instead of charged"
    inputBinding:
      position: 101
      prefix: -arg
  - id: asp
    type:
      - 'null'
      - boolean
    doc: "Interactive aspartic acid selection, instead of charged"
    inputBinding:
      position: 101
      prefix: -asp
  - id: glu
    type:
      - 'null'
      - boolean
    doc: "Interactive glutamic acid selection, instead of charged"
    inputBinding:
      position: 101
      prefix: -glu
  - id: gln
    type:
      - 'null'
      - boolean
    doc: "Interactive glutamine selection, instead of charged"
    inputBinding:
      position: 101
      prefix: -gln
  - id: his
    type:
      - 'null'
      - boolean
    doc: "Interactive histidine selection, instead of checking H-bonds"
    inputBinding:
      position: 101
      prefix: -his
  - id: angle
    type:
      - 'null'
      - float
    doc: "Minimum hydrogen-donor-acceptor angle for a H-bond (degrees)"
    inputBinding:
      position: 101
      prefix: -angle
  - id: dist
    type:
      - 'null'
      - float
    doc: "Maximum donor-acceptor distance for a H-bond (nm)"
    inputBinding:
      position: 101
      prefix: -dist
  - id: una
    type:
      - 'null'
      - boolean
    doc: "Select aromatic rings with united CH atoms on phenylalanine, tryptophane and tyrosine"
    inputBinding:
      position: 101
      prefix: -una
  - id: ignh
    type:
      - 'null'
      - boolean
    doc: "Ignore hydrogen atoms that are in the coordinate file"
    inputBinding:
      position: 101
      prefix: -ignh
  - id: missing
    type:
      - 'null'
      - boolean
    doc: "Continue when atoms are missing and bonds cannot be made, dangerous"
    inputBinding:
      position: 101
      prefix: -missing
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Be slightly more verbose in messages"
    inputBinding:
      position: 101
      prefix: -v
  - id: posrefc
    type:
      - 'null'
      - float
    doc: "Force constant for position restraints"
    inputBinding:
      position: 101
      prefix: -posrefc
  - id: vsite
    type:
      - 'null'
      - string
    doc: "Convert atoms to virtual sites: none, hydrogens, aromatics"
    inputBinding:
      position: 101
      prefix: -vsite
  - id: heavyh
    type:
      - 'null'
      - boolean
    doc: "Make hydrogen atoms heavy"
    inputBinding:
      position: 101
      prefix: -heavyh
  - id: deuterate
    type:
      - 'null'
      - boolean
    doc: "Change the mass of hydrogens to 2 amu"
    inputBinding:
      position: 101
      prefix: -deuterate
  - id: no_chargegrp
    type:
      - 'null'
      - boolean
    doc: "Do not use charge groups in the .rtp file (default: use them)"
    inputBinding:
      position: 101
      prefix: -nochargegrp
  - id: no_cmap
    type:
      - 'null'
      - boolean
    doc: "Do not use cmap torsions (default: use them if enabled in the .rtp file)"
    inputBinding:
      position: 101
      prefix: -nocmap
  - id: renum
    type:
      - 'null'
      - boolean
    doc: "Renumber the residues consecutively in the output"
    inputBinding:
      position: 101
      prefix: -renum
  - id: rtpres
    type:
      - 'null'
      - boolean
    doc: "Use .rtp entry names as residue names"
    inputBinding:
      position: 101
      prefix: -rtpres
outputs:
  - id: output_structure_file
    type: File
    doc: "Processed structure file"
    outputBinding:
      glob: $(inputs.output_structure)
  - id: topology_file
    type: File
    doc: "Topology file"
    outputBinding:
      glob: $(inputs.topology)
  - id: posre_file
    type: File
    doc: "Position restraints include file"
    outputBinding:
      glob: $(inputs.posre_itp)
  - id: index_file
    type:
      - 'null'
      - File
    doc: "Index file"
    outputBinding:
      glob: $(inputs.index_output)
  - id: cleaned_file
    type:
      - 'null'
      - File
    doc: "Cleaned structure file"
    outputBinding:
      glob: $(inputs.cleaned_output)
  - id: stdout
    type: stdout
    doc: "Standard output"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gromacs:2022
stdout: gromacs_pdb2gmx.out
