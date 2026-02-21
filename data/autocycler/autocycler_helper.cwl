cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - autocycler
  - helper
label: autocycler_helper
doc: "helper commands for long-read assemblers\n\nTool homepage: https://github.com/rrwick/Autocycler"
inputs:
  - id: task
    type: string
    doc: 'Task (possible values: genome_size, canu, flye, hifiasm, lja, metamdbg,
      miniasm, myloasm, necat, nextdenovo, plassembler, raven, redbean)'
    inputBinding:
      position: 1
  - id: args
    type:
      - 'null'
      - type: array
        items: string
    doc: Additional arguments for the task
    inputBinding:
      position: 102
      prefix: --args
  - id: dir
    type:
      - 'null'
      - Directory
    doc: 'Working directory [default: use a temporary directory]'
    inputBinding:
      position: 102
      prefix: --dir
  - id: genome_size
    type:
      - 'null'
      - string
    doc: Estimated genome size (required for some tasks)
    inputBinding:
      position: 102
      prefix: --genome_size
  - id: min_depth_abs
    type:
      - 'null'
      - float
    doc: Exclude contigs with read depth less than this absolute value
    inputBinding:
      position: 102
      prefix: --min_depth_abs
  - id: min_depth_rel
    type:
      - 'null'
      - float
    doc: Exclude contigs with read depth less than this fraction of the longest contig's
      depth
    inputBinding:
      position: 102
      prefix: --min_depth_rel
  - id: read_type
    type:
      - 'null'
      - string
    doc: 'Read type [possible values: ont_r9, ont_r10, pacbio_clr, pacbio_hifi]'
    default: ont_r10
    inputBinding:
      position: 102
      prefix: --read_type
  - id: reads
    type: File
    doc: Input long reads in FASTQ format
    inputBinding:
      position: 102
      prefix: --reads
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of CPU threads
    default: 8
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: out_prefix
    type:
      - 'null'
      - File
    doc: Output prefix (required for all tasks except genome_size)
    outputBinding:
      glob: $(inputs.out_prefix)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/autocycler:0.5.2--h3ab6199_0
