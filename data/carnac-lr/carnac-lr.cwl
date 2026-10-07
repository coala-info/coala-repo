cwlVersion: v1.2
class: CommandLineTool
baseCommand: CARNAC-LR
label: carnac-lr
doc: "CARNAC-LR is a tool for clustering long reads (PacBio or Oxford Nanopore) for
  de novo assembly of transcriptomes.\n\nTool homepage: https://github.com/kamimrcht/CARNAC-LR"
inputs:
  - id: input_file
    type: File
    doc: Input read connection file in CARNAC-LR format (from paf_to_CARNAC.py)
      or Short Read Connector Linker output.
    inputBinding:
      position: 101
      prefix: -f
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use (default 2).
    inputBinding:
      position: 101
      prefix: -t
  - id: output_file_path
    type: string
    doc: Output file name for the clusters (default final_g_clusters.txt)
    inputBinding:
      position: 102
      prefix: -o
outputs:
  - id: output_file
    type: File
    doc: Output file name for the clusters.
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/carnac-lr:1.0.0--h503566f_5
