cwlVersion: v1.2
class: CommandLineTool
baseCommand: trimnami testnp
label: trimnami_testnp
doc: "Test Trimnami with the test LR dataset and test host\n\nTool homepage: https://github.com/beardymcjohnface/Trimnami"
inputs:
  - id: snake_args
    type:
      - 'null'
      - type: array
        items: string
    doc: Additional arguments for Snakemake
    inputBinding:
      position: 1
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
  - id: fasta
    type:
      - 'null'
      - boolean
    doc: Output fasta format files instead of fastq
    inputBinding:
      position: 102
      prefix: --fasta
  - id: fastqc
    type:
      - 'null'
      - boolean
    doc: Run fastqc on trimmed and untrimmed reads
    inputBinding:
      position: 102
      prefix: --fastqc
  - id: host
    type:
      - 'null'
      - File
    doc: Host genome fasta for filtering
    inputBinding:
      position: 102
      prefix: --host
  - id: minimap
    type:
      - 'null'
      - string
    doc: Minimap preset
    inputBinding:
      position: 102
      prefix: --minimap
  - id: no_fasta
    type:
      - 'null'
      - boolean
    doc: Output fasta format files instead of fastq
    inputBinding:
      position: 102
      prefix: --no-fasta
  - id: no_fastqc
    type:
      - 'null'
      - boolean
    doc: Run fastqc on trimmed and untrimmed reads
    inputBinding:
      position: 102
      prefix: --no-fastqc
  - id: no_subsample
    type:
      - 'null'
      - boolean
    doc: Perform subsampling (set in config file)
    inputBinding:
      position: 102
      prefix: --no-subsample
  - id: no_use_conda
    type:
      - 'null'
      - boolean
    doc: Use conda for Snakemake rules
    inputBinding:
      position: 102
      prefix: --no-use-conda
  - id: subsample
    type:
      - 'null'
      - boolean
    doc: Perform subsampling (set in config file)
    inputBinding:
      position: 102
      prefix: --subsample
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    inputBinding:
      position: 102
      prefix: --threads
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
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/trimnami:0.1.4--pyhdfd78af_0
