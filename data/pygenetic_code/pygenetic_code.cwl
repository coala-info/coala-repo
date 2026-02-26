cwlVersion: v1.2
class: CommandLineTool
baseCommand: pygenetic_code
label: pygenetic_code
doc: "genetic_codes for translation tables\n\nTool homepage: https://github.com/linsalrob/genetic_codes"
inputs:
  - id: difference
    type:
      - 'null'
      - boolean
    doc: print the genetic code as the difference from translation table 1
    inputBinding:
      position: 101
      prefix: --difference
  - id: json
    type:
      - 'null'
      - boolean
    doc: print the genetic codes as a json object
    inputBinding:
      position: 101
      prefix: --json
  - id: maxdifference
    type:
      - 'null'
      - boolean
    doc: print difference from the most common codon usage
    inputBinding:
      position: 101
      prefix: --maxdifference
  - id: minlen
    type:
      - 'null'
      - int
    doc: minimum ORF length for the six frame translation (default=3)
    default: 3
    inputBinding:
      position: 101
      prefix: --minlen
  - id: sixframe
    type:
      - 'null'
      - string
    doc: translate a sequence in all six reading frames
    inputBinding:
      position: 101
      prefix: --sixframe
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads to use for the six frame translation (default=8)
    default: 8
    inputBinding:
      position: 101
      prefix: --threads
  - id: translate
    type:
      - 'null'
      - string
    doc: translate a sequence in one reading frame
    inputBinding:
      position: 101
      prefix: --translate
  - id: translation_table
    type:
      - 'null'
      - string
    doc: translation table to use (default == 11)
    default: 11
    inputBinding:
      position: 101
      prefix: --translationtable
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: debugging level output
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pygenetic_code:0.20.0--py312he4a0461_0
stdout: pygenetic_code.out
