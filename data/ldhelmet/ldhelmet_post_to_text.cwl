cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ldhelmet
  - post_to_text
label: ldhelmet_post_to_text
doc: "Converts LDHelmet output files to text format.\n\nTool homepage: http://sourceforge.net/projects/ldhelmet/"
inputs:
  - id: input_file
    type: File
    doc: Input file for LDHelmet output
    inputBinding:
      position: 1
  - id: mean
    type:
      - 'null'
      - boolean
    doc: Specify option to output mean.
    inputBinding:
      position: 102
      prefix: --mean
  - id: percentiles
    type:
      - 'null'
      - type: array
        items: float
    doc: Percentile value. Specify option multiple times for multiple 
      percentiles.
    inputBinding:
      position: 102
      prefix: --perc
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Name of output file.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ldhelmet:1.10--h0704011_8
