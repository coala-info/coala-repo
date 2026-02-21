cwlVersion: v1.2
class: CommandLineTool
baseCommand: compareMS2
label: comparems2_compareMS2
doc: "compareMS2 is developed to compare, globally, all MS/MS spectra between two
  datasets (in Mascot Generic Format or MGF) acquired under similar conditions. This
  may be useful for differentiating samples or molecular phylogenetics based on shared
  peptide sequences quantified by the number or frequency of highly similar tandem
  mass spectra.\n\nTool homepage: http://www.ms-utils.org/compareMS2.html"
inputs:
  - id: first_dataset
    type: File
    doc: first dataset filename
    inputBinding:
      position: 101
      prefix: '-1'
  - id: max_precursor_mass_diff
    type:
      - 'null'
      - float
    doc: maximum difference in precursor mass
    inputBinding:
      position: 101
      prefix: -p
  - id: second_dataset
    type: File
    doc: second dataset filename
    inputBinding:
      position: 101
      prefix: '-2'
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: output filename
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/comparems2:1--h7b50bb2_7
