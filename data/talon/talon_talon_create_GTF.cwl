cwlVersion: v1.2
class: CommandLineTool
baseCommand: talon_create_GTF
label: talon_talon_create_GTF
doc: "The provided text does not contain help information for the tool; it is a log
  of a failed container build process. Under normal circumstances, this tool is used
  to create a GTF file from a TALON database.\n\nTool homepage: https://github.com/mortazavilab/TALON"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/talon:6.0.1--pyhdfd78af_0
stdout: talon_talon_create_GTF.out
