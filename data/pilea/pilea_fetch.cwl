cwlVersion: v1.2
class: CommandLineTool
baseCommand: pilea fetch
label: pilea_fetch
doc: "Fetch data from Pilea.\n\nTool homepage: https://github.com/xinehc/pilea"
inputs:
  - id: outdir
    type: Directory
    doc: Output directory.
    inputBinding:
      position: 101
      prefix: --outdir
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads.
    default: 20
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pilea:1.3.7--py312h4711d71_0
stdout: pilea_fetch.out
