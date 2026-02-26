cwlVersion: v1.2
class: CommandLineTool
baseCommand: mmseqs
label: mmseqs2_mmseqs
doc: "MMseqs2 (Many against Many sequence searching) is an open-source software suite
  for very fast, parallelized protein sequence searches and clustering of huge protein
  sequence data sets.\n\nTool homepage: https://github.com/soedinglab/mmseqs2"
inputs:
  - id: command
    type: string
    doc: The MMseqs2 command to execute
    inputBinding:
      position: 1
  - id: args
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments for the specified command
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
stdout: mmseqs2_mmseqs.out
