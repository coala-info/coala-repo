cwlVersion: v1.2
class: CommandLineTool
baseCommand: kssd composite
label: kssd_composite
doc: "The composite doc prefix.\n\nTool homepage: https://github.com/yhg926/public_kssd"
inputs:
  - id: query
    type: Directory
    doc: Path of query sketches with abundances
    inputBinding:
      position: 101
      prefix: --query
  - id: ref
    type: Directory
    doc: Path of species specific pan uniq kmer database (reference)
    inputBinding:
      position: 101
      prefix: --ref
  - id: threads
    type:
      - 'null'
      - int
    doc: Threads number to use
    inputBinding:
      position: 101
      prefix: --threads
  - id: outfile_path
    type: string
    doc: Output or path parameter `outfile_path`
    inputBinding:
      position: 102
      prefix: --outfile
outputs:
  - id: outfile
    type: Directory
    doc: Output path
    outputBinding:
      glob: $(inputs.outfile_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kssd:2.21--h577a1d6_3
