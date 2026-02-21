cwlVersion: v1.2
class: CommandLineTool
baseCommand: transformation
label: transformation
doc: "A tool for data transformation (part of the PhenoMeNal metabolomics infrastructure).
  Note: The provided text is a log of a failed container build and does not contain
  explicit help documentation or argument definitions.\n\nTool homepage: https://github.com/wasabeef/glide-transformations"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/transformation:phenomenal-v2.2.2_cv1.2.8
stdout: transformation.out
