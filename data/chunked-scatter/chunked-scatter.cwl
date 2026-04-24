cwlVersion: v1.2
class: CommandLineTool
baseCommand: chunked-scatter
label: chunked-scatter
doc: "Given a sequence dict, fasta index or a bed file, scatter over the defined contigs/regions.
  Each contig/region will be split into multiple overlapping regions, which will be
  written to a new bed file. Each contig will be placed in a new file, unless the
  length of the contigs/regions doesn't exceed a given number.\n\nTool homepage: https://github.com/biowdl/chunked-scatter"
inputs:
  - id: input
    type: File
    doc: "The input file. The format is detected by the extension. Supported extensions
      are: '.bed', '.dict', '.fai', '.vcf', '.vcf.gz', '.bcf'."
    inputBinding:
      position: 1
  - id: chunk_size
    type:
      - 'null'
      - int
    doc: The size of the chunks. The first chunk in a region or contig will be 
      exactly length SIZE, subsequent chunks will SIZE + OVERLAP and the final 
      chunk may be anywhere from 0.5 to 1.5 times SIZE plus overlap. If a region
      (or contig) is smaller than SIZE the original regions will be returned.
    inputBinding:
      position: 102
      prefix: --chunk-size
  - id: minimum_bp_per_file
    type:
      - 'null'
      - int
    doc: The minimum number of bases represented within a single output bed 
      file. If an input contig or region is smaller than this 
      MINIMUM_BP_PER_FILE, then the next contigs/regions will be placed in the 
      same file untill this minimum is met.
    inputBinding:
      position: 102
      prefix: --minimum-bp-per-file
  - id: overlap
    type:
      - 'null'
      - int
    doc: The number of bases which each chunk should overlap with the preceding 
      one.
    inputBinding:
      position: 102
      prefix: --overlap
  - id: prefix
    type:
      - 'null'
      - string
    doc: 'The prefix of the ouput files. Output will be named like: <PREFIX><N>.bed,
      in which N is an incrementing number.'
    inputBinding:
      position: 102
      prefix: --prefix
  - id: print_paths
    type:
      - 'null'
      - boolean
    doc: If set prints paths of the output files to STDOUT. This makes the 
      program usable in scripts and worfklows.
    inputBinding:
      position: 102
      prefix: --print-paths
  - id: split_contigs
    type:
      - 'null'
      - boolean
    doc: If set, contigs are allowed to be split up over multiple files.
    inputBinding:
      position: 102
      prefix: --split-contigs
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chunked-scatter:1.0.0--py_0
stdout: chunked-scatter.out
