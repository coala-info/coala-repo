cwlVersion: v1.2
class: CommandLineTool
baseCommand: msstitch deduppsms
label: msstitch_deduppsms
doc: "Deduplicate spectra based on peptide sequences.\n\nTool homepage: https://github.com/lehtiolab/msstitch"
inputs:
  - id: input_file
    type: File
    doc: Input file of {} format
    inputBinding:
      position: 101
      prefix: -i
  - id: peptide_column_pattern
    type:
      - 'null'
      - string
    doc: Regular expression pattern to find header field in table where peptide 
      sequences are stored
    inputBinding:
      position: 101
      prefix: --peptidecolpattern
  - id: spectra_column
    type:
      - 'null'
      - int
    doc: Column number in which spectra file names are, in case some framework 
      has changed the file names. First column number is 1.
    inputBinding:
      position: 101
      prefix: --spectracol
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
