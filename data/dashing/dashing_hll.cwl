cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - dashing
  - hll
label: dashing_hll
doc: "Estimate the number of unique k-mers in a set of sequence files with one HyperLogLog.\
  \ (-F, listed in the help, is rejected by this build.)\n\nTool homepage: https://github.com/dnbaker/dashing"
inputs:
  - id: paths
    type:
      type: array
      items: File
    doc: Sequence files
    inputBinding:
      position: 1
  - id: kmer_length
    type:
      - 'null'
      - int
    doc: 'kmer length (Default: 31. Max: 32)'
    inputBinding:
      position: 102
      prefix: -k
  - id: window_size
    type:
      - 'null'
      - int
    doc: 'window size (Default: -1)  Must be -1 (ignored) or >= kmer length.'
    inputBinding:
      position: 102
      prefix: -w
  - id: spacing
    type:
      - 'null'
      - string
    doc: 'spacing (default: none). format: <value>x<times>,<value>x<times>,... Omitting
      x<times> indicates 1 occurrence of spacing <value>'
    inputBinding:
      position: 102
      prefix: -s
  - id: sketch_size
    type:
      - 'null'
      - int
    doc: 'sketch size (default: 24). (Allocates 2 << [param] bytes of memory per HyperLogLog.'
    inputBinding:
      position: 102
      prefix: -S
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads.
    inputBinding:
      position: 102
      prefix: -p
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dashing:1.0--h5b0a936_3
stdout: dashing_hll.out
