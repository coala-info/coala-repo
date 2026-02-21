cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - biopet-sampleconfig
  - casecontrol
label: biopet-sampleconfig_casecontrol
doc: "Options for CaseControl. This tool handles sample configuration for case-control
  studies, allowing input of BAM files and sample configurations with specific tags.\n
  \nTool homepage: https://github.com/biopet/sampleconfig"
inputs:
  - id: control_tag
    type:
      - 'null'
      - string
    doc: This works the same as for a normal input file. Difference is that it placed
      in a sub key 'tags' in the config file
    inputBinding:
      position: 101
      prefix: --controlTag
  - id: input_files
    type:
      type: array
      items: File
    doc: Input bam files
    inputBinding:
      position: 101
      prefix: --inputFiles
  - id: log_level
    type:
      - 'null'
      - string
    doc: "Level of log information printed. Possible levels: 'debug', 'info', 'warn',
      'error'"
    inputBinding:
      position: 101
      prefix: --log_level
  - id: sample_config
    type: File
    doc: This works the same as for a normal input file. Difference is that it placed
      in a sub key 'tags' in the config file
    inputBinding:
      position: 101
      prefix: --sampleConfig
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file, if not given stdout is used
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biopet-sampleconfig:0.3--0
