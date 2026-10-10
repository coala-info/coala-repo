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
  - id: output_profile_path
    type: string
    doc: Output background profile (CSV/TSV)
    inputBinding:
      position: 102
      prefix: --output-profile
  - id: collection_files
    type:
      type: array
      items: File
    doc: Profile files named in the cohort file, staged in the working directory so the names resolve.
outputs:
  - id: output_profile
    type: File
    doc: Output background profile (CSV/TSV)
    outputBinding:
      glob: $(inputs.output_profile_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: $(inputs.collection_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/methbat:0.17.0--h9ee0642_0
