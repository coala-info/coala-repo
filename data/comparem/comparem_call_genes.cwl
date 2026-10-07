cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - comparem
  - call_genes
label: comparem_call_genes
doc: "Identify genes within genomes.\n\nTool homepage: https://github.com/dparks1134/CompareM"
inputs:
  - id: input_genomes
    type: Directory
    doc: "genome files to process (a directory holding the files; only files ending in --file_ext are used)"
    inputBinding:
      position: 1
  - id: output_dir
    type: string
    doc: "output directory"
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
  - id: force_table
    type:
      - 'null'
      - int
    doc: "force use of specific translation table"
    inputBinding:
      position: 101
      prefix: --force_table
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
    doc: "output directory with called genes (.faa, .fna, .gff) and call_genes.summary.tsv"
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/comparem:0.1.2--py_0
