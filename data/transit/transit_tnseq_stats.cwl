cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - transit
  - tnseq_stats
label: transit_tnseq_stats
doc: "Summary statistics (density, mean counts, skew, saturation) of TnSeq datasets, from wig files or a combined wig file.\n\nTool homepage: http://github.com/mad-lab/transit"
inputs:
  - id: input_wig_files
    type: File[]?
    doc: "One or more input .wig files (use this or combined_wig)"
    inputBinding:
      position: 1
  - id: combined_wig
    type: ['null', File]
    doc: "A combined .wig file (use this or input_wig_files)"
    inputBinding:
      position: 2
      prefix: -c
  - id: output_filename
    type: ['null', string]
    doc: "Output file name; the statistics are always also printed to standard output"
    inputBinding:
      position: 3
      prefix: -o
outputs:
  - id: output_file
    type: File?
    doc: "Output file"
    outputBinding:
      glob: $(inputs.output_filename)
  - id: stdout
    type: stdout
    doc: "Standard output"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/transit:3.3.20--pyhdfd78af_0
stdout: transit_tnseq_stats.out
