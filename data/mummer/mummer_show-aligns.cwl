cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - show-aligns
label: mummer_show-aligns
doc: "Show the pairwise alignments between a reference and a query sequence of a delta file.\n\nTool homepage: https://github.com/mummer4/mummer"
requirements:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mummer:3.23--pl5321hdbdd923_18
    dockerOutputDirectory: /data
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.reference)
      - $(inputs.query)
inputs:
  - id: sort_query
    type:
      - 'null'
      - boolean
    doc: "Sort alignments by the query start coordinate"
    inputBinding:
      position: 1
      prefix: "-q"
  - id: sort_reference
    type:
      - 'null'
      - boolean
    doc: "Sort alignments by the reference start coordinate"
    inputBinding:
      position: 1
      prefix: "-r"
  - id: width
    type:
      - 'null'
      - int
    doc: "Set the screen width - default is 60"
    inputBinding:
      position: 1
      prefix: "-w"
  - id: matrix
    type:
      - 'null'
      - int
    doc: "Set the matrix type - default is 2 (BLOSUM 62), other options include 1 (BLOSUM 45) and 3 (BLOSUM 80); only has effect on amino acid alignments"
    inputBinding:
      position: 1
      prefix: "-x"
  - id: delta_file
    type: File
    doc: "Delta alignment file from nucmer or promer"
    inputBinding:
      position: 100
  - id: ref_id
    type: string
    doc: "Reference sequence ID"
    inputBinding:
      position: 101
  - id: qry_id
    type: string
    doc: "Query sequence ID"
    inputBinding:
      position: 102
  - id: reference
    type: File
    doc: "The delta file records the absolute path of this sequence file, so it is staged in the working directory /data, the same place nucmer or promer used. Reference sequence file named in the delta file."
  - id: query
    type: File
    doc: "The delta file records the absolute path of this sequence file, so it is staged in the working directory /data, the same place nucmer or promer used. Query sequence file named in the delta file."
outputs:
  - id: stdout_out
    type: stdout
    doc: "Alignments between the query and reference sequences"
  - id: log
    type: stderr
    doc: "Progress and warning messages"
stdout: mummer_show-aligns.aligns
stderr: mummer_show-aligns.log
