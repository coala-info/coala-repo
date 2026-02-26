cwlVersion: v1.2
class: CommandLineTool
baseCommand: gunzip
label: ptgaul_gunzip
doc: "Decompress FILEs (or stdin)\n\nTool homepage: https://github.com/Bean061/ptgaul"
inputs:
  - id: files
    type:
      - 'null'
      - type: array
        items: File
    doc: Files to decompress
    inputBinding:
      position: 1
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force
    inputBinding:
      position: 102
      prefix: -f
  - id: keep
    type:
      - 'null'
      - boolean
    doc: Keep input files
    inputBinding:
      position: 102
      prefix: -k
  - id: test
    type:
      - 'null'
      - boolean
    doc: Test file integrity
    inputBinding:
      position: 102
      prefix: -t
outputs:
  - id: stdout
    type:
      - 'null'
      - File
    doc: Write to stdout
    outputBinding:
      glob: $(inputs.stdout)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ptgaul:1.0.5--pyhdfd78af_1
