cwlVersion: v1.2
class: CommandLineTool
baseCommand: slivar make-gnotate
label: slivar_make-gnotate
doc: "Create gnotate files from VCFs\n\nTool homepage: https://github.com/brentp/slivar"
inputs:
  - id: vcfs
    type:
      - 'null'
      - type: array
        items: File
    doc: paths to vcf files
    inputBinding:
      position: 1
  - id: field
    type:
      - 'null'
      - type: array
        items: string
    doc: field(s) to pull from VCF. format is source:dest. e.g. 
      AF_popmax:gnomad_popmax_af
    inputBinding:
      position: 102
      prefix: --field
  - id: message
    type:
      - 'null'
      - string
    doc: optional usage message (or license) to associate with the gnotate file.
    inputBinding:
      position: 102
      prefix: --message
  - id: prefix
    type:
      - 'null'
      - string
    doc: prefix for output
    default: gno
    inputBinding:
      position: 102
      prefix: --prefix
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/slivar:0.3.3--h5f107b1_0
stdout: slivar_make-gnotate.out
