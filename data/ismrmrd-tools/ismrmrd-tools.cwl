cwlVersion: v1.2
class: CommandLineTool
baseCommand: ismrmrd-tools
label: ismrmrd-tools
doc: "A set of tools for working with ISMRMRD (International Society for Magnetic
  Resonance in Medicine Raw Data) files. (Note: The provided text is a system error
  log and does not contain specific help documentation for the tool's arguments.)\n
  \nTool homepage: https://github.com/ismrmrd/ismrmrd-python-tools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/ismrmrd-tools:v1.4.0-1-deb_cv1
stdout: ismrmrd-tools.out
