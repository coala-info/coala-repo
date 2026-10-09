cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ldhelmet
  - pade
label: ldhelmet_pade
doc: "Compute Pade coefficients for LDHelmet\n\nTool homepage: http://sourceforge.net/projects/ldhelmet/"
inputs:
  - id: conf_file
    type: File
    doc: Two-site configuration file.
    inputBinding:
      position: 101
      prefix: --conf_file
  - id: defect_threshold
    type:
      - 'null'
      - int
    doc: Defect threshold for Pade coefficients.
    inputBinding:
      position: 101
      prefix: --defect_threshold
  - id: num_coeff
    type:
      - 'null'
      - int
    doc: Number of Pade coefficients to compute.
    inputBinding:
      position: 101
      prefix: --num_coeff
  - id: num_threads
    type:
      - 'null'
      - int
    doc: Number of threads to use.
    inputBinding:
      position: 101
      prefix: --num_threads
  - id: theta
    type: float
    doc: Theta value.
    inputBinding:
      position: 101
      prefix: --theta
  - id: output_file_path
    type: string
    doc: Name for output file.
    inputBinding:
      position: 102
      prefix: --output_file
outputs:
  - id: output_file
    type: File
    doc: Name for output file.
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ldhelmet:1.10--h0704011_8
