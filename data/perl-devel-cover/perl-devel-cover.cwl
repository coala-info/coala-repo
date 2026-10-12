cwlVersion: v1.2
class: CommandLineTool
baseCommand: cover
label: perl-devel-cover
doc: "Report code coverage from the databases that Devel::Cover collected (cover_db directories).\n\nTool homepage: http://www.pjcj.net/perl.html"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.coverage_database)
        writable: true
inputs:
  - id: coverage_database
    type: Directory
    doc: The coverage database directory (for example cover_db). The reports are written into a copy of it.
    inputBinding:
      position: 100
      valueFrom: $(self.basename)
  - id: silent
    type:
      - 'null'
      - boolean
    doc: Do not print informational messages
    inputBinding:
      position: 1
      prefix: -silent
  - id: summary
    type:
      - 'null'
      - boolean
    doc: Give a summary report (default on)
    inputBinding:
      position: 1
      prefix: -summary
  - id: report
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: -report
    doc: Report format, for example html, html_basic, text, json, compilation (may be given several times)
    inputBinding:
      position: 1
  - id: outputdir
    type:
      - 'null'
      - string
    doc: Directory for the output (default is the coverage database)
    inputBinding:
      position: 1
      prefix: -outputdir
  - id: select
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: -select
    doc: Only report on the file (may be given several times)
    inputBinding:
      position: 1
  - id: ignore
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: -ignore
    doc: Do not report on the file (may be given several times)
    inputBinding:
      position: 1
  - id: select_re
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: -select_re
    doc: Append to the regular expressions of files to select (may be given several times)
    inputBinding:
      position: 1
  - id: ignore_re
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: -ignore_re
    doc: Append to the regular expressions of files to ignore (may be given several times)
    inputBinding:
      position: 1
  - id: write
    type:
      - 'null'
      - boolean
    doc: Write the merged database
    inputBinding:
      position: 1
      prefix: -write
  - id: delete
    type:
      - 'null'
      - boolean
    doc: Drop the database(s)
    inputBinding:
      position: 1
      prefix: -delete
  - id: dump_db
    type:
      - 'null'
      - boolean
    doc: Dump the database(s) (for debugging)
    inputBinding:
      position: 1
      prefix: -dump_db
  - id: coverage
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: -coverage
    doc: Report on this criterion, for example statement, branch, condition, subroutine, pod, time (may be given several times; default all available)
    inputBinding:
      position: 1
  - id: test
    type:
      - 'null'
      - boolean
    doc: Drop the database(s) and run make test
    inputBinding:
      position: 1
      prefix: -test
  - id: gcov
    type:
      - 'null'
      - boolean
    doc: Run gcov to cover XS code
    inputBinding:
      position: 1
      prefix: -gcov
  - id: make
    type:
      - 'null'
      - string
    doc: Use the given make program for make test
    inputBinding:
      position: 1
      prefix: -make
  - id: prefer_lib
    type:
      - 'null'
      - boolean
    doc: Prefer files in lib
    inputBinding:
      position: 1
      prefix: -prefer_lib
  - id: add_uncoverable_point
    type:
      - 'null'
      - string
    doc: Add an uncoverable point
    inputBinding:
      position: 1
      prefix: -add_uncoverable_point
  - id: delete_uncoverable_point
    type:
      - 'null'
      - string
    doc: Delete an uncoverable point
    inputBinding:
      position: 1
      prefix: -delete_uncoverable_point
  - id: clean_uncoverable_points
    type:
      - 'null'
      - boolean
    doc: Clean the uncoverable points
    inputBinding:
      position: 1
      prefix: -clean_uncoverable_points
  - id: uncoverable_file
    type:
      - 'null'
      - string
    doc: File with uncoverable points
    inputBinding:
      position: 1
      prefix: -uncoverable_file
outputs:
  - id: report_directory
    type: Directory
    doc: The coverage database directory with the generated reports (or the -outputdir directory)
    outputBinding:
      glob: |
        ${ return inputs.outputdir ? inputs.outputdir : inputs.coverage_database.basename; }
  - id: stdout
    type: stdout
    doc: Summary report on standard output
stdout: cover_summary.txt
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-devel-cover:1.33--pl526h14c3975_0
