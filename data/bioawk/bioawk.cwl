cwlVersion: v1.2
class: CommandLineTool
baseCommand: /usr/local/bin/bioawk
label: bioawk
doc: BWK awk modified for biological data
inputs:
  - id: prog
    type:
      - 'null'
      - string
    doc: Bioawk program string
    inputBinding:
      position: 1
  - id: files
    type:
      - 'null'
      - type: array
        items: File
    doc: Input file(s)
    inputBinding:
      position: 2
  - id: field_separator
    type:
      - 'null'
      - string
    doc: Define input field separator
    inputBinding:
      position: 103
      prefix: -F
  - id: assign_var
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: -v
          separate: true
    doc: Assign value to variable (var=value)
    inputBinding:
      position: 103
  - id: format
    type:
      - 'null'
      - string
    doc: Input format (e.g. bed, sam, vcf, gff, fastx)
    inputBinding:
      position: 103
      prefix: -c
  - id: tabs
    type:
      - 'null'
      - boolean
    doc: Set input and output field separator to tab
    inputBinding:
      position: 103
      prefix: -t
      separate: false
  - id: header
    type:
      - 'null'
      - boolean
    doc: Retain header (in the first line)
    inputBinding:
      position: 103
      prefix: -H
  - id: progfile
    type:
      - 'null'
      - File
    doc: Program file
    inputBinding:
      position: 103
      prefix: -f
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bioawk:1.0--h7132678_7
stdout: bioawk.out
s:url: https://www.gnu.org/software/gawk/
$namespaces:
  s: https://schema.org/
