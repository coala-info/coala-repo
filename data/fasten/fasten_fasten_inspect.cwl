cwlVersion: v1.2
class: CommandLineTool
baseCommand: fasten_inspect
label: fasten_fasten_inspect
doc: "Marks up your reads with useful information like read length\n\nTool homepage:
  https://github.com/lskatz/fasten"
inputs:
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
stdout: fasten_fasten_inspect.out
