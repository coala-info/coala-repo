cwlVersion: v1.2
class: CommandLineTool
baseCommand: allo
label: allo
doc: "Allo is a software that allocates multi-mapped reads in gene regulatory data.\n
  \nTool homepage: https://github.com/seqcode/allo"
inputs:
  - id: input
    type: File
    doc: Input alignment file
    inputBinding:
      position: 1
  - id: atac
    type:
      - 'null'
      - boolean
    doc: Use CNN trained on a ATAC-seq datasets
    inputBinding:
      position: 102
      prefix: --atac
  - id: dnase
    type:
      - 'null'
      - boolean
    doc: Use CNN trained on a DNase-seq datasets
    inputBinding:
      position: 102
      prefix: --dnase
  - id: ignore
    type:
      - 'null'
      - boolean
    doc: Ignore warnings about read sorting
    inputBinding:
      position: 102
      prefix: --ignore
  - id: keep_unmap
    type:
      - 'null'
      - boolean
    doc: Keep unmapped reads and reads that include N in their sequence
    inputBinding:
      position: 102
      prefix: --keep-unmap
  - id: max_locations
    type:
      - 'null'
      - int
    doc: Maximum value for number of locations a read can map
    inputBinding:
      position: 102
      prefix: -max
  - id: mixed
    type:
      - 'null'
      - boolean
    doc: Use CNN trained on a dataset with mixed ChIP-seq peaks, narrow by default
    inputBinding:
      position: 102
      prefix: --mixed
  - id: parser
    type:
      - 'null'
      - boolean
    doc: Parse alignment files to extract uniquely and multi-mapped reads
    inputBinding:
      position: 102
      prefix: --parser
  - id: processes
    type:
      - 'null'
      - int
    doc: Number of processes, 1 by default
    default: 1
    inputBinding:
      position: 102
      prefix: -p
  - id: r2
    type:
      - 'null'
      - boolean
    doc: Use read 2 for allocation procedure instead of read 1 (only for paired-end
      sequencing)
    inputBinding:
      position: 102
      prefix: --r2
  - id: random
    type:
      - 'null'
      - boolean
    doc: Reads will be randomly assigned (similar to Bowtie and BWA on default)
    inputBinding:
      position: 102
      prefix: --random
  - id: readcount
    type:
      - 'null'
      - boolean
    doc: CNN will not be used in allocation, only read counts
    inputBinding:
      position: 102
      prefix: --readcount
  - id: remove_zeros
    type:
      - 'null'
      - boolean
    doc: Disregard multi-mapped reads that map to regions with 0 uniquely mapped reads
      (random assignment)
    inputBinding:
      position: 102
      prefix: --remove-zeros
  - id: sequencing_mode
    type: string
    doc: Single-end or paired-end sequencing mode (pe or se)
    inputBinding:
      position: 102
      prefix: -seq
  - id: splice
    type:
      - 'null'
      - boolean
    doc: Remove splice sites based on cigar string when constructing image
    inputBinding:
      position: 102
      prefix: --splice
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: Output file name
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/allo:1.2.0--pyhdfd78af_0
