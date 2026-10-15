cwlVersion: v1.2
class: CommandLineTool
baseCommand: phyluce_utilities_filter_bed_by_fasta
label: phyluce_phyluce_utilities_filter_bed_by_fasta
doc: "Filter a BED file of UCEs given a FASTA file of UCEs\n\nTool homepage: https://github.com/faircloth-lab/phyluce"
inputs:
  - id: bed
    type: File
    doc: "The BED file to filter."
    inputBinding:
      position: 1
      prefix: --bed
  - id: fasta
    type: File
    doc: "The FASTA file to use as a filter."
    inputBinding:
      position: 1
      prefix: --fasta
  - id: output
    type:
      - 'null'
      - string
    doc: "The output BED file (written to standard output when not set)"
    inputBinding:
      position: 1
      prefix: --output
outputs:
  - id: stdout
    type: stdout
    doc: "Standard output, including the log messages."
  - id: output_bed
    type:
      - 'null'
      - File
    doc: "The output BED file"
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyluce:1.6.8--py_0
stdout: phyluce_phyluce_utilities_filter_bed_by_fasta.out
