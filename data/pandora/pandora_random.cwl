cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - /usr/local/bin/pandora
  - random
label: pandora_random
doc: "Outputs a fasta of random paths through the PRGs\n\nTool homepage: https://github.com/rmcolq/pandora"
inputs:
  - id: prg
    type: File
    doc: PRG to generate random paths from
    inputBinding:
      position: 1
  - id: compress
    type:
      - 'null'
      - boolean
    doc: Compress the output with gzip
    inputBinding:
      position: 102
      prefix: --compress
  - id: number_of_paths
    type:
      - 'null'
      - int
    doc: Number of paths to output
    inputBinding:
      position: 102
      prefix: -n
  - id: verbosity
    type:
      - 'null'
      - type: array
        items: boolean
    doc: Verbosity of logging. Repeat for increased verbosity
    inputBinding:
      position: 102
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pandora:0.9.2--h4ac6f70_0
stdout: pandora_random.out
