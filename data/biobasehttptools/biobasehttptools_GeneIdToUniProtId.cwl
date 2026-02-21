cwlVersion: v1.2
class: CommandLineTool
baseCommand: GeneIdToUniProtId
label: biobasehttptools_GeneIdToUniProtId
doc: "A tool from the biobasehttptools suite to convert Gene IDs to UniProt IDs. (Note:
  The provided text contains system error logs regarding a container build failure
  and does not include the actual command-line help documentation; therefore, no arguments
  could be extracted.)\n\nTool homepage: https://github.com/eggzilla/BiobaseHTTPTools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biobasehttptools:1.1.0--0
stdout: biobasehttptools_GeneIdToUniProtId.out
