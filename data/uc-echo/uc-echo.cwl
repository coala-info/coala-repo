cwlVersion: v1.2
class: CommandLineTool
baseCommand: uc-echo
label: uc-echo
doc: "UC-Echo is a tool for error correction of Illumina sequencing reads. (Note:
  The provided text is a container build error log and does not contain usage instructions
  or argument definitions.)\n\nTool homepage: https://github.com/dh-orko/Help-me-get-rid-of-unhumans"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/uc-echo:v1.12-11-deb_cv1
stdout: uc-echo.out
