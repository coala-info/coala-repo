cwlVersion: v1.2
class: CommandLineTool
baseCommand: pslCheck
label: ucsc-pslsomerecords_pslCheck
doc: "Check PSL files for consistency.\n\nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs:
  - id: psl_file
    type: File
    doc: The PSL file to check for consistency.
    inputBinding:
      position: 1
  - id: query_sizes
    type:
      - 'null'
      - File
    doc: Check that query sizes are correct using the specified file.
    inputBinding:
      position: 102
      prefix: -querySizes
  - id: target_sizes
    type:
      - 'null'
      - File
    doc: Check that target sizes are correct using the specified file.
    inputBinding:
      position: 102
      prefix: -targetSizes
  - id: verbose
    type:
      - 'null'
      - int
    doc: Set verbosity level.
    inputBinding:
      position: 102
      prefix: -verbose
outputs:
  - id: out
    type:
      - 'null'
      - File
    doc: Write errors to the specified file.
    outputBinding:
      glob: $(inputs.out)
  - id: fail
    type:
      - 'null'
      - File
    doc: Write failed records to the specified file.
    outputBinding:
      glob: $(inputs.fail)
  - id: pass
    type:
      - 'null'
      - File
    doc: Write passed records to the specified file.
    outputBinding:
      glob: $(inputs.pass)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-pslsomerecords:482--h0b57e2e_0
