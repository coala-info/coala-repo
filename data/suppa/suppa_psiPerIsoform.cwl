cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - suppa.py
  - psiPerIsoform
label: suppa_psiPerIsoform
doc: "Calculate the PSI value of each transcript isoform from the transcript expression of the samples.\n\nTool homepage: https://github.com/comprna/SUPPA"
inputs:
  - id: gtf_file
    type: File
    doc: Input gtf file
    inputBinding:
      position: 1
      prefix: --gtf-file
  - id: expression_file
    type: File
    doc: Input expression file
    inputBinding:
      position: 1
      prefix: --expression-file
  - id: output_file
    type: string
    doc: Path and name of the output file (the _isoform.psi suffix is added).
    inputBinding:
      position: 1
      prefix: --output-file
  - id: mode
    type:
      - 'null'
      - string
    doc: "to choose from DEBUG, INFO, WARNING, ERROR and CRITICAL"
    inputBinding:
      position: 1
      prefix: --mode
outputs:
  - id: psi_files
    type:
      type: array
      items: File
    doc: Isoform PSI values
    outputBinding:
      glob: $(inputs.output_file)*
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/suppa:2.4--pyhdfd78af_0
