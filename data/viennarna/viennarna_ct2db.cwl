cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ct2db
label: viennarna_ct2db
doc: |-
  Produce dot-bracket notation of an RNA secondary structure from Zuker's .ct file (extended FASTA output).

  Tool homepage: https://www.tbi.univie.ac.at/RNA/
inputs:
  - id: no_pk
    type:
      - 'null'
      - boolean
    doc: Remove pseudoknots from structure
    inputBinding:
      position: 10
      prefix: --no-pk
  - id: no_modified
    type:
      - 'null'
      - boolean
    doc: Do not keep modified bases, i.e. replace all non-canonical nucleotides with N.
    inputBinding:
      position: 10
      prefix: --no-modified
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Be verbose.
    inputBinding:
      position: 10
      prefix: --verbose
  - id: fasta_header
    type:
      - 'null'
      - string
    doc: Overwrite FASTA header with user-provided string.
    inputBinding:
      position: 10
      prefix: --fasta-header=
      separate: false
  - id: filename_suffix
    type:
      - 'null'
      - string
    doc: The filename suffix to remove when turning the filename into a FASTA header.
    inputBinding:
      position: 10
      prefix: --filename-suffix=
      separate: false
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Input connectivity table (.ct) file(s)
    inputBinding:
      position: 100
outputs:
  - id: stdout
    type: stdout
    doc: Standard output of the program
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viennarna:2.7.2--py310pl5321haba5358_0
stdout: ct2db.out
s:url: https://www.tbi.univie.ac.at/RNA/
$namespaces:
  s: https://schema.org/
