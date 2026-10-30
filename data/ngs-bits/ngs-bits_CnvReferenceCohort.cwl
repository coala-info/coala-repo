cwlVersion: v1.2
class: CommandLineTool
baseCommand: CnvReferenceCohort
label: ngs-bits_CnvReferenceCohort
doc: "Create a reference cohort for CNV calling from a list of coverage profiles.\n\nThis tool creates a reference cohort for CNV calling by analyzing the correlation between the main sample coverage profile and a list of reference coverage profiles.\nThe coverage profiles of the samples that correlate best with the main sample are saved in the output TSV file.\nThe TSV file contains the chromosome, start, and end positions in the first three columns, with subsequent columns showing the coverage for each selected reference file.\n\nTool homepage: https://github.com/imgag/ngs-bits"
inputs:
  - id: input_file
    type: File
    doc: "Coverage profile of main sample in BED format."
    inputBinding:
      position: 101
      prefix: -in
  - id: in_ref
    type:
      type: array
      items: File
    doc: "Reference coverage profiles of other sample in BED format (GZ files supported)."
    inputBinding:
      position: 101
      prefix: -in_ref
  - id: output_file_path
    type: string
    doc: "Output TSV file with coverage profiles of selected reference samples."
    inputBinding:
      position: 102
      prefix: -out
  - id: exclude
    type:
      - 'null'
      - type: array
        items: File
    doc: "Regions in the given BED file(s) are excluded from the coverage calcualtion, e.g. copy-number polymorphic regions."
    inputBinding:
      position: 101
      prefix: -exclude
  - id: cov_max
    type:
      - 'null'
      - int
    doc: "Best n reference coverage files to include in 'out' based on correlation. Default value: '150'"
    inputBinding:
      position: 101
      prefix: -cov_max
  - id: debug
    type:
      - 'null'
      - boolean
    doc: "Enable debug output. Default value: 'false'"
    inputBinding:
      position: 101
      prefix: -debug
  - id: settings
    type:
      - 'null'
      - File
    doc: "Settings override file (no other settings files are used)."
    inputBinding:
      position: 101
      prefix: --settings
outputs:
  - id: output_file
    type: File
    doc: "Output TSV file with coverage profiles of selected reference samples."
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
