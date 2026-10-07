cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - comparem
  - stop_usage
label: comparem_stop_usage
doc: "Calculate stop codon usage within each genome.\n\nTool homepage: https://github.com/dparks1134/CompareM"
inputs:
  - id: nucleotide_gene_files
    type: Directory
    doc: "input files with genes in nucleotide space (a directory holding the files; only files ending in --file_ext are used)"
    inputBinding:
      position: 1
  - id: output_file
    type: string
    doc: "output file indicating stop codon usage of each genome"
    inputBinding:
      position: 2
  - id: counts
    type:
      - 'null'
      - boolean
    doc: "output raw counts instead of frequencies"
    inputBinding:
      position: 101
      prefix: --counts
  - id: mean_gene_length
    type:
      - 'null'
      - boolean
    doc: "report mean gene length for genes with each stop codon"
    inputBinding:
      position: 101
      prefix: --mean_gene_length
  - id: file_ext
    type:
      - 'null'
      - string
    doc: "extension of files to process (default: fna)"
    inputBinding:
      position: 101
      prefix: --file_ext
  - id: cpus
    type:
      - 'null'
      - int
    doc: "number of CPUs to use (default: 1)"
    inputBinding:
      position: 101
      prefix: --cpus
  - id: silent
    type:
      - 'null'
      - boolean
    doc: "suppress output"
    inputBinding:
      position: 101
      prefix: --silent
outputs:
  - id: output
    type: File
    doc: "stop codon usage of each genome"
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/comparem:0.1.2--py_0
