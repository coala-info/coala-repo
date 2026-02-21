cwlVersion: v1.2
class: CommandLineTool
baseCommand: sipros_makeDBforLabelSearch.R
label: sipros_makeDBforLabelSearch.R
doc: "A script to prepare databases for label-based searches in Sipros. Note: The
  provided help text contains only container runtime logs and a fatal error, so specific
  arguments could not be extracted.\n\nTool homepage: https://github.com/thepanlab/Sipros4"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sipros:5.0.1--hdfd78af_1
stdout: sipros_makeDBforLabelSearch.R.out
