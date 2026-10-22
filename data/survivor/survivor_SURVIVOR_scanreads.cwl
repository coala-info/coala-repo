cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - SURVIVOR
  - scanreads
label: survivor_scanreads
doc: "Obtain error profiles from mapped reads for simulation (reads SAM records with MD tags on standard input)\n\nTool homepage: https://github.com/fritzsedlazeck/SURVIVOR"
inputs:
  - id: min_length
    type: int
    doc: "Min read length (minimum alignment length to consider)."
    inputBinding:
      position: 1
  - id: output
    type: string
    doc: "Output error profile file."
    inputBinding:
      position: 2
  - id: sam
    type: File
    doc: "SAM text records with MD tags (the output of samtools view, no header needed), read from standard input."
outputs:
  - id: error_profile
    type: File
    doc: "Error profile (read length distribution and match/mismatch/indel rates)."
    outputBinding:
      glob: '$(inputs.output)'
  - id: stdout
    type: stdout
    doc: "Number of valid reads"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/survivor:1.0.7--h077b44d_7
stdin: $(inputs.sam.path)
stdout: survivor_scanreads.out
