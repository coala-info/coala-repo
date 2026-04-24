cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hecatomb
  - run
label: hecatomb_run
doc: "Run hecatomb\n\nTool homepage: https://github.com/shandley/hecatomb"
inputs:
  - id: snake_args
    type:
      - 'null'
      - type: array
        items: string
    doc: Additional arguments for Snakemake
    inputBinding:
      position: 1
  - id: assembly
    type:
      - 'null'
      - string
    doc: 'Assembly method: [cross]-assembly or [merged]-assembly'
    inputBinding:
      position: 102
      prefix: --assembly
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
    inputBinding:
      position: 102
      prefix: --configfile
  - id: custom_aa
    type:
      - 'null'
      - File
    doc: Custom protein fasta for prefiltering
    inputBinding:
      position: 102
      prefix: --custom-aa
  - id: custom_nt
    type:
      - 'null'
      - File
    doc: Custom nucleotide fasta for prefiltering
    inputBinding:
      position: 102
      prefix: --custom-nt
  - id: fastqc
    type:
      - 'null'
      - boolean
    doc: Generate fastqc reports
    inputBinding:
      position: 102
      prefix: --fastqc
  - id: host
    type:
      - 'null'
      - string
    doc: Host genome name for filtering, or 'none' for no host removal.
    inputBinding:
      position: 102
      prefix: --host
  - id: longreads
    type:
      - 'null'
      - boolean
    doc: Sequencing is longreads (PacBio, Nanopore, etc)
    inputBinding:
      position: 102
      prefix: --longreads
  - id: no_fastqc
    type:
      - 'null'
      - boolean
    doc: Generate fastqc reports
    inputBinding:
      position: 102
      prefix: --no-fastqc
  - id: no_longreads
    type:
      - 'null'
      - boolean
    doc: Sequencing is longreads (PacBio, Nanopore, etc)
    inputBinding:
      position: 102
      prefix: --no-longreads
  - id: no_use_conda
    type:
      - 'null'
      - boolean
    doc: Use conda for Snakemake rules
    inputBinding:
      position: 102
      prefix: --no-use-conda
  - id: profile
    type:
      - 'null'
      - string
    doc: Snakemake profile
    inputBinding:
      position: 102
      prefix: --profile
  - id: reads
    type: string
    doc: Input file/directory
    inputBinding:
      position: 102
      prefix: --reads
  - id: search
    type:
      - 'null'
      - string
    doc: MMSeqs search speed settings
    inputBinding:
      position: 102
      prefix: --search
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    inputBinding:
      position: 102
      prefix: --threads
  - id: trim
    type:
      - 'null'
      - string
    doc: Trimming engine for trimnami
    inputBinding:
      position: 102
      prefix: --trim
  - id: use_conda
    type:
      - 'null'
      - boolean
    doc: Use conda for Snakemake rules
    inputBinding:
      position: 102
      prefix: --use-conda
  - id: workflow_profile
    type:
      - 'null'
      - string
    doc: Custom config file
    inputBinding:
      position: 102
      prefix: --workflow-profile
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
    dockerPull: quay.io/biocontainers/hecatomb:1.3.4--pyh7e72e81_0
