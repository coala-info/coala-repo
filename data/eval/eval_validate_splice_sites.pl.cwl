cwlVersion: v1.2
class: CommandLineTool
baseCommand: validate_splice_sites.pl
label: eval_validate_splice_sites.pl
doc: "Checks the splice sites of the genes in a GTF file against the genome sequence and reports inconsistent or invalid splice site pairs.\n\nTool homepage: http://mblab.wustl.edu/software.html"
inputs:
  - id: gtf_file
    type: File
    doc: "GTF file"
    inputBinding:
      position: 100
  - id: sequence_file
    type: File
    doc: "Sequence file (FASTA)"
    inputBinding:
      position: 101
  - id: bad_genes_list
    type: File
    doc: "Bad genes list, one gene id per line"
    inputBinding:
      position: 102
outputs:
  - id: stdout
    type: stdout
    doc: Splice site report and list of bad genes
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/eval:2.2.8--pl526_0
stdout: eval_validate_splice_sites.pl.out
