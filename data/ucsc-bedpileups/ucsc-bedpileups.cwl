cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bedPileUps
label: ucsc-bedpileups
doc: "Find (exact) overlaps if any in bed input. The in.bed file must be sorted by
  chromosome,start. Results are written to standard output.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
stdout: $(inputs.out_name)
stderr: $(inputs.out_name).log
inputs:
  - id: in_bed
    type: File
    doc: Input BED file in one of the ascii bed formats, sorted by chromosome and
      start.
    inputBinding:
      position: 1
  - id: out_name
    type: string
    doc: Name of the file that receives standard output.
  - id: name
    type:
      - 'null'
      - boolean
    doc: Include BED name field 4 when evaluating uniqueness.
    inputBinding:
      position: 0
      prefix: -name
  - id: tab
    type:
      - 'null'
      - boolean
    doc: Use tabs to parse fields.
    inputBinding:
      position: 0
      prefix: -tab
  - id: verbose
    type:
      - 'null'
      - int
    doc: Set to 2 to show the location and size of each pileUp (written to standard
      error).
    inputBinding:
      position: 0
      prefix: -verbose=
      separate: false
outputs:
  - id: output_file
    type: File
    doc: Standard output of the program.
    outputBinding:
      glob: $(inputs.out_name)
  - id: log
    type: File
    doc: Messages from the program (standard error).
    outputBinding:
      glob: $(inputs.out_name).log
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-bedpileups:482--h0b57e2e_0
