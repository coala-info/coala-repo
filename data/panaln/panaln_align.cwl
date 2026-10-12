cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - panaln
  - align
label: panaln_align
doc: "Align fastq sequences using panaln\n\nTool homepage: https://github.com/Lilu-guo/Panaln"
inputs:
  - id: index_files
    type:
      type: array
      items: File
    doc: Index files made by panaln index (<basename>.1.idx to <basename>.9.idx). Staged in the working directory.
  - id: index_basename
    type: string
    doc: Index basename (the file names of index_files without the .N.idx suffix)
    inputBinding:
      position: 101
      prefix: -x
  - id: input_fastq
    type: File
    doc: Input FASTQ file
    inputBinding:
      position: 101
      prefix: -f
  - id: output_sam_path
    type: string
    doc: Output SAM file name
    inputBinding:
      position: 102
      prefix: -s
outputs:
  - id: output_sam
    type: File
    doc: Output SAM file
    outputBinding:
      glob: $(inputs.output_sam_path)
requirements:
  - class: InitialWorkDirRequirement
    listing: $(inputs.index_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/panaln:2.09--h5ca1c30_0
