cwlVersion: v1.2
class: CommandLineTool
baseCommand: filter_badlist.pl
label: eval_filter_badlist.pl
doc: "Removes the genes named in a gene list from a GTF file (or keeps only those genes with -l) and writes the GTF to standard output.\n\nTool homepage: http://mblab.wustl.edu/software.html"
inputs:
  - id: fix_file
    type:
      - 'null'
      - boolean
    doc: "Flag to fix the file"
    inputBinding:
      position: 1
      prefix: -f
  - id: output_listed_genes
    type:
      - 'null'
      - boolean
    doc: "Output those genes that are in the list"
    inputBinding:
      position: 2
      prefix: -l
  - id: gtf_file
    type: File
    doc: "GTF file to filter"
    inputBinding:
      position: 100
  - id: gene_list
    type: File
    doc: "List of gene ids, one per line"
    inputBinding:
      position: 101
outputs:
  - id: stdout
    type: stdout
    doc: Filtered GTF
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/eval:2.2.8--pl526_0
stdout: eval_filter_badlist.pl.gtf
