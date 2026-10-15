cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phyluce_genetrees_get_mean_bootrep_support
label: phyluce_phyluce_genetrees_get_mean_bootrep_support
doc: "Root some genetrees\n\nTool homepage: https://github.com/faircloth-lab/phyluce"
inputs:
  - id: trees
    type: Directory
    doc: "Tree file"
    inputBinding:
      position: 1
      prefix: --trees
  - id: config
    type: File
    doc: "config file"
    inputBinding:
      position: 2
      prefix: --config
  - id: schema
    type:
      - 'null'
      - string
    doc: "The scheme of the input data. One of nexus, newick, nexml, fasta, phylip."
    inputBinding:
      position: 3
      prefix: --schema
  - id: root
    type: string
    doc: "The taxon on which to root trees"
    inputBinding:
      position: 4
      prefix: --root
outputs:
  - id: summary
    type: File
    doc: "Per-section number of loci, mean and confidence interval of bootstrap support, printed to standard output."
    outputBinding:
      glob: "mean_bootrep_support.txt"
  - id: outfile
    type:
      - 'null'
      - File
    doc: "CSV file with the mean bootstrap support per locus and section."
    outputBinding:
      glob: "outfile.csv"
stdout: mean_bootrep_support.txt
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyluce:1.6.8--py_0
