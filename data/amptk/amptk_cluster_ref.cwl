cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - amptk
  - cluster_ref
label: amptk_cluster_ref
doc: "Script runs UPARSE OTU clustering. Requires USEARCH by Robert C. Edgar: http://drive5.com/usearch\n\
  \nTool homepage: https://github.com/nextgenusfs/amptk"
inputs:
  - id: alignment_threshold
    type:
      - 'null'
      - float
    doc: Threshold for alignment
    inputBinding:
      position: 101
      prefix: --id
  - id: closed_ref_only
    type:
      - 'null'
      - boolean
    doc: Only run closed reference clustering
    inputBinding:
      position: 101
      prefix: --closed_ref_only
  - id: cpus
    type:
      - 'null'
      - int
    doc: 'Number of CPUs. Default: auto'
    inputBinding:
      position: 101
      prefix: --cpus
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Remove Intermediate Files
    inputBinding:
      position: 101
      prefix: --debug
  - id: fastq_file
    type: File
    doc: FASTQ file (Required)
    inputBinding:
      position: 101
      prefix: --fastq
  - id: map_filtered
    type:
      - 'null'
      - boolean
    doc: map quality filtered reads back to OTUs
    inputBinding:
      position: 101
      prefix: --map_filtered
  - id: max_ee
    type:
      - 'null'
      - float
    doc: Quality trim EE value
    inputBinding:
      position: 101
      prefix: --maxee
  - id: min_size
    type:
      - 'null'
      - int
    doc: Min identical seqs to process
    inputBinding:
      position: 101
      prefix: --minsize
  - id: mock_community
    type:
      - 'null'
      - File
    doc: Spike-in mock community (fasta)
    inputBinding:
      position: 101
      prefix: --mock
  - id: out_base
    type:
      - 'null'
      - string
    doc: Base output name
    inputBinding:
      position: 101
      prefix: --out
  - id: pct_otu
    type:
      - 'null'
      - float
    doc: OTU Clustering Percent
    inputBinding:
      position: 101
      prefix: --pct_otu
  - id: reference_database
    type:
      - string
      - File
    doc: Reference database, either a pre-installed name [ITS,ITS1,ITS2,16S,LSU,COI]
      or a custom FASTA file
    inputBinding:
      position: 101
      prefix: --db
  - id: usearch_exe
    type:
      - 'null'
      - string
    doc: USEARCH9 EXE
    inputBinding:
      position: 101
      prefix: --usearch
  - id: utax_cutoff
    type:
      - 'null'
      - float
    doc: UTAX confidence value threshold.
    inputBinding:
      position: 101
      prefix: --utax_cutoff
  - id: utax_db
    type:
      - 'null'
      - File
    doc: UTAX Reference Database
    inputBinding:
      position: 101
      prefix: --utax_db
  - id: utax_level
    type:
      - 'null'
      - string
    doc: UTAX classification level to retain
    inputBinding:
      position: 101
      prefix: --utax_level
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: out_files
    type:
      type: array
      items: File
    doc: Files written with the output base name (OTU/ASV FASTA, OTU tables, log)
    outputBinding:
      glob: $(inputs.out_base).*
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/amptk:1.6.0--pyhdfd78af_0
stdout: amptk_cluster_ref.out
