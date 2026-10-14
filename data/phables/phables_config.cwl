cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phables
  - config
label: phables_config
doc: "Copy the system default config file\n\nTool homepage:
  https://github.com/Vini2/phables"
inputs:
  - id: snake_args
    type:
      - 'null'
      - type: array
        items: string
    doc: Extra Snakemake arguments and targets
    inputBinding:
      position: 102
  - id: output_dir
    type:
      - 'null'
      - string
    doc: Output directory (default phables.out)
    inputBinding:
      position: 1
      prefix: --output
  - id: configfile
    type:
      - 'null'
      - string
    doc: Custom config file [default (outputDir)/config.yaml]
    inputBinding:
      position: 2
      prefix: --configfile
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    inputBinding:
      position: 3
      prefix: --threads
  - id: use_conda
    type:
      - 'null'
      - boolean
    doc: Use conda for Snakemake rules (default)
    inputBinding:
      position: 4
      prefix: --use-conda
  - id: no_use_conda
    type:
      - 'null'
      - boolean
    doc: Do not use conda for Snakemake rules
    inputBinding:
      position: 4
      prefix: --no-use-conda
  - id: conda_prefix
    type:
      - 'null'
      - string
    doc: Custom conda env directory
    inputBinding:
      position: 5
      prefix: --conda-prefix
  - id: profile
    type:
      - 'null'
      - string
    doc: Snakemake profile
    inputBinding:
      position: 6
      prefix: --profile
  - id: snake_default
    type:
      - 'null'
      - string
    doc: Customise Snakemake runtime args
    inputBinding:
      position: 7
      prefix: --snake-default
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_dir_dir
    type:
      - 'null'
      - Directory
    doc: Output directory holding the copied config file
    outputBinding:
      glob: $(inputs.output_dir)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phables:1.5.0--pyhdfd78af_0
stdout: phables_config.out
