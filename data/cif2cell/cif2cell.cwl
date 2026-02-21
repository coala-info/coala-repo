cwlVersion: v1.2
class: CommandLineTool
baseCommand: cif2cell
label: cif2cell
doc: "A tool to generate the geometric setup for various electronic structure codes
  from a CIF (Crystallographic Information Framework) file.\n\nTool homepage: https://github.com/torbjornbjorkman/cif2cell"
inputs:
  - id: cif_file
    type: File
    doc: Input CIF file
    inputBinding:
      position: 1
  - id: k_resolution
    type:
      - 'null'
      - float
    doc: k-point resolution
    inputBinding:
      position: 102
      prefix: --k-resolution
  - id: program
    type:
      - 'null'
      - string
    doc: Target program (e.g., abinit, castep, crystal, espresso, mvasp, vasp, etc.)
    inputBinding:
      position: 102
      prefix: --program
  - id: setup_all
    type:
      - 'null'
      - boolean
    doc: Setup all files for the target program
    inputBinding:
      position: 102
      prefix: --setupall
  - id: supercell
    type:
      - 'null'
      - string
    doc: Generate a supercell (e.g., --supercell=[2,2,2])
    inputBinding:
      position: 102
      prefix: --supercell
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file name
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cif2cell:2.0.0a3
