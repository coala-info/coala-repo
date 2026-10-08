cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - scatter-regions
label: chunked-scatter_scatter-regions
doc: "Given a sequence dict, fasta index or a bed file, scatter over the defined contigs/regions.
  Creates a bed file where the contigs add up approximately to the given scatter size.\n\nTool
  homepage: https://github.com/biowdl/chunked-scatter"
inputs:
  - id: input
    type: File
    doc: "The input file. The format is detected by the extension. Supported extensions
      are: '.bed', '.dict', '.fai', '.vcf', '.vcf.gz', '.bcf'."
    inputBinding:
      position: 1
  - id: prefix
    type:
      - 'null'
      - string
    doc: 'The prefix of the output files. Output will be named like: <PREFIX><N>.bed,
      in which N is an incrementing number. Default ''scatter-''.'
    default: scatter-
    inputBinding:
      position: 102
      prefix: --prefix
  - id: split_contigs
    type:
      - 'null'
      - boolean
    doc: If set, contigs are allowed to be split up over multiple files.
    inputBinding:
      position: 102
      prefix: --split-contigs
  - id: print_paths
    type:
      - 'null'
      - boolean
    doc: If set prints paths of the output files to STDOUT. This makes the program
      usable in scripts and workflows.
    inputBinding:
      position: 102
      prefix: --print-paths
  - id: scatter_size
    type:
      - 'null'
      - long
    doc: The maximum size for the regions over which to scatter. If contigs are not
      split, and a contig is bigger than the maximum size, the contig will be placed
      in its own file. Default 1000000000.
    inputBinding:
      position: 102
      prefix: --scatter-size
outputs:
  - id: stdout
    type: stdout
    doc: Paths of the output files (when print_paths is set).
  - id: scatter_beds
    type:
      type: array
      items: File
    doc: BED files named <PREFIX><N>.bed, one per scatter group.
    outputBinding:
      glob: $(inputs.prefix)*.bed
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chunked-scatter:1.0.0--py_0
stdout: scatter-regions.out
