cwlVersion: v1.2
class: CommandLineTool
baseCommand: mccortex_make-pipeline.pl
label: mccortex_make-pipeline.pl
doc: "A script to generate a McCortex pipeline. (Note: The provided input text contains
  container runtime error messages regarding disk space and does not include the actual
  help documentation or argument definitions for the tool.)\n\nTool homepage: https://github.com/mcveanlab/mccortex"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mccortex:1.0--h24782f9_7
stdout: mccortex_make-pipeline.pl.out
