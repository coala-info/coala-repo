cwlVersion: v1.2
class: CommandLineTool
baseCommand: kssd_reverse
label: kssd_reverse
doc: "The reverse doc prefix.\n\nTool homepage: https://github.com/yhg926/public_kssd"
inputs:
  - id: co_dir
    type: Directory
    doc: co dir
    inputBinding:
      position: 1
  - id: byreads
    type:
      - 'null'
      - boolean
    doc: recover k-mer from sketched reads .
    inputBinding:
      position: 102
      prefix: --byreads
  - id: shuf_file
    type:
      - 'null'
      - File
    doc: provide .shuf file.
    inputBinding:
      position: 102
      prefix: --shufFile
  - id: threads
    type:
      - 'null'
      - int
    doc: threads num.
    inputBinding:
      position: 102
      prefix: --threads
  - id: outdir_path
    type: string
    doc: Output or path parameter `outdir_path`
    inputBinding:
      position: 103
      prefix: --outdir
outputs:
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: path for recovered k-mer files.
    outputBinding:
      glob: $(inputs.outdir_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kssd:2.21--h577a1d6_3
