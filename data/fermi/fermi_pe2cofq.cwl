cwlVersion: v1.2
class: CommandLineTool
baseCommand: fermi_pe2cofq
label: fermi_pe2cofq
doc: "Convert paired-end FASTQ to COFF format\n\nTool homepage: https://github.com/quantumlib/OpenFermion"
inputs:
  - id: in1_fq
    type: File
    doc: First FASTQ file
    inputBinding:
      position: 1
  - id: in2_fq
    type: File
    doc: Second FASTQ file
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fermi:1.1_r751_beta--h577a1d6_9
stdout: fermi_pe2cofq.out
