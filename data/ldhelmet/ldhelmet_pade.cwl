cwlVersion: v1.2
class: CommandLineTool
baseCommand: ldhelmet pade
label: ldhelmet_pade
doc: "Compute Pade coefficients for LDHelmet\n\nTool homepage: http://sourceforge.net/projects/ldhelmet/"
inputs:
  - id: conf_file
    type:
      - 'null'
      - File
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
    type:
      - 'null'
      - float
    doc: Theta value.
    inputBinding:
      position: 101
      prefix: --theta
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Name for output file.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ldhelmet:1.10--h0704011_8
