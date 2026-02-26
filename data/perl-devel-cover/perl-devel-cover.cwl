cwlVersion: v1.2
class: CommandLineTool
baseCommand: cover
label: perl-devel-cover
doc: "A tool to generate code coverage reports for Perl using the Devel::Cover module.\n\
  \nTool homepage: http://www.pjcj.net/perl.html"
inputs:
  - id: coverage_database
    type:
      - 'null'
      - Directory
    doc: 'The directory containing the coverage database (default: cover_db)'
    inputBinding:
      position: 1
  - id: delete
    type:
      - 'null'
      - boolean
    doc: Delete existing database before running
    inputBinding:
      position: 102
      prefix: -delete
  - id: ignore
    type:
      - 'null'
      - type: array
        items: string
    doc: Regex for files to ignore
    inputBinding:
      position: 102
      prefix: -ignore
  - id: report
    type:
      - 'null'
      - string
    doc: Report format (html, text, json, etc.)
    inputBinding:
      position: 102
      prefix: -report
  - id: select
    type:
      - 'null'
      - type: array
        items: string
    doc: Regex for files to include
    inputBinding:
      position: 102
      prefix: -select
  - id: summary
    type:
      - 'null'
      - boolean
    doc: Give a summary report
    inputBinding:
      position: 102
      prefix: -summary
outputs:
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Directory for the output report
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-devel-cover:1.33--pl526h14c3975_0
