cwlVersion: v1.2
class: CommandLineTool
baseCommand: embossversion
label: emboss-explorer_embossversion
doc: "Report the current EMBOSS version number\n\nTool homepage: http://emboss.open-bio.org/"
inputs:
  - id: full
    type:
      - 'null'
      - boolean
    doc: Show all EMBOSS version information fields
    inputBinding:
      position: 101
      prefix: -full
  - id: outfile_path
    type: string
    doc: '[stdout] EMBOSS version output file'
    inputBinding:
      position: 102
      prefix: -outfile
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: EMBOSS version output file
    outputBinding:
      glob: $(inputs.outfile_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/emboss-explorer:v2.2.0-10-deb_cv1
