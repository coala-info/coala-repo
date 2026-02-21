cwlVersion: v1.2
class: CommandLineTool
baseCommand: ismrmrd-schema
label: ismrmrd-schema
doc: "A tool for handling or displaying ISMRMRD (International Society for Magnetic
  Resonance in Medicine Raw Data) schemas.\n\nTool homepage: https://github.com/ckolbPTB/xnat-ismrmrd"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/ismrmrd-schema:v1.4.0-1-deb_cv1
stdout: ismrmrd-schema.out
