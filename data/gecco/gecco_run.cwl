cwlVersion: v1.2
class: CommandLineTool
baseCommand: gecco run
label: gecco_run
doc: "Run gecco gene calling and cluster detection\n\nTool homepage: https://gecco.embl.de/"
inputs:
  - id: antismash_sideload
    type:
      - 'null'
      - boolean
    doc: Write an AntiSMASH v6 sideload JSON file next to the output files.
    inputBinding:
      position: 101
      prefix: --antismash-sideload
  - id: bit_cutoffs
    type:
      - 'null'
      - string
    doc: Use HMM-specific bitscore cutoffs to filter domain annotations.
    inputBinding:
      position: 101
      prefix: --bit-cutoffs
  - id: cds
    type:
      - 'null'
      - int
    doc: The minimum number of coding sequences a valid cluster must contain to 
      be retained.
    inputBinding:
      position: 101
      prefix: --cds
  - id: cds_feature
    type:
      - 'null'
      - string
    doc: Extract genes from annotated records using a feature rather than 
      running de-novo gene-calling.
    inputBinding:
      position: 101
      prefix: --cds-feature
  - id: e_filter
    type:
      - 'null'
      - float
    doc: The e-value cutoff for protein domains to be included. This is not 
      stable across versions, so consider using a p-value filter instead.
    inputBinding:
      position: 101
      prefix: --e-filter
  - id: edge_distance
    type:
      - 'null'
      - int
    doc: The minimum number of annotated genes that must separate a cluster from
      the edge. Edge clusters will still be included if they are longer. A lower
      number will increase the number of false positives on small contigs.
    inputBinding:
      position: 101
      prefix: --edge-distance
  - id: force_tsv
    type:
      - 'null'
      - boolean
    doc: Always write TSV output files even when they are empty (e.g. because no
      genes or no clusters were found).
    inputBinding:
      position: 101
      prefix: --force-tsv
  - id: format
    type:
      - 'null'
      - string
    doc: The format of the input file, as a Biopython format string. FASTA, EMBL
      and GenBank files are recognized automatically if this is not given.
    inputBinding:
      position: 101
      prefix: --format
  - id: genome
    type: File
    doc: A genomic file containing one or more sequences to use as input. Must 
      be in one of the sequence formats supported by Biopython
    inputBinding:
      position: 101
      prefix: --genome
  - id: hmm
    type:
      - 'null'
      - type: array
        items: File
    doc: The path to one or more alternative HMM file to use (in HMMER format).
    inputBinding:
      position: 101
      prefix: --hmm
  - id: jobs
    type:
      - 'null'
      - int
    doc: The number of jobs to use for multithreading. Use 0 to use all 
      available CPUs.
    inputBinding:
      position: 101
      prefix: --jobs
  - id: locus_tag
    type:
      - 'null'
      - string
    doc: The name of the feature qualifier to use for naming extracted genes 
      when using the ``--cds-feature`` flag.
    inputBinding:
      position: 101
      prefix: --locus-tag
  - id: mask
    type:
      - 'null'
      - boolean
    doc: Enable unknown region masking to prevent genes from stretching across 
      ambiguous nucleotides.
    inputBinding:
      position: 101
      prefix: --mask
  - id: merge_gbk
    type:
      - 'null'
      - boolean
    doc: Output a single GenBank file containing every detected cluster instead 
      of writing one file per cluster.
    inputBinding:
      position: 101
      prefix: --merge-gbk
  - id: model
    type:
      - 'null'
      - File
    doc: The path to an alternative CRF model to use (obtained with `gecco 
      train`).
    inputBinding:
      position: 101
      prefix: --model
  - id: no_color
    type:
      - 'null'
      - boolean
    doc: Disable the console color
    inputBinding:
      position: 101
      prefix: --no-color
  - id: no_markup
    type:
      - 'null'
      - boolean
    doc: Disable the console markup
    inputBinding:
      position: 101
      prefix: --no-markup
  - id: no_pad
    type:
      - 'null'
      - boolean
    doc: Disable padding of gene sequences (used to predict gene clusters in 
      contigs smaller than the CRF window length).
    inputBinding:
      position: 101
      prefix: --no-pad
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: The directory in which to write the output files.
    inputBinding:
      position: 101
      prefix: --output-dir
  - id: p_filter
    type:
      - 'null'
      - float
    doc: The p-value cutoff for protein domains to be included.
    inputBinding:
      position: 101
      prefix: --p-filter
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Reduce or disable the console output
    inputBinding:
      position: 101
      prefix: --quiet
  - id: threshold
    type:
      - 'null'
      - float
    doc: The probability threshold for cluster detection.
    inputBinding:
      position: 101
      prefix: --threshold
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Increase the console output
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gecco:0.10.2--pyhdfd78af_0
stdout: gecco_run.out
