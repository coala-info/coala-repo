cwlVersion: v1.2
class: CommandLineTool
baseCommand: hivtrace_strip_drams
label: hivtrace_hivtrace_strip_drams
doc: "Replace DRAMS (drug resistance associated mutations) with gaps in ALIGNED pol
  sequences\n\nTool homepage: https://github.com/veg/hivtrace"
inputs:
  - id: input
    type: File
    doc: The input FASTA file
    inputBinding:
      position: 1
      prefix: --input
  - id: output_path
    type:
      - 'null'
      - string
    doc: Output
    inputBinding:
      position: 1
      prefix: --output
  - id: dram
    type: string
    doc: Use this list of DRAMs (lewis or wheeler)
    inputBinding:
      position: 1
      prefix: --dram
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: FASTA with the DRAM sites replaced by gaps
    outputBinding:
      glob: $(inputs.output_path)
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hivtrace:1.5.0--py_0
stdout: hivtrace_hivtrace_strip_drams.out
