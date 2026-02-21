cwlVersion: v1.2
class: CommandLineTool
baseCommand: xsd
label: xsd
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain the help text or usage information for the 'xsd' tool. As a
  result, no arguments could be extracted.\n\nTool homepage: https://github.com/tefra/xsdata"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/xsd:4.0.0_dep--h7208437_6
stdout: xsd.out
