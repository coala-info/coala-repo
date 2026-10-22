cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sphae
  - annotate
label: sphae_annotate
doc: "Annotate a phage genome with sphae (Snakemake pipeline).\n\nTool homepage: https://github.com/linsalrob/sphae/"
inputs:
  - id: input
    type:
      - 'null'
      - Directory
    doc: "Directory of reads [default: test/illumina-subset]"
    inputBinding:
      position: 11
      prefix: --input
  - id: output
    type:
      - 'null'
      - string
    doc: "Output directory [default: sphae.out]"
    inputBinding:
      position: 11
      prefix: --output
  - id: configfile
    type:
      - 'null'
      - File
    doc: "Custom config file [default: config.yaml]"
    inputBinding:
      position: 11
      prefix: --configfile
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads to use [default: 1]"
    inputBinding:
      position: 11
      prefix: --threads
  - id: profile
    type:
      - 'null'
      - string
    doc: "Snakemake profile"
    inputBinding:
      position: 11
      prefix: --profile
  - id: db_dir
    type:
      - 'null'
      - Directory
    doc: "Custom database directory"
    inputBinding:
      position: 11
      prefix: --db_dir
  - id: temp_dir
    type:
      - 'null'
      - string
    doc: "Temp directory"
    inputBinding:
      position: 11
      prefix: --temp-dir
  - id: use_conda
    type:
      - 'null'
      - boolean
    doc: "Use conda for Snakemake rules (default: use-conda)"
    inputBinding:
      position: 11
      prefix: --use-conda
  - id: no_use_conda
    type:
      - 'null'
      - boolean
    doc: "Do not use conda for Snakemake rules"
    inputBinding:
      position: 11
      prefix: --no-use-conda
  - id: snake_default
    type:
      - 'null'
      - string
    doc: "Customise Snakemake runtime args [default: --rerun-incomplete, --printshellcmds, --nolock, --show-failed-logs]"
    inputBinding:
      position: 11
      prefix: --snake-default
  - id: conda_prefix
    type:
      - 'null'
      - string
    doc: "Custom conda env directory"
    inputBinding:
      position: 11
      prefix: --conda-prefix
  - id: genome
    type:
      - 'null'
      - File
    doc: "Input genome assembled or downloaded"
    inputBinding:
      position: 11
      prefix: --genome
  - id: snake_args
    type:
      - 'null'
      - type: array
        items: string
    doc: "Extra Snakemake arguments passed through after the sphae options"
    inputBinding:
      position: 100
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: "Output directory"
    outputBinding:
      glob: "$(inputs.output || 'sphae.out')"
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sphae:1.5.3--pyhdfd78af_0
stdout: sphae_annotate.out
