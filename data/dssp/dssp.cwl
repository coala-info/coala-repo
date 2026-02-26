cwlVersion: v1.2
class: CommandLineTool
baseCommand: mkdssp
label: dssp
doc: "Calculate secondary structure for PDB or mmCIF files.\n\nTool homepage: https://github.com/PDB-REDO/dssp"
inputs:
  - id: debug
    type:
      - 'null'
      - int
    doc: Debug level (for even more verbose output)
    inputBinding:
      position: 101
      prefix: --debug
  - id: input_file
    type: File
    doc: Input PDB file (.pdb) or mmCIF file (.cif/.mcif), optionally compressed
      by gzip (.gz) or bzip2 (.bz2)
    inputBinding:
      position: 101
      prefix: --input
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file, optionally compressed by gzip (.gz) or bzip2 (.bz2). Use 
      'stdout' to output to screen
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/dssp:v3.0.0-3b1-deb_cv1
