cwlVersion: v1.2
class: CommandLineTool
baseCommand: selenzy_wrapper
label: selenzy_wrapper
doc: "A tool for enzyme selection and pathway analysis. (Note: The provided text is
  an error log and does not contain usage information or argument definitions.)\n\n
  Tool homepage: https://github.com/brsynth/selenzy-wrapper"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/selenzy_wrapper:0.3.0--pyhdfd78af_1
stdout: selenzy_wrapper.out
