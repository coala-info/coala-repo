cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pyfba
  - compare_media
label: pyfba_compare_media
doc: "Import a list of reactions and then compare growth on two media conditions to identify essential/non-essential media\n\nTool homepage: https://linsalrob.github.io/PyFBA/"
inputs:
  - id: reactions
    type: File
    doc: "reactions file"
    inputBinding:
      position: 1
      prefix: --reactions
  - id: positive
    type: string
    doc: "media name where we should grow"
    inputBinding:
      position: 1
      prefix: --positive
  - id: negative
    type: string
    doc: "media name where we should not grow"
    inputBinding:
      position: 1
      prefix: --negative
  - id: output_path
    type: string
    doc: "file to save new reaction list to"
    inputBinding:
      position: 1
      prefix: --output
  - id: type
    type:
      - 'null'
      - string
    doc: "organism type for the model (currently allowed are ['gramnegative', 'grampositive', 'microbial', 'mycobacteria', 'plant']). Default=gramnegative"
    inputBinding:
      position: 1
      prefix: --type
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "verbose output"
    inputBinding:
      position: 1
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output
    type: File
    doc: "Reactions required for growth in the positive media"
    outputBinding:
      glob: $(inputs.output_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyfba:2.62--py38h3df17bf_5
stdout: pyfba_compare_media.out
