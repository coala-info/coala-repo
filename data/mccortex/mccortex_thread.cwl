cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mccortex31
  - thread
label: mccortex_thread
doc: "Thread reads through a cleaned graph to make links and save them to a link file (.ctp.gz).\n\nThis wrapper runs the k<=31 binary (mccortex31). The same command exists in mccortex63 (k<=63), mccortex95 (k<=95) and mccortex127 (k<=127) with the same options; use those binaries for larger k-mer sizes.\n\nTool homepage: https://github.com/mcveanlab/mccortex"
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
  - id: out
    type: string
    default: links.ctp.gz
    doc: Output link file (.ctp.gz).
    inputBinding:
      position: 1
      prefix: --out
  - id: paths
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: --paths
    doc: Load an existing link file (can be given multiple times; offset:file.ctp selects the colour).
    inputBinding:
      position: 1
  - id: zero_paths
    type:
      - 'null'
      - boolean
    doc: Zero counts on initially loaded links. Use if existing links were built from sequence re-used by this run.
    inputBinding:
      position: 1
      prefix: --zero-paths
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
  - id: use_new_paths
    type:
      - 'null'
      - boolean
    doc: Use links as they are being added (higher error rate).
    inputBinding:
      position: 1
      prefix: --use-new-paths
  - id: print_contigs
    type:
      - 'null'
      - boolean
    doc: 'Debugging option: print contigs.'
    inputBinding:
      position: 1
      prefix: --print-contigs
  - id: print_paths
    type:
      - 'null'
      - boolean
    doc: 'Debugging option: print paths.'
    inputBinding:
      position: 1
      prefix: --print-paths
  - id: print_reads
    type:
      - 'null'
      - boolean
    doc: 'Debugging option: print reads.'
    inputBinding:
      position: 1
      prefix: --print-reads
  - id: seq
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: --seq
    doc: Thread reads from a file (FASTA, FASTQ, SAM, BAM; can be gzipped). Can be given multiple times.
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
    doc: Thread paired end sequences, as records of two files (read1, read2).
    inputBinding:
      position: 21
  - id: seqi
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: --seqi
    doc: Thread paired end reads from a single (interleaved or BAM) file.
    inputBinding:
      position: 22
  - id: graph
    type: File
    doc: Input cortex graph file (.ctx), cleaned, with edges inferred.
    inputBinding:
      position: 100
outputs:
  - id: links_out
    type: File
    doc: Output link file (.ctp.gz).
    outputBinding:
      glob: $(inputs.out)
  - id: gap_hist_file
    type:
      - 'null'
      - File
    doc: Gap size histogram.
    outputBinding:
      glob: $(inputs.gap_hist)
  - id: frag_hist_file
    type:
      - 'null'
      - File
    doc: Fragment size histogram.
    outputBinding:
      glob: $(inputs.frag_hist)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mccortex:1.0--h24782f9_7
