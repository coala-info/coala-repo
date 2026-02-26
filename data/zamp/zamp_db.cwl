cwlVersion: v1.2
class: CommandLineTool
baseCommand: zamp db
label: zamp_db
doc: "Prepare database files for zAMP\n\nTool homepage: https://github.com/metagenlab/zAMP/"
inputs:
  - id: snake_args
    type:
      - 'null'
      - type: array
        items: string
    doc: Additional arguments for Snakemake
    inputBinding:
      position: 1
  - id: ampcov
    type:
      - 'null'
      - float
    doc: Minimum amplicon coverage
    default: 0.9
    inputBinding:
      position: 102
      prefix: --ampcov
  - id: amplicon
    type:
      - 'null'
      - string
    doc: Choose 16S or ITS for primer trimming
    default: 16S
    inputBinding:
      position: 102
      prefix: --amplicon
  - id: classifier
    type:
      - 'null'
      - string
    doc: Which classifiers to train on the database
    default: rdp, qiimerdp, dada2rdp
    inputBinding:
      position: 102
      prefix: --classifier
  - id: conda_prefix
    type:
      - 'null'
      - Directory
    doc: Custom conda env directory
    inputBinding:
      position: 102
      prefix: --conda-prefix
  - id: configfile
    type:
      - 'null'
      - string
    doc: Custom config file
    default: (outputDir)/config.yaml
    inputBinding:
      position: 102
      prefix: --configfile
  - id: errors
    type:
      - 'null'
      - float
    doc: Maximum number of accepted primer mismatches, or float between 0 and 1
    default: 0.1
    inputBinding:
      position: 102
      prefix: --errors
  - id: fasta
    type: File
    doc: Path to database fasta file
    inputBinding:
      position: 102
      prefix: --fasta
  - id: fw_primer
    type: string
    doc: Forward primer sequence to extract amplicon
    inputBinding:
      position: 102
      prefix: --fw-primer
  - id: maxlen
    type:
      - 'null'
      - int
    doc: Maximum amplicon length
    default: 500
    inputBinding:
      position: 102
      prefix: --maxlen
  - id: minlen
    type:
      - 'null'
      - int
    doc: Minimum amplicon length
    default: 300
    inputBinding:
      position: 102
      prefix: --minlen
  - id: name
    type: string
    doc: Comma seperated list of database names
    inputBinding:
      position: 102
      prefix: --name
  - id: no_processing
    type:
      - 'null'
      - boolean
    doc: Extract amplicon regions and merge taxonomy
    default: false
    inputBinding:
      position: 102
      prefix: --no-processing
  - id: no_use_conda
    type:
      - 'null'
      - boolean
    doc: Use conda for Snakemake rules
    default: true
    inputBinding:
      position: 102
      prefix: --no-use-conda
  - id: no_use_singularity
    type:
      - 'null'
      - boolean
    doc: Use singularity containers for Snakemake rules
    default: false
    inputBinding:
      position: 102
      prefix: --no-use-singularity
  - id: processing
    type:
      - 'null'
      - boolean
    doc: Extract amplicon regions and merge taxonomy
    default: true
    inputBinding:
      position: 102
      prefix: --processing
  - id: rdp_mem
    type:
      - 'null'
      - string
    doc: Maximum RAM for RDP training
    default: 30g
    inputBinding:
      position: 102
      prefix: --rdp-mem
  - id: rv_primer
    type: string
    doc: Reverse primer sequence to extract amplicon
    inputBinding:
      position: 102
      prefix: --rv-primer
  - id: singularity_prefix
    type:
      - 'null'
      - Directory
    doc: Custom singularity container directory
    inputBinding:
      position: 102
      prefix: --singularity-prefix
  - id: snake_default
    type:
      - 'null'
      - string
    doc: Customise Snakemake runtime args
    inputBinding:
      position: 102
      prefix: --snake-default
  - id: tax_collapse
    type:
      - 'null'
      - string
    doc: Dictionary of number of ranks to print limit when collapsing names
    default: '{"Species": 5, "Genus": 6}'
    inputBinding:
      position: 102
      prefix: --tax-collapse
  - id: taxonomy
    type: File
    doc: Path to tab seperated taxonomy file in QIIME format
    inputBinding:
      position: 102
      prefix: --taxonomy
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    default: 1
    inputBinding:
      position: 102
      prefix: --threads
  - id: use_conda
    type:
      - 'null'
      - boolean
    doc: Use conda for Snakemake rules
    default: false
    inputBinding:
      position: 102
      prefix: --use-conda
  - id: use_singularity
    type:
      - 'null'
      - boolean
    doc: Use singularity containers for Snakemake rules
    default: true
    inputBinding:
      position: 102
      prefix: --use-singularity
outputs:
  - id: output
    type:
      - 'null'
      - Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/zamp:1.0.0--pyhdfd78af_1
