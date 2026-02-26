cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - zamp
  - insilico
label: zamp_insilico
doc: "Run the in-silico module for zAMP\n\nTool homepage: https://github.com/metagenlab/zAMP/"
inputs:
  - id: snake_args
    type:
      - 'null'
      - type: array
        items: string
    doc: Additional arguments for Snakemake
    inputBinding:
      position: 1
  - id: accession
    type:
      - 'null'
      - boolean
    doc: Are queries taxa or accessions
    default: false
    inputBinding:
      position: 102
      prefix: --accession
  - id: af_args
    type:
      - 'null'
      - string
    doc: Assembly_finder arguments
    inputBinding:
      position: 102
      prefix: --af-args
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
  - id: assembly
    type:
      - 'null'
      - string
    doc: 'Comma seperated list of assembly level: complete,chromosome,scaffold,contig'
    inputBinding:
      position: 102
      prefix: --assembly
  - id: classifier
    type:
      - 'null'
      - string
    doc: Which classifiers to use for taxonomic assignment
    default: RDP
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
  - id: database
    type: Directory
    doc: Path to Database directory
    inputBinding:
      position: 102
      prefix: --database
  - id: database_names
    type:
      - 'null'
      - string
    doc: Comma seperated list of database names
    inputBinding:
      position: 102
      prefix: --name
  - id: denoiser
    type:
      - 'null'
      - string
    doc: Choose dada2 or vsearch for denoising reads
    default: DADA2
    inputBinding:
      position: 102
      prefix: --denoiser
  - id: errors
    type:
      - 'null'
      - float
    doc: Maximum number of accepted primer mismatches, or float between 0 and 1
    default: 0.1
    inputBinding:
      position: 102
      prefix: --errors
  - id: fw_primer
    type: string
    doc: Forward primer sequence to extract amplicon from reads
    inputBinding:
      position: 102
      prefix: --fw-primer
  - id: input_tax
    type: string
    doc: Input taxa/accessions for in-silico validation
    inputBinding:
      position: 102
      prefix: --input-tax
  - id: limit
    type:
      - 'null'
      - string
    doc: Limit number of genomes per query
    inputBinding:
      position: 102
      prefix: --limit
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
  - id: mismatch
    type:
      - 'null'
      - int
    doc: Number of mismatches for simulate_PCR
    default: 3
    inputBinding:
      position: 102
      prefix: --mismatch
  - id: no_replace_empty
    type:
      - 'null'
      - boolean
    doc: Replace empty taxa by placeholders
    default: true
    inputBinding:
      position: 102
      prefix: --no-replace-empty
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
  - id: not_only_ref
    type:
      - 'null'
      - boolean
    doc: Limit to reference and representative genomes
    default: false
    inputBinding:
      position: 102
      prefix: --not-only-ref
  - id: nrank
    type:
      - 'null'
      - int
    doc: Number of genomes per taxonomic rank
    inputBinding:
      position: 102
      prefix: --nrank
  - id: only_ref
    type:
      - 'null'
      - boolean
    doc: Limit to reference and representative genomes
    default: true
    inputBinding:
      position: 102
      prefix: --only-ref
  - id: pcr_tool
    type:
      - 'null'
      - string
    doc: Tool for in silico PCR
    default: in-silico
    inputBinding:
      position: 102
      prefix: --pcr-tool
  - id: rank
    type:
      - 'null'
      - string
    doc: taxonomic rank to filter by assemblies
    inputBinding:
      position: 102
      prefix: --rank
  - id: replace_empty
    type:
      - 'null'
      - boolean
    doc: Replace empty taxa by placeholders
    default: false
    inputBinding:
      position: 102
      prefix: --replace-empty
  - id: rv_primer
    type: string
    doc: Reverse primer sequence to extract amplicon from reads
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
  - id: taxon
    type:
      - 'null'
      - boolean
    doc: Are queries taxa or accessions
    default: true
    inputBinding:
      position: 102
      prefix: --taxon
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    default: 1
    inputBinding:
      position: 102
      prefix: --threads
  - id: threeprime
    type:
      - 'null'
      - int
    doc: Number of match at the 3' end for a hit to be considered for 
      simulate_PCR
    default: 2
    inputBinding:
      position: 102
      prefix: --threeprime
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
