cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tritimap
  - init
label: tritimap_init
doc: "Generate snakemake configuration file and other needed file. The command will
  generate three configuration files(config.yaml, sample.csv and region.csv) in the
  running directory.\n\nTool homepage: https://github.com/fei0810/Triti-Map"
inputs:
  - id: working_dir
    type:
      - 'null'
      - string
    doc: Triti-Map running directory (created in the working directory).
    inputBinding:
      position: 101
      prefix: --working-dir
outputs:
  - id: config_yaml
    type: File
    doc: Snakemake configuration file
    outputBinding:
      glob: "$(inputs.working_dir ? inputs.working_dir + '/' : '')config.yaml"
  - id: sample_csv
    type: File
    doc: Sample table
    outputBinding:
      glob: "$(inputs.working_dir ? inputs.working_dir + '/' : '')sample.csv"
  - id: region_csv
    type: File
    doc: Region table
    outputBinding:
      glob: "$(inputs.working_dir ? inputs.working_dir + '/' : '')region.csv"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tritimap:0.9.7--pyh5e36f6f_0
