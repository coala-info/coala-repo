cwlVersion: v1.2
class: CommandLineTool
baseCommand: ReadFromTsv
label: biopet-sampleconfig_readfromtsv
doc: "Converts TSV files containing sample and library information into a Biopet configuration
  file (YAML or JSON).\n\nTool homepage: https://github.com/biopet/sampleconfig"
inputs:
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Input must be a tsv file, first line is seen as header and must at least
      have a 'sample' column, 'library' column is optional, multiple files can be
      specified by using multiple flags.
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
  - id: tag_files
    type:
      - 'null'
      - type: array
        items: File
    doc: This works the same as for a normal input file. Difference is that it placed
      in a sub key 'tags' in the config file
    inputBinding:
      position: 101
      prefix: --tagFiles
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: When the extension is .yml or .yaml the output is in yaml format, otherwise
      it is in json. When no file is given the output goes to stdout as yaml.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biopet-sampleconfig:0.3--0
