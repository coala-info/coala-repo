cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - select_for_randfold.pl
label: mirdeep2_select_for_randfold.pl
doc: "Identify potential precursors whose structure is consistent with Dicer recognition; the ids are printed one per line\n\nTool homepage: https://github.com/rajewsky-lab/mirdeep2"
inputs:
  - id: file_signature
    type: File
    doc: Signature file in arf format
    inputBinding:
      position: 1
  - id: file_structure
    type: File
    doc: RNAfold structure file of the potential precursors
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Ids of the selected precursors, one per line
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mirdeep2:2.0.1.3--hdfd78af_2
stdout: precursors_for_randfold.ids
