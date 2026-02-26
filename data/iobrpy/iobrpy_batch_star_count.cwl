cwlVersion: v1.2
class: CommandLineTool
baseCommand: iobrpy batch_star_count
label: iobrpy_batch_star_count
doc: "Run STAR aligner in batches for multiple samples.\n\nTool homepage: https://github.com/IOBR/IOBRpy"
inputs:
  - id: batch_size
    type:
      - 'null'
      - int
    doc: '#samples per batch (sequential batches)'
    inputBinding:
      position: 101
      prefix: --batch_size
  - id: index
    type: Directory
    doc: STAR genome index directory
    inputBinding:
      position: 101
      prefix: --index
  - id: num_threads
    type:
      - 'null'
      - int
    doc: Threads for STAR and BAM sorting
    inputBinding:
      position: 101
      prefix: --num_threads
  - id: path_fq
    type: Directory
    doc: Folder containing FASTQs (R1 endswith suffix1)
    inputBinding:
      position: 101
      prefix: --path_fq
  - id: suffix1
    type:
      - 'null'
      - string
    doc: R1 suffix; R2 is inferred by 1→2
    inputBinding:
      position: 101
      prefix: --suffix1
outputs:
  - id: path_out
    type: Directory
    doc: Output folder for STAR results
    outputBinding:
      glob: $(inputs.path_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/iobrpy:0.1.7--pyhdfd78af_0
