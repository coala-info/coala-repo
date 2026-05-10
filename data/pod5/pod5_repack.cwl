cwlVersion: v1.2
class: CommandLineTool
baseCommand: pod5_repack
label: pod5_repack
doc: "Repack a pod5 files into a single output\n\nTool homepage: https://github.com/nanoporetech/pod5-file-format"
inputs:
  - id: inputs
    type:
      type: array
      items: File
    doc: Input pod5 file(s) to repack
    inputBinding:
      position: 1
  - id: force_overwrite
    type:
      - 'null'
      - boolean
    doc: Overwrite destination files
    inputBinding:
      position: 102
      prefix: --force-overwrite
  - id: recursive
    type:
      - 'null'
      - boolean
    doc: Search for input files recursively matching `*.pod5`
    inputBinding:
      position: 102
      prefix: --recursive
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of repacking workers
    inputBinding:
      position: 102
      prefix: --threads
  - id: output_path
    type: string
    doc: Output or path parameter `output_path`
    inputBinding:
      position: 103
      prefix: --output
outputs:
  - id: output
    type:
      - 'null'
      - Directory
    doc: Output directory for pod5 files
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pod5:0.3.33--pyhdfd78af_0
