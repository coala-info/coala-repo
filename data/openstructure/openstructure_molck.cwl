cwlVersion: v1.2
class: CommandLineTool
baseCommand: molck
label: openstructure_molck
doc: "the molecule checker\n\nTool homepage: https://openstructure.org"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: Input PDB files
    inputBinding:
      position: 1
  - id: color
    type:
      - 'null'
      - string
    doc: Whether output should be colored.
    default: auto
    inputBinding:
      position: 102
      prefix: --color
  - id: complib
    type:
      - 'null'
      - string
    doc: 'Location of the compound library file. If not provided, the following locations
      are searched in this order: 1. Working directory, 2. OpenStructure standard
      library location (if the executable is part of a standard OpenStructure installation)'
    inputBinding:
      position: 102
      prefix: --complib
  - id: fix_ele
    type:
      - 'null'
      - boolean
    doc: Clean up element column
    inputBinding:
      position: 102
      prefix: --fix-ele
  - id: map_nonstd
    type:
      - 'null'
      - boolean
    doc: 'Maps modified residues back to the parent amino acid, for example: MSE ->
      MET, SEP -> SER.'
    inputBinding:
      position: 102
      prefix: --map-nonstd
  - id: rm
    type:
      - 'null'
      - string
    doc: 'Remove atoms and residues matching some criteria: - zeroocc - Remove atoms
      with zero occupancy - hyd - Remove hydrogen atoms - oxt - Remove terminal oxygens
      - nonstd - Remove all residues not one of the 20 standard amino acids - unk
      - Remove unknown atoms not following the nomenclature'
    default: hyd
    inputBinding:
      position: 102
      prefix: --rm
  - id: stdout
    type:
      - 'null'
      - boolean
    doc: Write cleaned file(s) to stdout
    inputBinding:
      position: 102
      prefix: --stdout
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Write cleaned file(s) to disk. % characters in the filename are 
      replaced with the basename of the input file without extension.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/openstructure:2.11.1--py310h1f7f436_0
