cwlVersion: v1.2
class: CommandLineTool
baseCommand: mccortex
label: mccortex
doc: "Wrapper to find the correct mccortex binary given kmer size (K)\n\nTool homepage:
  https://github.com/mcveanlab/mccortex"
inputs:
  - id: kmer_size
    type: int
    doc: kmer size (K)
    inputBinding:
      position: 1
  - id: cmd
    type:
      - 'null'
      - type: array
        items: string
    doc: Additional commands to pass to the correct mccortex binary
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mccortex:1.0--h24782f9_7
stdout: mccortex.out
