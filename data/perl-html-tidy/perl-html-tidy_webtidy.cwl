cwlVersion: v1.2
class: CommandLineTool
baseCommand: webtidy
label: perl-html-tidy_webtidy
doc: "webtidy v1.60 using tidyp v1.04 - A tool to tidy HTML from files or URLs\n\n
  Tool homepage: http://github.com/petdance/html-tidy"
inputs:
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: HTML files to check
    inputBinding:
      position: 1
  - id: context
    type:
      - 'null'
      - int
    doc: Show the offending line (and n surrounding lines)
    inputBinding:
      position: 102
      prefix: --context=
      separate: false
  - id: no_errors
    type:
      - 'null'
      - boolean
    doc: Ignore errors
    inputBinding:
      position: 102
      prefix: --noerrors
  - id: no_warnings
    type:
      - 'null'
      - boolean
    doc: Ignore warnings
    inputBinding:
      position: 102
      prefix: --nowarnings
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-html-tidy:1.60--pl5321h7b50bb2_7
stdout: perl-html-tidy_webtidy.out
