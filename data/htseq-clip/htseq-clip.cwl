cwlVersion: v1.2
class: CommandLineTool
baseCommand: htseq-clip
label: htseq-clip
doc: "A tool for processing CLIP-seq data (Note: The provided text contains system
  error messages and does not include the actual help documentation for the tool's
  arguments).\n\nTool homepage: https://github.com/EMBL-Hentze-group/htseq-clip"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/htseq-clip:2.19.0b0--pyh086e186_0
stdout: htseq-clip.out
