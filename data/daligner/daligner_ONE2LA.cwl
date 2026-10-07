cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ONE2LA
label: daligner_ONE2LA
doc: "Convert a ONE-code .dal alignment file (with trace information, from
  LA2ONE -c -t) back to a .las file written to standard output.\n\nTool
  homepage: https://github.com/thegenemyers/DALIGNER"
inputs:
  - id: align
    type: File
    doc: The ONE-code alignment file (.dal)
    inputBinding:
      position: 1
  - id: output_name
    type:
      - 'null'
      - string
    doc: Name of the .las output file
    default: alignments.las
outputs:
  - id: las_file
    type: stdout
    doc: Alignment file (.las)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/daligner:2.0.20240118--h7b50bb2_0
stdout: $(inputs.output_name)
