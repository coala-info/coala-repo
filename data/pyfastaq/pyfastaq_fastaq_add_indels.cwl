cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fastaq
  - add_indels
label: pyfastaq_fastaq_add_indels
doc: "Deletes or inserts bases at given position(s)\n\nTool homepage: https://github.com/sanger-pathogens/Fastaq"
inputs:
  - id: delete
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --delete
    doc: "Delete the given bases from the given sequence. Format same as samtools view: name:start-end. This option can be used multiple times (once for each region to delete). Overlapping coords will be merged before deleting"
    inputBinding:
      position: 1
  - id: delete_range
    type:
      - 'null'
      - string
    doc: "Deletes bases starting at position P in each sequence of the input file. Deletes start + (n-1)*step bases from sequence n."
    inputBinding:
      position: 2
      prefix: --delete_range
  - id: insert
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --insert
    doc: "Insert a random string of bases at the given position. Format is name:position:number_to_add. Bases are added after the position. This option can be used multiple times"
    inputBinding:
      position: 3
  - id: insert_range
    type:
      - 'null'
      - string
    doc: "Inserts random bases starting after position P in each sequence of the input file. Inserts start + (n-1)*step bases into sequence n."
    inputBinding:
      position: 4
      prefix: --insert_range
  - id: infile
    type: File
    doc: "Name of input file"
    inputBinding:
      position: 20
  - id: outfile
    type: string
    doc: "Name of output file"
    inputBinding:
      position: 21
outputs:
  - id: output
    type: File
    doc: "Name of output file"
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyfastaq:3.18.0--pyhdfd78af_0
