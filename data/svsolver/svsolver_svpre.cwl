cwlVersion: v1.2
class: CommandLineTool
baseCommand: svpre
label: svsolver_svpre
doc: "SimVascular pre-processor: reads a .svpre parameter file and writes the flow solver input files (geombc, restart, numstart).\n\nTool homepage: https://simtk.org/projects/simvascular/"
inputs:
  - id: params_file
    type: File
    doc: Pre-processor parameter file (.svpre)
    inputBinding:
      position: 1
  - id: support_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Files named inside the parameter file (mesh, face and boundary-condition files), staged next to it
outputs:
  - id: solver_files
    type:
      type: array
      items: File
    doc: Flow solver input files written by svpre
    outputBinding:
      glob:
        - geombc.dat*
        - restart.*
        - numstart.dat
        - bct.dat
        - bct.vtp
        - varwallprop.dat
        - '*.vtp'
  - id: stdout
    type: stdout
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: $(inputs.support_files || [])
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svsolver:2022.07.20--mpich_h7252990_0
stdout: svsolver_svpre.out
