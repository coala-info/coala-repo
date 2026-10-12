cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pecat.pl
  - config
label: pecat_config
doc: "Generate a default PECAT configuration file.

Tool homepage: https://github.com/lemene/PECAT"
inputs:
  - id: cfg_fname
    type: string
    doc: Name of the configuration file to write
    inputBinding:
      position: 1
outputs:
  - id: config_file
    type: File
    doc: Default configuration file
    outputBinding:
      glob: $(inputs.cfg_fname)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pecat:0.0.3--hdb21b49_2
