cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - genomad
  - aggregated-classification
label: genomad_aggregated-classification
doc: "Aggregate the results of the marker-classification and nn-classification modules to classify the sequences in the INPUT file (FASTA format) and write the results to the OUTPUT directory.\n\nTool homepage: https://portal.nersc.gov/genomad/"
inputs:
  - id: input
    type: File
    doc: "Input FASTA file."
    inputBinding:
      position: 1
  - id: previous_dir
    type: Directory
    doc: "Output directory of previous geNomad runs on the same INPUT (marker-classification and nn-classification). It is copied to the OUTPUT directory (named by 'output') before this module runs, because this module reads the earlier results from there."
  - id: output
    type: string
    doc: "Output directory."
    inputBinding:
      position: 2
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: "Display the execution log."
    inputBinding:
      position: 103
      prefix: --quiet
  - id: restart
    type:
      - 'null'
      - boolean
    doc: "Overwrite existing intermediate files."
    inputBinding:
      position: 103
      prefix: --restart
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Display the execution log."
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: out_output
    type: Directory
    doc: "Output directory."
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.previous_dir)
        entryname: $(inputs.output)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genomad:1.11.2--pyhdfd78af_0
