cwlVersion: v1.2
class: CommandLineTool
baseCommand: vt
label: vt
doc: "A tool for variant manipulation (Note: The provided text is a container runtime
  error log and does not contain the actual help documentation for the tool).\n\n
  Tool homepage: https://github.com/Aikoyori/ProgrammingVTuberLogos"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vt:2015.11.10--2
stdout: vt.out
