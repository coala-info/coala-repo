cwlVersion: v1.2
class: CommandLineTool
baseCommand: FetchSequence
label: biobasehttptools_FetchSequence
doc: "Fetch sequences using biobasehttptools. (Note: The provided input text contains
  system error messages regarding a container build failure and does not include the
  actual help documentation for the tool.)\n\nTool homepage: https://github.com/eggzilla/BiobaseHTTPTools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biobasehttptools:1.1.0--0
stdout: biobasehttptools_FetchSequence.out
