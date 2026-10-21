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
  - id: output_file_path
    type:
      - 'null'
      - string
    doc: output FMR to FILE [stdout]
    inputBinding:
      position: 104
      prefix: -o
  - id: save_index_file
    type:
      - 'null'
      - string
    doc: save the current index to FILE after each input file
    inputBinding:
      position: 105
      prefix: -S
outputs:
  - id: stdout
    type: stdout
    doc: Standard output (the merged FMR when -o is not given)
  - id: save_index_file_out
    type:
      - 'null'
      - File
    doc: index saved after each input file
    outputBinding:
      glob: $(inputs.save_index_file)
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output FMR file.
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ropebwt3:3.10--h577a1d6_0
stdout: ropebwt3_merge.out
