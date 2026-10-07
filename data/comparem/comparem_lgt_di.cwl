cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - comparem
  - lgt_di
label: comparem_lgt_di
doc: "Calculate dinuceotide (3rd,1st) usage of genes to identify putative LGT events.\n\nTool homepage: https://github.com/dparks1134/CompareM"
inputs:
  - id: nucleotide_gene_files
    type: Directory
    doc: "input files with genes in nucleotide space (a directory holding the files; only files ending in --file_ext are used)"
    inputBinding:
      position: 1
  - id: output_dir
    type: string
    doc: "output directory to write dinucleotide usage for each gene in each genome"
    inputBinding:
      position: 2
  - id: file_ext
    type:
      - 'null'
      - string
    doc: "extension of files to process (default: fna)"
    inputBinding:
      position: 101
      prefix: --file_ext
  - id: crit_value
    type:
      - 'null'
      - double
    doc: "critical value for defining deviant genes (default: 0.001)"
    inputBinding:
      position: 101
      prefix: --crit_value
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
  - id: output_directory
    type: Directory
    doc: "output directory with dinucleotide usage for each gene in each genome"
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/comparem:0.1.2--py_0
