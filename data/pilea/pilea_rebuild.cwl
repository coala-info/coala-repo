cwlVersion: v1.2
class: CommandLineTool
baseCommand: pilea rebuild
label: pilea_rebuild
doc: "Rebuilds a sketch database.\n\nTool homepage: https://github.com/xinehc/pilea"
inputs:
  - id: kmer
    type:
      - 'null'
      - int
    doc: K-mer size.
    default: 31
    inputBinding:
      position: 101
      prefix: --kmer
  - id: outdir
    type: Directory
    doc: Output directory.
    inputBinding:
      position: 101
      prefix: --outdir
  - id: scale
    type:
      - 'null'
      - int
    doc: Scale for downsampling.
    default: 250
    inputBinding:
      position: 101
      prefix: --scale
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads.
    default: 20
    inputBinding:
      position: 101
      prefix: --threads
  - id: window
    type:
      - 'null'
      - int
    doc: Window size for k-mer grouping.
    default: 25000
    inputBinding:
      position: 101
      prefix: --window
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pilea:1.3.7--py312h4711d71_0
stdout: pilea_rebuild.out
