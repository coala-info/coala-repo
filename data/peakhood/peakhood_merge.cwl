cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - peakhood
  - merge
label: peakhood_merge
doc: "Merge peakhood results\n\nTool homepage: https://github.com/BackofenLab/Peakhood"
inputs:
  - id: gtf_file
    type:
      - 'null'
      - File
    doc: GTF file for annotation
    inputBinding:
      position: 101
      prefix: --gtf
  - id: input_files
    type:
      type: array
      items: string
    doc: Input files to merge
    inputBinding:
      position: 101
      prefix: --in
  - id: report
    type:
      - 'null'
      - boolean
    doc: Generate a report
    inputBinding:
      position: 101
      prefix: --report
outputs:
  - id: output_file
    type: File
    doc: Output file path
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/peakhood:0.3--pyhdfd78af_0
