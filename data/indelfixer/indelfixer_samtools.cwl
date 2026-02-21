cwlVersion: v1.2
class: CommandLineTool
baseCommand: indelfixer
label: indelfixer_samtools
doc: "The provided text is an error message indicating a failure to build or run the
  container image (no space left on device) and does not contain help text or usage
  information for the tool.\n\nTool homepage: https://github.com/cbg-ethz/InDelFixer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/indelfixer:1.1--0
stdout: indelfixer_samtools.out
