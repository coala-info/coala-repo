cwlVersion: v1.2
class: CommandLineTool
baseCommand: humanfilt
label: humanfilt
doc: "A tool for filtering human sequences from sequencing data. (Note: The provided
  text is a container execution error log and does not contain specific CLI usage
  or argument details).\n\nTool homepage: https://github.com/jprehn-lab/humanfilt"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/humanfilt:1.0.0--pyhdfd78af_0
stdout: humanfilt.out
