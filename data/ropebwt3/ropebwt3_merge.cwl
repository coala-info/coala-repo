cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ropebwt3
  - merge
label: ropebwt3_merge
doc: "Merge multiple FMR files into a single FMR file.\n\nTool homepage: https://github.com/lh3/ropebwt3"
inputs:
  - id: base_fmr
    type: File
    doc: The base FMR file.
    inputBinding:
      position: 1
  - id: other_fmr_files
    type:
      type: array
      items: File
    doc: Additional FMR files to merge.
    inputBinding:
      position: 2
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use.
    inputBinding:
      position: 103
      prefix: -t
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output FMR file.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ropebwt3:3.10--h577a1d6_0
