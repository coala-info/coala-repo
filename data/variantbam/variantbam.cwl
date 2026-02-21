cwlVersion: v1.2
class: CommandLineTool
baseCommand: variantbam
label: variantbam
doc: "The provided text does not contain help information for variantbam; it is an
  error log from a container runtime (Singularity/Apptainer) failing to fetch the
  image.\n\nTool homepage: https://github.com/jwalabroad/VariantBam"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/variantbam:1.4.3--0
stdout: variantbam.out
