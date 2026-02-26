cwlVersion: v1.2
class: CommandLineTool
baseCommand: gecco annotate
label: gecco_annotate
doc: "Annotate genomic sequences with genes and protein domains.\n\nTool homepage:
  https://gecco.embl.de/"
inputs:
  - id: bit_cutoffs
    type:
      - 'null'
      - string
    doc: Use HMM-specific bitscore cutoffs to filter domain annotations.
    default: None
    inputBinding:
      position: 101
      prefix: --bit-cutoffs
  - id: cds_feature
    type:
      - 'null'
      - string
    doc: Extract genes from annotated records using a feature rather than 
      running de-novo gene-calling.
    default: None
    inputBinding:
      position: 101
      prefix: --cds-feature
  - id: e_filter
    type:
      - 'null'
      - float
    doc: The e-value cutoff for protein domains to be included. This is not 
      stable across versions, so consider using a p-value filter instead.
    default: None
    inputBinding:
      position: 101
      prefix: --e-filter
  - id: force_tsv
    type:
      - 'null'
      - boolean
    doc: Always write TSV output files even when they are empty (e.g. because no
      genes or no clusters were found).
    default: false
    inputBinding:
      position: 101
      prefix: --force-tsv
  - id: format
    type:
      - 'null'
      - string
    doc: The format of the input file, as a Biopython format string. FASTA, EMBL
      and GenBank files are recognized automatically if this is not given.
    default: None
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
    default: None
    inputBinding:
      position: 101
      prefix: --hmm
  - id: jobs
    type:
      - 'null'
      - int
    doc: The number of jobs to use for multithreading. Use 0 to use all 
      available CPUs.
    default: 0
    inputBinding:
      position: 101
      prefix: --jobs
  - id: locus_tag
    type:
      - 'null'
      - string
    doc: The name of the feature qualifier to use for naming extracted genes 
      when using the ``--cds-feature`` flag.
    default: locus_tag
    inputBinding:
      position: 101
      prefix: --locus-tag
  - id: mask
    type:
      - 'null'
      - boolean
    doc: Enable unknown region masking to prevent genes from stretching across 
      ambiguous nucleotides.
    default: false
    inputBinding:
      position: 101
      prefix: --mask
  - id: no_color
    type:
      - 'null'
      - boolean
    doc: Disable the console color
    default: true
    inputBinding:
      position: 101
      prefix: --no-color
  - id: no_markup
    type:
      - 'null'
      - boolean
    doc: Disable the console markup
    default: true
    inputBinding:
      position: 101
      prefix: --no-markup
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: The directory in which to write the output files.
    default: .
    inputBinding:
      position: 101
      prefix: --output-dir
  - id: p_filter
    type:
      - 'null'
      - float
    doc: The p-value cutoff for protein domains to be included.
    default: '1e-09'
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
stdout: gecco_annotate.out
