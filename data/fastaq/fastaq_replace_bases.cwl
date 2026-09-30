cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fastaq
  - replace_bases
label: fastaq_replace_bases
doc: "Replaces all occurrences of one letter with another\n\nTool homepage: https://github.com/sanger-pathogens/Fastaq"
inputs:
  - id: infile
    type: File
    doc: Name of input file
    inputBinding:
      position: 1
  - id: outfile
    type: string
    doc: Name of output file
    inputBinding:
      position: 2
  - id: old
    type: string
    doc: Base to be replaced
    inputBinding:
      position: 3
  - id: new
    type: string
    doc: Replace with this letter
    inputBinding:
      position: 4
outputs:
  - id: out_outfile
    type: File
    doc: Name of output file
    outputBinding:
      glob: '$(inputs.outfile)'
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/fastaq:v3.17.0-2-deb_cv1
