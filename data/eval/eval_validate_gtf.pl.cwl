cwlVersion: v1.2
class: CommandLineTool
baseCommand: validate_gtf.pl
label: eval_validate_gtf.pl
doc: "Validates a GTF file against a chromosome sequence to identify genes with in-frame
  stops, reading frame changes, and other incorrectible problems, generating a 'badlist'
  of genes to be removed.\n\nTool homepage: http://mblab.wustl.edu/software.html"
inputs:
  - id: chromosome_sequence
    type: File
    doc: The chromosome sequence file in FASTA format (e.g., chrN.fa)
    inputBinding:
      position: 1
  - id: gtf_file
    type: File
    doc: The GTF file to be validated (e.g., chrN.gtf)
    inputBinding:
      position: 102
      prefix: -m
outputs:
  - id: badlist_output
    type:
      - 'null'
      - File
    doc: Output file containing the list of genes with errors (badlist.txt)
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/eval:2.2.8--pl526_0
