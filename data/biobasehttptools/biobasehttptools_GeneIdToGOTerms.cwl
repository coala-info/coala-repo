cwlVersion: v1.2
class: CommandLineTool
baseCommand: GeneIdToGOTerms
label: biobasehttptools_GeneIdToGOTerms
doc: "A tool from the biobasehttptools suite to map Gene IDs to GO Terms. (Note: The
  provided help text contains system error logs and does not list specific command-line
  arguments.)\n\nTool homepage: https://github.com/eggzilla/BiobaseHTTPTools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biobasehttptools:1.1.0--0
stdout: biobasehttptools_GeneIdToGOTerms.out
