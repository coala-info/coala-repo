cwlVersion: v1.2
class: CommandLineTool
baseCommand: lorax_pct
label: lorax_pct
doc: "Calculate and output statistics about the alignment of a sample to a reference
  genome or pan-genome graph.\n\nTool homepage: https://github.com/tobiasrausch/lorax"
inputs:
  - id: sample_bam
    type: File
    doc: sample BAM file (when using linear reference)
    inputBinding:
      position: 1
  - id: sample_gaf_gz
    type: File
    doc: sample GAF.GZ file (when using pan-genome graph)
    inputBinding:
      position: 2
  - id: reference
    type: File
    doc: genome fasta file
    inputBinding:
      position: 103
      prefix: --reference
  - id: outfile_path
    type: string
    doc: Output or path parameter `outfile_path`
    inputBinding:
      position: 104
      prefix: --outfile
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: output statistics
    outputBinding:
      glob: $(inputs.outfile_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lorax:0.5.1--h4d20210_0
