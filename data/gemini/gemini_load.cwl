cwlVersion: v1.2
class: CommandLineTool
baseCommand: gemini_load
label: gemini_load
doc: "Load variants and annotations from a VCF file into a GEMINI database.\n\nTool
  homepage: https://github.com/arq5x/gemini"
inputs:
  - id: db
    type: string
    doc: The name of the database to be created.
    inputBinding:
      position: 1
  - id: annotation_type
    type:
      - 'null'
      - string
    doc: The annotations to be used with the input vcf.
    inputBinding:
      position: 102
      prefix: -t
  - id: cores
    type:
      - 'null'
      - int
    doc: Number of cores to use to load in parallel.
    inputBinding:
      position: 102
      prefix: --cores
  - id: no_genotypes
    type:
      - 'null'
      - boolean
    doc: There are no genotypes in the file (e.g. some 1000G VCFs)
    inputBinding:
      position: 102
      prefix: --no-genotypes
  - id: no_load_genotypes
    type:
      - 'null'
      - boolean
    doc: Genotypes exist in the file, but should not be stored.
    inputBinding:
      position: 102
      prefix: --no-load-genotypes
  - id: passonly
    type:
      - 'null'
      - boolean
    doc: Keep only variants that pass all filters.
    inputBinding:
      position: 102
      prefix: --passonly
  - id: ped_file
    type:
      - 'null'
      - File
    doc: Sample information file in PED+ format.
    inputBinding:
      position: 102
      prefix: -p
  - id: queue
    type:
      - 'null'
      - string
    doc: Cluster queue to use.
    inputBinding:
      position: 102
      prefix: --queue
  - id: save_info_string
    type:
      - 'null'
      - boolean
    doc: Load INFO string from VCF file. Not loaded by default
    inputBinding:
      position: 102
      prefix: --save-info-string
  - id: scheduler
    type:
      - 'null'
      - string
    doc: Cluster scheduler to use.
    inputBinding:
      position: 102
      prefix: --scheduler
  - id: skip_cadd
    type:
      - 'null'
      - boolean
    doc: Do not load CADD scores. Loaded by default
    inputBinding:
      position: 102
      prefix: --skip-cadd
  - id: skip_gene_tables
    type:
      - 'null'
      - boolean
    doc: Do not load gene tables. Loaded by default.
    inputBinding:
      position: 102
      prefix: --skip-gene-tables
  - id: skip_gerp_bp
    type:
      - 'null'
      - boolean
    doc: Do not load GERP scores at base pair resolution. Loaded by default.
    inputBinding:
      position: 102
      prefix: --skip-gerp-bp
  - id: skip_pls
    type:
      - 'null'
      - boolean
    doc: dont create columns for phred-scaled genotype likelihoods
    inputBinding:
      position: 102
      prefix: --skip-pls
  - id: tempdir
    type:
      - 'null'
      - Directory
    doc: Temp directory for storing intermediate files when loading in parallel.
    inputBinding:
      position: 102
      prefix: --tempdir
  - id: test_mode
    type:
      - 'null'
      - boolean
    doc: Load in test mode (faster)
    inputBinding:
      position: 102
      prefix: --test-mode
  - id: vcf_file
    type: File
    doc: The VCF file to be loaded.
    inputBinding:
      position: 102
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gemini:0.30.2--py27hacb5245_0
stdout: gemini_load.out
