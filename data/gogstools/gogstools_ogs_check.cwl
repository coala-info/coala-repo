cwlVersion: v1.2
class: CommandLineTool
baseCommand: ogs_check
label: gogstools_ogs_check
doc: "Check that an OGS GFF file is ready for release.\n\nTool homepage: https://github.com/genouest/ogs-tools"
inputs:
  - id: infile
    type: File
    doc: GFF3 file to check
    inputBinding:
      position: 1
  - id: outfile
    type: string
    doc: Name of the checked GFF3 file to write
    inputBinding:
      position: 2
  - id: source
    type:
      - 'null'
      - string
    doc: Change the source to given value for all features
    inputBinding:
      position: 101
      prefix: --source
  - id: no_size
    type:
      - 'null'
      - boolean
    doc: Disable CDS and intron size checking
    inputBinding:
      position: 101
      prefix: --no-size
outputs:
  - id: checked_gff
    type: File
    doc: The checked GFF3 file
    outputBinding:
      glob: $(inputs.outfile)
  - id: log
    type: stderr
    doc: Check messages written on standard error
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gogstools:0.1.2--py310hdfd78af_0
stderr: gogstools_ogs_check.log
