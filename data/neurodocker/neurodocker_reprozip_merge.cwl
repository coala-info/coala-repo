cwlVersion: v1.2
class: CommandLineTool
baseCommand: [neurodocker, reprozip, merge]
label: neurodocker_reprozip_merge
doc: "Merge ReproZip pack files.\n\nTool homepage: https://github.com/kaczmarj/neurodocker"
inputs:
  - id: outfile
    type: string
    doc: File path of the merged pack file.
    inputBinding:
      position: 3
  - id: pack_files
    type:
      type: array
      items: File
    doc: Pack files to merge.
    inputBinding:
      position: 4
  - id: verbosity
    type:
      - 'null'
      - type: enum
        symbols: [debug, info, warning, error, critical]
        name: neurodocker_merge_verbosity
    doc: Logging verbosity.
    inputBinding:
      position: 2
      prefix: --verbosity
outputs:
  - id: merged_pack
    type: File
    doc: The merged pack file.
    outputBinding:
      glob: $(inputs.outfile)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/neurodocker:0.5.0--py_0
