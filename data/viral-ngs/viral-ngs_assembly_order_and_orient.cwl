cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - assembly.py
  - order_and_orient
label: viral-ngs_assembly_order_and_orient
doc: "This step cleans up the de novo assembly with a known reference genome. Uses MUMmer (nucmer or promer) to create a reference-based consensus sequence of aligned contigs (with runs of N's in between the de novo contigs).\n\nTool homepage: https://github.com/broadinstitute/viral-ngs"
inputs:
  - id: in_fasta
    type: File
    doc: "Input de novo assembly/contigs, FASTA format."
    inputBinding:
      position: 1
  - id: in_reference
    type: File
    doc: "Reference genome for ordering, orienting, and merging contigs, FASTA format."
    inputBinding:
      position: 2
  - id: out_fasta
    type: string
    doc: "Output assembly, FASTA format, with the same number of chromosomes as inReference, and in the same order."
    inputBinding:
      position: 3
  - id: out_alternate_contigs
    type:
      - 'null'
      - string
    doc: "Output sequences (FASTA format) from alternative contigs that mapped, but were not chosen for the final output."
    inputBinding:
      position: 20
      prefix: --outAlternateContigs
  - id: breaklen
    type:
      - 'null'
      - int
    doc: "Amount to extend alignment clusters by (if --extend). nucmer default 200, promer default 60."
    inputBinding:
      position: 20
      prefix: --breaklen
  - id: maxgap
    type:
      - 'null'
      - int
    doc: "Maximum gap between two adjacent matches in a cluster. Our default is 200. nucmer default 90, promer default 30. Manual suggests going to 1000."
    inputBinding:
      position: 20
      prefix: --maxgap
  - id: minmatch
    type:
      - 'null'
      - int
    doc: "Minimum length of an maximal exact match. Our default is 10. nucmer default 20, promer default 6."
    inputBinding:
      position: 20
      prefix: --minmatch
  - id: mincluster
    type:
      - 'null'
      - int
    doc: "Minimum cluster length. nucmer default 65, promer default 20."
    inputBinding:
      position: 20
      prefix: --mincluster
  - id: min_pct_id
    type:
      - 'null'
      - float
    doc: "show-tiling: minimum percent identity for contig alignment (0.0 - 1.0, default: 0.6)"
    inputBinding:
      position: 20
      prefix: --min_pct_id
  - id: min_contig_len
    type:
      - 'null'
      - int
    doc: "show-tiling: reject contigs smaller than this (default: 200)"
    inputBinding:
      position: 20
      prefix: --min_contig_len
  - id: min_pct_contig_aligned
    type:
      - 'null'
      - float
    doc: "show-tiling: minimum percent of contig length in alignment (0.0 - 1.0, default: 0.3)"
    inputBinding:
      position: 20
      prefix: --min_pct_contig_aligned
  - id: loglevel
    type:
      - 'null'
      - type: enum
        symbols:
          - DEBUG
          - INFO
          - WARNING
          - ERROR
          - CRITICAL
          - EXCEPTION
    doc: "Verboseness of output. [default: DEBUG]"
    inputBinding:
      position: 20
      prefix: --loglevel
  - id: tmp_dir
    type:
      - 'null'
      - string
    doc: "Base directory for temp files. [default: /tmp]"
    inputBinding:
      position: 20
      prefix: --tmp_dir
  - id: tmp_dir_keep
    type:
      - 'null'
      - boolean
    doc: "Keep the tmp_dir if an exception occurs while running. Default is to delete all temp files at the end, even if there's a failure."
    inputBinding:
      position: 20
      prefix: --tmp_dirKeep
outputs:
  - id: out_fasta_file
    type: File
    doc: "Output file written to out_fasta"
    outputBinding:
      glob: $(inputs.out_fasta)
  - id: out_alternate_contigs_file
    type:
      - 'null'
      - File
    doc: "Output file written to out_alternate_contigs"
    outputBinding:
      glob: $(inputs.out_alternate_contigs)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
