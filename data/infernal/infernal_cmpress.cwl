cwlVersion: v1.2
class: CommandLineTool
baseCommand: cmpress
label: infernal_cmpress
doc: prepare an CM database for faster cmscan searches
inputs:
  - id: cmfile
    type: File
    doc: CM database file to press
    inputBinding:
      position: 200
  - id: force
    type:
      - 'null'
      - boolean
    doc: 'force: overwrite any previous pressed files'
    inputBinding:
      position: 102
      prefix: -F
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: pressed_files
    type: File[]
    doc: Pressed binary CM database files (.i1m, .i1i, .i1f, .i1p)
    outputBinding:
      glob: $(inputs.cmfile.basename).i1*
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.cmfile)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/infernal:1.1.5--pl5321h7b50bb2_4
stdout: cmpress.out
s:url: http://eddylab.org/infernal
$namespaces:
  s: https://schema.org/
