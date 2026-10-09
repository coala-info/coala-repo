cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ldhelmet
  - table_gen
label: ldhelmet_table_gen
doc: "Generate tables for LDHelmet\n\nTool homepage: http://sourceforge.net/projects/ldhelmet/"
inputs:
  - id: conf_file
    type: File
    doc: Two-site configuration file.
    inputBinding:
      position: 101
      prefix: --conf_file
  - id: num_threads
    type:
      - 'null'
      - int
    doc: Number of threads to use.
    inputBinding:
      position: 101
      prefix: --num_threads
  - id: rhos
    type:
      type: array
      items: float
    doc: Rho values.
    inputBinding:
      position: 101
      prefix: --rhos
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
