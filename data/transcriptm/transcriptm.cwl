cwlVersion: v1.2
class: CommandLineTool
baseCommand: transcriptm
label: transcriptm
doc: "A tool for metatranscriptomic data processing (Note: The provided text is a
  container execution/build error log and does not contain help documentation or argument
  definitions).\n\nTool homepage: https://github.com/elfrouin/transcriptM"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/transcriptm:0.2--pyhdfd78af_0
stdout: transcriptm.out
