cwlVersion: v1.2
class: CommandLineTool
baseCommand: extractSplitReads_BwaMem
label: lumpy-sv_extractSplitReads_BwaMem
doc: "Get split-read alignments from bwa-mem in LUMPY compatible format. Ignores reads marked as duplicates. Works on read or position sorted SAM input.\n\nTool homepage: https://github.com/arq5x/lumpy-sv"
inputs:
  - id: in_file
    type: File
    doc: A SAM file (use stdin by piping is not supported here)
    inputBinding:
      position: 1
      prefix: -i
  - id: num_splits
    type:
      - 'null'
      - int
    doc: The maximum number of split-read mappings to allow per read. Reads with more are excluded. Default=2
    inputBinding:
      position: 1
      prefix: -n
  - id: include_dups
    type:
      - 'null'
      - boolean
    doc: Include alignments marked as duplicates. Default=False
    inputBinding:
      position: 1
      prefix: -d
  - id: min_non_overlap
    type:
      - 'null'
      - int
    doc: Minimum non-overlap between split alignments on the query (default=20)
    inputBinding:
      position: 1
      prefix: -m
outputs:
  - id: split_reads
    type: stdout
    doc: Split-read alignments in SAM format
stdout: split_reads.sam
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lumpy-sv:0.3.1--3
