cwlVersion: v1.2
class: CommandLineTool
baseCommand: interop_dumptext
label: illumina-interop_dumptext
doc: "Dump Illumina InterOp run metrics into a text format for analysis.\n\nTool homepage:
  http://illumina.github.io/interop/index.html"
inputs:
  - id: run_folder
    type: Directory
    doc: Path to the Illumina run folder containing InterOp files.
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/illumina-interop:1.9.0--h503566f_0
stdout: illumina-interop_dumptext.out
