cwlVersion: v1.2
class: CommandLineTool
baseCommand: onsite
label: pyonsite_onsite
doc: "Mass spectrometry post-translational modification localization tool\n\nTool
  homepage: https://www.github.com/bigbio/onsite"
inputs:
  - id: command
    type: string
    doc: Command to run (all, ascore, lucxor, phosphors)
    inputBinding:
      position: 1
  - id: args
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments for the command
    inputBinding:
      position: 2
  - id: add_decoys
    type:
      - 'null'
      - boolean
    doc: Add decoys when running all algorithms
    inputBinding:
      position: 103
      prefix: --add-decoys
  - id: identification_file
    type: File
    doc: Input identification file (e.g., idXML)
    inputBinding:
      position: 103
      prefix: -id
  - id: input_file
    type: File
    doc: Input spectra file (e.g., mzML)
    inputBinding:
      position: 103
      prefix: -in
outputs:
  - id: output_file
    type: File
    doc: Output file name
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyonsite:0.0.2--pyhdfd78af_0
