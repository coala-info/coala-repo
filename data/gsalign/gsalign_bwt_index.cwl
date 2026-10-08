cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bwt_index
label: gsalign_bwt_index
doc: "Build the BWT index of a reference sequence file for GSAlign.\n\nTool homepage:
  https://github.com/hsinnan75/GSAlign"
inputs:
  - id: reference_file
    type: File
    doc: Reference file in FASTA format (for example ref.fa)
    inputBinding:
      position: 1
  - id: index_prefix
    type: string
    doc: Prefix of the index files (for example MyRef)
    inputBinding:
      position: 2
outputs:
  - id: index_files
    type:
      type: array
      items: File
    doc: Index files written with the given prefix
    outputBinding:
      glob: $(inputs.index_prefix).*
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gsalign:1.0.22--hcb620b3_8
stdout: gsalign_bwt_index.out
