cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - python3
  - /usr/local/bin/transit
  - tnseq_stats
label: transit_tnseq_stats
doc: "Calculate statistics for TnSeq data.\n\nTool homepage: http://github.com/mad-lab/transit"
inputs:
  - id: input_wig_files
    type:
      type: array
      items: File
    doc: One or more input .wig files.
    inputBinding:
      position: 1
  - id: combined_wig
    type:
      - 'null'
      - File
    doc: A combined .wig file.
    inputBinding:
      position: 102
      prefix: -c
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file name.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/transit:3.3.20--pyhdfd78af_0
