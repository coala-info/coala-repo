cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mccortex31
  - build
label: mccortex_build
doc: "Build a cortex graph from FASTA, FASTQ or BAM sequence.\n\nThis wrapper runs the k<=31 binary (mccortex31). The same command exists in mccortex63 (k<=63), mccortex95 (k<=95) and mccortex127 (k<=127) with the same options; use those binaries for larger k-mer sizes.\n\nTool homepage: https://github.com/mcveanlab/mccortex"
requirements:
  - class: SchemaDefRequirement
    types:
      - name: PairedReads
        type: record
        fields:
          - name: read1
            type: File
          - name: read2
            type: File
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
  - id: kmer
    type:
      - 'null'
      - int
    doc: Kmer size, odd (31 >= k >= 3).
    inputBinding:
      position: 1
      prefix: --kmer
  - id: fq_cutoff
    type:
      - 'null'
      - int
    doc: Filter quality scores (default 0, off).
    inputBinding:
      position: 1
      prefix: --fq-cutoff
  - id: fq_offset
    type:
      - 'null'
      - int
    doc: FASTQ ASCII offset (default 0, auto-detect).
    inputBinding:
      position: 1
      prefix: --fq-offset
  - id: cut_hp
    type:
      - 'null'
      - int
    doc: Break reads at homopolymers of at least this many bases (default off).
    inputBinding:
      position: 1
      prefix: --cut-hp
  - id: remove_pcr
    type:
      - 'null'
      - boolean
    doc: Remove PCR duplicate reads (reads starting at the same k-mer as an earlier read).
    inputBinding:
      position: 1
      prefix: --remove-pcr
  - id: keep_pcr
    type:
      - 'null'
      - boolean
    doc: Do not remove PCR duplicates (default).
    inputBinding:
      position: 1
      prefix: --keep-pcr
  - id: matepair
    type:
      - 'null'
      - string
    doc: 'Mate pair orientation: FF, FR, RF or RR (default FR; only with --keep-pcr).'
    inputBinding:
      position: 1
      prefix: --matepair
  - id: intersect
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: --intersect
    doc: Only load k-mers that appear in this graph. Several graphs are merged, not intersected; they are treated as single colour graphs.
    inputBinding:
      position: 1
  - id: sort
    type:
      - 'null'
      - boolean
    doc: Output a graph file ordered by k-mer.
    inputBinding:
      position: 1
      prefix: --sort
  - id: sample
    type: string
    doc: Sample name (required before any sequence input).
    inputBinding:
      position: 19
      prefix: --sample
  - id: seq
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: --seq
    doc: Load sequence data (FASTA, FASTQ, SAM or BAM; can be gzipped).
    inputBinding:
      position: 20
  - id: seq2
    type:
      - 'null'
      - type: array
        items: PairedReads
        inputBinding:
          prefix: --seq2
          valueFrom: $(self.read1.path):$(self.read2.path)
    doc: Load paired end sequence data as records of two files (read1, read2).
    inputBinding:
      position: 21
  - id: seqi
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: --seqi
    doc: Load paired end sequence from a single interleaved file or BAM.
    inputBinding:
      position: 22
  - id: graph_in
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: --graph
    doc: Load samples from an existing graph file (.ctx) into new colours. Colour selection (file.ctx:0,6-8) is not available here.
    inputBinding:
      position: 23
  - id: out
    type: string
    default: out.ctx
    doc: Output graph file (.ctx).
    inputBinding:
      position: 100
outputs:
  - id: graph_out
    type: File
    doc: The cortex graph file.
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mccortex:1.0--h24782f9_7
