cwlVersion: v1.2
class: CommandLineTool
baseCommand: spliced_bam2gff
label: spliced_bam2gff
doc: "A tool to convert spliced BAM alignments into GFF format, typically used in
  transcriptomic pipelines like PASA.\n\nTool homepage: https://github.com/nanoporetech/spliced_bam2gff"
inputs:
  - id: input_bam
    type: File
    doc: Input BAM file containing spliced alignments (often provided via 
      redirection or as a positional argument depending on the specific 
      implementation).
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/spliced_bam2gff:1.3--he881be0_1
stdout: spliced_bam2gff.out
