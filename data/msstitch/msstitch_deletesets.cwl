cwlVersion: v1.2
class: CommandLineTool
baseCommand: msstitch_deletesets
label: msstitch_deletesets
doc: "Deletes sets from a multispecies stitch file.\n\nTool homepage: https://github.com/lehtiolab/msstitch"
inputs:
  - id: dbfile
    type:
      - 'null'
      - File
    doc: Database lookup file
    inputBinding:
      position: 101
      prefix: --dbfile
  - id: in_memory
    type:
      - 'null'
      - boolean
    doc: Load sqlite lookup in memory in case of not having access to a fast 
      file system
    inputBinding:
      position: 101
      prefix: --in-memory
  - id: input_file
    type: File
    doc: Input file of {} format
    inputBinding:
      position: 101
      prefix: -i
  - id: setnames
    type:
      type: array
      items: string
    doc: Names of biological sets. Can be specified with quotation marks if 
      spaces are used
    inputBinding:
      position: 101
      prefix: --setnames
outputs:
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Directory to output in
    outputBinding:
      glob: $(inputs.output_directory)
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/msstitch:3.19--pyhdfd78af_0
