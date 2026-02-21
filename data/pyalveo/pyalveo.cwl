cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyalveo
label: pyalveo
doc: "The provided text does not contain help information or usage instructions; it
  is an error log from a container runtime (Singularity/Apptainer) failing to fetch
  or build the tool's image.\n\nTool homepage: https://github.com/Alveo/pyalveo"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyalveo:1.0.3--py27_0
stdout: pyalveo.out
