cwlVersion: v1.2
class: CommandLineTool
baseCommand: pythomics_fetch_cufflinks_transcripts
label: pythomics_fetch_cufflinks_transcripts
doc: "A tool from the pythomics package. (Note: The provided help text contained system
  logs and error messages rather than command-line usage information, so no arguments
  could be extracted.)\n\nTool homepage: https://github.com/pandeylab/pythomics"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pythomics:0.4.1--pyh7cba7a3_0
stdout: pythomics_fetch_cufflinks_transcripts.out
