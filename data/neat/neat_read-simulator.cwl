cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - neat
  - read-simulator
label: neat_read-simulator
doc: "Simulate NGS reads dataset (See README for complete description of the config
  input).\n\nTool homepage: https://github.com/ncsa/NEAT/"
inputs:
  - id: config
    type: File
    doc: Path (including filename) to the configuration file for this run. File
      names inside the config (reference, VCF, BED, models) are relative to the
      working directory; stage them with config_files.
    inputBinding:
      position: 1
      prefix: --config
  - id: config_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Files named in the configuration file (reference FASTA, VCF, BED,
      models), staged in the working directory
  - id: output_dir
    type: string
    doc: Path to the output directory. Will create if not present.
    inputBinding:
      position: 2
      prefix: --output_dir
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prefix to use to name files
    inputBinding:
      position: 3
      prefix: --prefix
outputs:
  - id: output_directory
    type: Directory
    doc: Directory with the simulated reads and other output files
    outputBinding:
      glob: $(inputs.output_dir)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: '$(inputs.config_files ? inputs.config_files : [])'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/neat:4.3.5--pyhdfd78af_0
