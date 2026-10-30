cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mccortex31
  - correct
label: mccortex_correct
doc: "Correct reads against a (population) graph, using links if given. Bases that cannot be corrected are printed in lower case.\n\nThis wrapper runs the k<=31 binary (mccortex31). The same command exists in mccortex63 (k<=63), mccortex95 (k<=95) and mccortex127 (k<=127) with the same options; use those binaries for larger k-mer sizes.\n\nTool homepage: https://github.com/mcveanlab/mccortex"
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
  - id: paths
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: --paths
    doc: Link file (.ctp or .ctp.gz) to load. Can be given multiple times; use offset:file.ctp to choose the colour.
    inputBinding:
      position: 1
  - id: format
    type:
      - 'null'
      - string
    doc: 'Output format: FASTA or FASTQ.'
    inputBinding:
      position: 1
      prefix: --format
  - id: matepair
    type:
      - 'null'
      - string
    doc: 'Mate pair orientation: FF, FR, RF or RR (default FR).'
    inputBinding:
      position: 1
      prefix: --matepair
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
  - id: min_frag_len
    type:
      - 'null'
      - int
    doc: Minimum fragment size for --seq2 (default 0).
    inputBinding:
      position: 1
      prefix: --min-frag-len
  - id: max_frag_len
    type:
      - 'null'
      - int
    doc: Maximum fragment size for --seq2 (default 1000).
    inputBinding:
      position: 1
      prefix: --max-frag-len
  - id: one_way
    type:
      - 'null'
      - boolean
    doc: Use one-way gap filling (conservative).
    inputBinding:
      position: 1
      prefix: --one-way
  - id: two_way
    type:
      - 'null'
      - boolean
    doc: Use two-way gap filling (liberal).
    inputBinding:
      position: 1
      prefix: --two-way
  - id: gap_diff_const
    type:
      - 'null'
      - float
    doc: 'Allowable gap length parameter d: abs(gap_exp - gap_seen) <= gap_exp*D + d.'
    inputBinding:
      position: 1
      prefix: --gap-diff-const
  - id: gap_diff_coeff
    type:
      - 'null'
      - float
    doc: 'Allowable gap length parameter D: abs(gap_exp - gap_seen) <= gap_exp*D + d.'
    inputBinding:
      position: 1
      prefix: --gap-diff-coeff
  - id: max_context
    type:
      - 'null'
      - int
    doc: Number of k-mers to use either side of a gap.
    inputBinding:
      position: 1
      prefix: --max-context
  - id: end_check
    type:
      - 'null'
      - boolean
    doc: Extra check after bridging a gap (default on).
    inputBinding:
      position: 1
      prefix: --end-check
  - id: no_end_check
    type:
      - 'null'
      - boolean
    doc: Skip the extra check after gap bridging.
    inputBinding:
      position: 1
      prefix: --no-end-check
  - id: fq_zero
    type:
      - 'null'
      - string
    doc: Replace a zeroed quality score with this character.
    inputBinding:
      position: 1
      prefix: --fq-zero
  - id: print_orig
    type:
      - 'null'
      - boolean
    doc: Print the original sequence in the read name ('orig=SEQ').
    inputBinding:
      position: 1
      prefix: --print-orig
  - id: gap_hist
    type:
      - 'null'
      - string
    doc: Save the size distribution of sequence gaps bridged (CSV).
    inputBinding:
      position: 1
      prefix: --gap-hist
  - id: frag_hist
    type:
      - 'null'
      - string
    doc: Save the size distribution of paired end fragments (CSV).
    inputBinding:
      position: 1
      prefix: --frag-hist
  - id: contig_hist
    type:
      - 'null'
      - string
    doc: Save the size distribution of assembled contigs (CSV).
    inputBinding:
      position: 1
      prefix: --contig-hist
  - id: colour
    type:
      - 'null'
      - int
    doc: Sample graph colour to correct against.
    inputBinding:
      position: 1
      prefix: --colour
  - id: seq
    type:
      - 'null'
      - type: array
        items: SeqOut
        inputBinding:
          prefix: --seq
          valueFrom: $(self.reads.path):$(self.out_prefix)
    doc: 'Correct reads: records of an input file (reads) and an output prefix. Output is <out_prefix>.fa.gz (or .fq.gz).'
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
    doc: 'Correct paired end reads: records of two input files and an output prefix. Output is <out_prefix>.1.fa.gz and <out_prefix>.2.fa.gz.'
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
    doc: 'Correct paired end reads from one interleaved file or BAM: records of an input file (reads) and an output prefix.'
    inputBinding:
      position: 22
  - id: graph
    type: File
    doc: Input (population) cortex graph file (.ctx).
    inputBinding:
      position: 100
outputs:
  - id: corrected
    type: File[]
    doc: Corrected read files.
    outputBinding:
      glob:
        - '*.fa.gz'
        - '*.fq.gz'
        - '*.txt.gz'
  - id: gap_hist_file
    type:
      - 'null'
      - File
    doc: Histogram written by --gap-hist.
    outputBinding:
      glob: $(inputs.gap_hist)
  - id: frag_hist_file
    type:
      - 'null'
      - File
    doc: Histogram written by --frag-hist.
    outputBinding:
      glob: $(inputs.frag_hist)
  - id: contig_hist_file
    type:
      - 'null'
      - File
    doc: Histogram written by --contig-hist.
    outputBinding:
      glob: $(inputs.contig_hist)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mccortex:1.0--h24782f9_7
