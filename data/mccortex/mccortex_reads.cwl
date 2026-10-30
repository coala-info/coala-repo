cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mccortex31
  - reads
label: mccortex_reads
doc: "Filter reads by whether they have a k-mer in the graph. If either read of a pair touches the graph, both are printed.\n\nThis wrapper runs the k<=31 binary (mccortex31). The same command exists in mccortex63 (k<=63), mccortex95 (k<=95) and mccortex127 (k<=127) with the same options; use those binaries for larger k-mer sizes.\n\nTool homepage: https://github.com/mcveanlab/mccortex"
requirements:
  - class: SchemaDefRequirement
    types:
      - name: SeqOut
        type: record
        fields:
          - name: reads
            type: File
          - name: out_prefix
            type: string
      - name: PairedOut
        type: record
        fields:
          - name: read1
            type: File
          - name: read2
            type: File
          - name: out_prefix
            type: string
inputs:
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Silence status output normally printed to STDERR.
    inputBinding:
      position: 1
      prefix: --quiet
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite output files if they already exist.
    inputBinding:
      position: 1
      prefix: --force
  - id: memory
    type:
      - 'null'
      - string
    doc: Memory to use (for example 1GB, 500M, 20GB). Default 1GB.
    inputBinding:
      position: 1
      prefix: --memory
  - id: nkmers
    type:
      - 'null'
      - string
    doc: Number of hash table entries (for example 4M, 1G). Default 4M.
    inputBinding:
      position: 1
      prefix: --nkmers
  - id: threads
    type:
      - 'null'
      - int
    doc: Limit on processing threads (default 2).
    inputBinding:
      position: 1
      prefix: --threads
  - id: format
    type:
      - 'null'
      - string
    doc: 'Output format: FASTA or FASTQ (default FASTQ).'
    inputBinding:
      position: 1
      prefix: --format
  - id: invert
    type:
      - 'null'
      - boolean
    doc: Print reads or read pairs with no k-mer in the graph.
    inputBinding:
      position: 1
      prefix: --invert
  - id: seq
    type:
      - 'null'
      - type: array
        items: SeqOut
        inputBinding:
          prefix: --seq
          valueFrom: $(self.reads.path):$(self.out_prefix)
    doc: 'Filter reads: records of an input file (reads) and an output prefix. Output is <out_prefix>.fq.gz.'
    inputBinding:
      position: 20
  - id: seq2
    type:
      - 'null'
      - type: array
        items: PairedOut
        inputBinding:
          prefix: --seq2
          valueFrom: $(self.read1.path):$(self.read2.path):$(self.out_prefix)
    doc: 'Filter paired reads: records of two input files and an output prefix. Output is <out_prefix>.1.fq.gz and <out_prefix>.2.fq.gz.'
    inputBinding:
      position: 21
  - id: seqi
    type:
      - 'null'
      - type: array
        items: SeqOut
        inputBinding:
          prefix: --seqi
          valueFrom: $(self.reads.path):$(self.out_prefix)
    doc: 'Filter paired reads from one interleaved file or BAM: records of an input file (reads) and an output prefix.'
    inputBinding:
      position: 22
  - id: graph
    type:
      type: array
      items: File
    doc: Input cortex graph file(s) (.ctx). The form file.ctx:cols is not available.
    inputBinding:
      position: 100
outputs:
  - id: filtered
    type: File[]
    doc: Filtered read files.
    outputBinding:
      glob:
        - '*.fq.gz'
        - '*.fa.gz'
        - '*.txt.gz'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mccortex:1.0--h24782f9_7
