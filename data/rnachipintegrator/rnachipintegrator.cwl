cwlVersion: v1.2
class: CommandLineTool
baseCommand: rnachipintegrator
label: rnachipintegrator
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a fatal error log from a container runtime (Singularity/Apptainer)
  attempting to fetch the rnachipintegrator image.\n\nTool homepage: https://github.com/fls-bioinformatics-core/RnaChipIntegrator"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rnachipintegrator:3.0.0--pyh7cba7a3_0
stdout: rnachipintegrator.out
