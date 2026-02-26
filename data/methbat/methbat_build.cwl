cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - methbat
  - build
label: methbat_build
doc: "Build a background/cohort profile from a collection of profiles\n\nTool homepage:
  https://github.com/PacificBiosciences/MethBat"
inputs:
  - id: input_collection
    type: File
    doc: Input file defining a cohort to load into a background profile 
      (CSV/TSV)
    inputBinding:
      position: 101
      prefix: --input-collection
outputs:
  - id: output_profile
    type: File
    doc: Output background profile (CSV/TSV)
    outputBinding:
      glob: $(inputs.output_profile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/methbat:0.17.0--h9ee0642_0
