cwlVersion: v1.2
class: CommandLineTool
baseCommand: fasten_repair
label: fasten_fasten_repair
doc: "Repairs reads\n\nTool homepage: https://github.com/lskatz/fasten"
inputs:
  - id: min_length
    type:
      - 'null'
      - int
    doc: Minimum read length allowed
    inputBinding:
      position: 101
      prefix: --min-length
  - id: min_quality
    type:
      - 'null'
      - float
    doc: Minimum quality allowed
    inputBinding:
      position: 101
      prefix: --min-quality
  - id: mode
    type:
      - 'null'
      - string
    doc: Either repair or panic. If panic, then the binary will panic when the 
      first issue comes up.
    default: repair
    inputBinding:
      position: 101
      prefix: --mode
  - id: numcpus
    type:
      - 'null'
      - int
    doc: Number of CPUs
    default: 1
    inputBinding:
      position: 101
      prefix: --numcpus
  - id: paired_end
    type:
      - 'null'
      - boolean
    doc: The input reads are interleaved paired-end
    inputBinding:
      position: 101
      prefix: --paired-end
  - id: remove_info
    type:
      - 'null'
      - boolean
    doc: Remove fasten_inspect headers
    inputBinding:
      position: 101
      prefix: --remove-info
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print more status messages
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fasten:0.9.0--hc1c3326_0
stdout: fasten_fasten_repair.out
