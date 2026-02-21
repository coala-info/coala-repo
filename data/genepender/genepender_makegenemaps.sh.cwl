cwlVersion: v1.2
class: CommandLineTool
baseCommand: genepender_makegenemaps.sh
label: genepender_makegenemaps.sh
doc: "A tool for creating gene maps. (Note: The provided help text contains only system
  error messages and no usage information).\n\nTool homepage: https://github.com/BioTools-Tek/genepender"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genepender:v2.6--h470a237_1
stdout: genepender_makegenemaps.sh.out
