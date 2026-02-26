cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pyroe
  - id-to-name
label: pyroe_id-to-name
doc: "Converts gene/transcript IDs to names from a GTF/GFF3 file.\n\nTool homepage:
  https://github.com/COMBINE-lab/pyroe"
inputs:
  - id: gtf_file
    type: File
    doc: The GTF input file.
    inputBinding:
      position: 1
  - id: format
    type:
      - 'null'
      - string
    doc: The input format of the file (must be either GTF or GFF3). This will be
      inferred from the filename, but if that fails it can be provided 
      explicitly.
    inputBinding:
      position: 102
      prefix: --format
outputs:
  - id: output
    type: File
    doc: The path to where the output tsv file will be written.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyroe:0.9.3--pyhdfd78af_0
