cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - reports.py
  - alignment_summary
label: viral-ngs_reports_alignment_summary
doc: "Write or print pairwise alignment summary information for sequences in two FASTA files, including SNPs, ambiguous bases, and indels.\n\nTool homepage: https://github.com/broadinstitute/viral-ngs"
inputs:
  - id: in_fasta_file_one
    type: File
    doc: "First fasta file for an alignment"
    inputBinding:
      position: 1
  - id: in_fasta_file_two
    type: File
    doc: "Second fasta file for an alignment"
    inputBinding:
      position: 2
  - id: outfile_name
    type:
      - 'null'
      - string
    doc: "Output file for counts in TSV format"
    inputBinding:
      position: 20
      prefix: --outfileName
  - id: print_counts
    type:
      - 'null'
      - boolean
    doc: "Print counts"
    inputBinding:
      position: 20
      prefix: --printCounts
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: outfile
    type:
      - 'null'
      - File
    doc: "Counts in TSV format"
    outputBinding:
      glob: $(inputs.outfile_name)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
stdout: viral-ngs_reports_alignment_summary.out
