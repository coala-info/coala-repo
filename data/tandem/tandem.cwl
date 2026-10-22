cwlVersion: v1.2
class: CommandLineTool
baseCommand: tandem
label: tandem
doc: "TANDEM Alanine (2017.2.1.4)\n\nTool homepage: https://github.com/tum-vision/tandem"
inputs:
  - id: filename
    type: File
    doc: any valid path to an XML input file
    inputBinding:
      position: 1
  - id: support_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Files named in the XML input file (default parameters, taxonomy, FASTA, spectra), staged next to it
outputs:
  - id: result_xml
    type:
      type: array
      items: File
    doc: X! Tandem result XML written by the run
    outputBinding:
      glob: '*.t.xml'
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.filename)
      - $(inputs.support_files)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/tandem:v17-02-01-4_cv4
stdout: tandem.out
