cwlVersion: v1.2
class: CommandLineTool
baseCommand: polyat
label: polyat
doc: "Quantify poly-A/T stretches (>=10/15/20 nt) across FASTQ reads and summarize
  counts per sample.\n\nTool homepage: https://github.com/DaanJansen94/polyat"
inputs:
  - id: input_dir
    type: Directory
    doc: Directory containing .fastq/.fastq.gz/.fq/.fq.gz files.
    inputBinding:
      position: 101
      prefix: --input
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of worker threads
    inputBinding:
      position: 101
      prefix: --threads
  - id: output_dir_path
    type: Directory
    doc: Output or path parameter `output_dir_path`
    inputBinding:
      position: 102
      prefix: --output-dir
outputs:
  - id: output_dir
    type: Directory
    doc: Directory where the summary table will be written.
    outputBinding:
      glob: $(inputs.output_dir_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/polyat:0.1.2--pyhdfd78af_0
