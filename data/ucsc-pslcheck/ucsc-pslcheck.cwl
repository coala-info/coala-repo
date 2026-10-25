cwlVersion: v1.2
class: CommandLineTool
baseCommand: pslCheck
label: ucsc-pslcheck
doc: "validate PSL files\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: psl_files
    type: File[]
    doc: "PSL file(s) to validate (fileTbl(s))."
    inputBinding:
      position: 1
  - id: db
    type:
      - 'null'
      - string
    doc: "Get targetSizes from this database, and if the file does not exist, look for a table in this database."
    inputBinding:
      position: 0
      prefix: "-db="
      separate: false
  - id: prot
    type:
      - 'null'
      - boolean
    doc: "Confirm psls are protein psls."
    inputBinding:
      position: 0
      prefix: "-prot"
  - id: no_count_check
    type:
      - 'null'
      - boolean
    doc: "Do not validate that match/mismatch counts match the total size of the alignment blocks."
    inputBinding:
      position: 0
      prefix: "-noCountCheck"
  - id: pass_psl
    type:
      - 'null'
      - string
    doc: "Write PSLs without errors to this file."
    inputBinding:
      position: 0
      prefix: "-pass="
      separate: false
  - id: fail_psl
    type:
      - 'null'
      - string
    doc: "Write PSLs with errors to this file."
    inputBinding:
      position: 0
      prefix: "-fail="
      separate: false
  - id: filter
    type:
      - 'null'
      - boolean
    doc: "Use the program as a filter, with -pass and/or -fail: do not exit with an error on problems, but report them."
    inputBinding:
      position: 0
      prefix: "-filter"
  - id: target_sizes
    type:
      - 'null'
      - File
    doc: "Tab file with columns of target and size. If specified, the psl is checked to have a valid target and target coordinates."
    inputBinding:
      position: 0
      prefix: "-targetSizes="
      separate: false
  - id: skip_insert_counts
    type:
      - 'null'
      - boolean
    doc: "Do not validate insert counts (useful for BLAT protein PSLs)."
    inputBinding:
      position: 0
      prefix: "-skipInsertCounts"
  - id: query_sizes
    type:
      - 'null'
      - File
    doc: "File with query sizes."
    inputBinding:
      position: 0
      prefix: "-querySizes="
      separate: false
  - id: ignore_q_uniq
    type:
      - 'null'
      - boolean
    doc: "Ignore everything after the last '-' in the qName field."
    inputBinding:
      position: 0
      prefix: "-ignoreQUniq"
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: "Do not write error messages, just filter."
    inputBinding:
      position: 0
      prefix: "-quiet"
outputs:
  - id: pass_file
    type:
      - 'null'
      - File
    doc: "PSLs without errors."
    outputBinding:
      glob: $(inputs.pass_psl)
  - id: fail_file
    type:
      - 'null'
      - File
    doc: "PSLs with errors."
    outputBinding:
      glob: $(inputs.fail_psl)
  - id: stdout
    type: stdout
    doc: "Standard output"
  - id: stderr
    type: stderr
    doc: "Standard error"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-pslcheck:482--h0b57e2e_0
stdout: ucsc-pslcheck.out
stderr: ucsc-pslcheck.err
