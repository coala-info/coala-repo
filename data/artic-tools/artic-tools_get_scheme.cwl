cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - artic-tools
  - get_scheme
label: artic-tools_get_scheme
doc: "Download an ARTIC primer scheme and reference sequence\n\nTool homepage: https://github.com/will-rowe/artic-tools"
inputs:
  - id: scheme
    type: string
    doc: The name of the scheme to download (ebola|nipah|scov2)
    inputBinding:
      position: 1
  - id: scheme_version
    type:
      - 'null'
      - int
    doc: The ARTIC primer scheme version (default = latest)
    inputBinding:
      position: 102
      prefix: --schemeVersion
  - id: out_dir_path
    type: Directory
    doc: Output or path parameter `out_dir_path`
    inputBinding:
      position: 103
      prefix: --out-dir
outputs:
  - id: out_dir
    type:
      - 'null'
      - Directory
    doc: The directory to write the scheme and reference sequence to
    outputBinding:
      glob: $(inputs.out_dir_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/artic-tools:0.3.1--hf9554c4_7
