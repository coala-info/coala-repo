cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sequenza-utils
  - seqz_merge
label: sequenza-utils_seqz_merge
doc: "Merge multiple Sequenza .seqz files into a single file.\n\nTool homepage: http://sequenza-utils.readthedocs.org"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: List of .seqz files to merge.
    inputBinding:
      position: 1
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite output file if it exists.
    inputBinding:
      position: 102
      prefix: --force
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for merging.
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: output_file
    type: File
    doc: Path to the output merged .seqz file.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sequenza-utils:3.0.0--py311h8ddd9a4_8
