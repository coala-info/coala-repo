cwlVersion: v1.2
class: CommandLineTool
baseCommand: seqlib
label: seqlib
doc: "A C++ interface to HTSlib, BWA-MEM and Fermite-lite for sequence analysis.\n
  \nTool homepage: https://github.com/walaj/SeqLib"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqlib:1.2.0--hbefcdb2_0
stdout: seqlib.out
