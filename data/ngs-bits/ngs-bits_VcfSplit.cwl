cwlVersion: v1.2
class: CommandLineTool
baseCommand: VcfSplit
label: ngs-bits_VcfSplit
doc: "Splits a VCF into several chunks\n\nTool homepage: https://github.com/imgag/ngs-bits"
inputs:
  - id: input_file
    type:
      - 'null'
      - File
    doc: "Input VCF file. If unset, reads from STDIN."
    inputBinding:
      position: 1
      prefix: -in
  - id: lines
    type: int
    doc: "Number of variant lines per chunk."
    inputBinding:
      position: 2
      prefix: -lines
  - id: output_path
    type: string
    doc: "Output VCF base name. Suffixed with chunk number and extension, e.g. '0001.vcf'"
    inputBinding:
      position: 3
      prefix: -out
  - id: settings_file
    type:
      - 'null'
      - File
    doc: "Settings override file (no other settings files are used)."
    inputBinding:
      position: 4
      prefix: --settings
outputs:
  - id: output_files
    type: File[]
    doc: "Chunked VCF files named <out base name> followed by the chunk number and extension (e.g. 0001.vcf)."
    outputBinding:
      glob: $(inputs.output_path + '*')
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
