cwlVersion: v1.2
class: CommandLineTool
baseCommand: amrfinder
label: ncbi-amr_amrfinder
doc: "NCBI Antimicrobial Resistance Finder. (Note: The provided input text contains
  system error messages regarding container execution and does not include the actual
  help documentation or argument list.)\n\nTool homepage: https://github.com/ncbi/amr/wiki"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ncbi-amr:1.04--h6bb024c_0
stdout: ncbi-amr_amrfinder.out
