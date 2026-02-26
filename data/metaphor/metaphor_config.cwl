cwlVersion: v1.2
class: CommandLineTool
baseCommand: metaphor config
label: metaphor_config
doc: "Metaphor configuration commands.\n\nTool homepage: https://github.com/vinisalazar/metaphor"
inputs:
  - id: config_command
    type: string
    doc: Config command to be executed.
    inputBinding:
      position: 1
  - id: input_command_description
    type:
      - 'null'
      - string
    doc: Create Metaphor input table from directory of fastq files.
    inputBinding:
      position: 2
  - id: settings_command_description
    type:
      - 'null'
      - string
    doc: Generate Metaphor settings YAML file.
    inputBinding:
      position: 3
  - id: show_command_description
    type:
      - 'null'
      - string
    doc: Show path of Metaphor installation, Snakefile, config files, and a 
      sample input file.
    inputBinding:
      position: 4
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metaphor:1.7.14--pyhdfd78af_0
stdout: metaphor_config.out
