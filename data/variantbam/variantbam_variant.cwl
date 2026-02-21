cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - variantbam
  - variant
label: variantbam_variant
doc: "VariantBAM is a tool for filtering and profiling BAM files. (Note: The provided
  help text contains only container runtime error logs and does not list specific
  command-line arguments.)\n\nTool homepage: https://github.com/jwalabroad/VariantBam"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/variantbam:1.4.3--0
stdout: variantbam_variant.out
