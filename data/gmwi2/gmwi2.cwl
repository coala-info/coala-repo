cwlVersion: v1.2
class: CommandLineTool
baseCommand: gmwi2
label: gmwi2
doc: "GMWI2 (Gut Microbiome Wellness Index 2) is a a robust and biologically interpretable
  predictor of health status based on the gut microbiome.\n\nTool homepage: https://github.com/danielchang2002/GMWI2"
inputs:
  - id: forward
    type: File
    doc: forward-read of metagenome (.fastq/.fastq.gz)
    inputBinding:
      position: 101
      prefix: --forward
  - id: num_threads
    type: int
    doc: number of threads
    inputBinding:
      position: 101
      prefix: --num_threads
  - id: output_prefix
    type: string
    doc: prefix to designate output file names
    inputBinding:
      position: 101
      prefix: --output_prefix
  - id: reverse
    type: File
    doc: reverse-read of metagenome (.fastq/.fastq.gz)
    inputBinding:
      position: 101
      prefix: --reverse
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gmwi2:1.6--pyhdfd78af_0
stdout: gmwi2.out
