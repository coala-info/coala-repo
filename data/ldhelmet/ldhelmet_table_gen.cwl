cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ldhelmet
  - table_gen
label: ldhelmet_table_gen
doc: "Generate tables for LDHelmet\n\nTool homepage: http://sourceforge.net/projects/ldhelmet/"
inputs:
  - id: conf_file
    type:
      - 'null'
      - string
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
      - 'null'
      - type: array
        items: float
    doc: Rho values.
    inputBinding:
      position: 101
      prefix: --rhos
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
