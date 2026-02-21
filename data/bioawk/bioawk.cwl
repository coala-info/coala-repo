cwlVersion: v1.2
class: CommandLineTool
baseCommand: bioawk
label: bioawk
doc: "An extension of standard awk with added support for several common biological
  data formats (BED, SAM, VCF, GFF, FASTX) and built-in variables.\n\nTool homepage:
  https://www.gnu.org/software/gawk/"
inputs:
  - id: program
    type:
      - 'null'
      - string
    doc: The bioawk program script (if -f is not specified)
    inputBinding:
      position: 1
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Input files to process
    inputBinding:
      position: 2
  - id: assign_variable
    type:
      - 'null'
      - type: array
        items: string
    doc: Assign a value to a variable (var=val)
    inputBinding:
      position: 103
      prefix: -v
  - id: format
    type:
      - 'null'
      - string
    doc: Specify the input format (e.g., bed, sam, vcf, gff, fastx)
    inputBinding:
      position: 103
      prefix: -c
  - id: header
    type:
      - 'null'
      - boolean
    doc: Retain and parse the header line (for formats like SAM or VCF)
    inputBinding:
      position: 103
      prefix: -H
  - id: program_file
    type:
      - 'null'
      - File
    doc: Read the bioawk program source from a file
    inputBinding:
      position: 103
      prefix: -f
  - id: tabs
    type:
      - 'null'
      - boolean
    doc: Use tabs as the input and output field separator
    inputBinding:
      position: 103
      prefix: -t
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bioawk:1.0--h7132678_7
stdout: bioawk.out
