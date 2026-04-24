cwlVersion: v1.2
class: CommandLineTool
baseCommand: emboss-explorer_rebaseextract
label: emboss-explorer_rebaseextract
doc: "Process the REBASE database for use by restriction enzyme applications\n\nTool
  homepage: http://emboss.open-bio.org/"
inputs:
  - id: equivalences
    type:
      - 'null'
      - boolean
    doc: This option calculates an embossre.equ file using restriction enzyme 
      prototypes in the withrefm file.
    inputBinding:
      position: 101
      prefix: --equivalences
  - id: infile
    type: File
    doc: REBASE database withrefm file
    inputBinding:
      position: 101
      prefix: -infile
  - id: no_equivalences
    type:
      - 'null'
      - boolean
    doc: This option calculates an embossre.equ file using restriction enzyme 
      prototypes in the withrefm file.
    inputBinding:
      position: 101
      prefix: --noequivalences
  - id: protofile
    type: File
    doc: REBASE database proto file
    inputBinding:
      position: 101
      prefix: -protofile
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/emboss-explorer:v2.2.0-10-deb_cv1
stdout: emboss-explorer_rebaseextract.out
