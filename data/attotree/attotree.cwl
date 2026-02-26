cwlVersion: v1.2
class: CommandLineTool
baseCommand: attotree
label: attotree
doc: "rapid estimation of phylogenetic trees using sketching\n\nTool homepage: https://github.com/karel-brinda/attotree"
inputs:
  - id: genome
    type:
      type: array
      items: File
    doc: input genome file(s) (fasta / gzipped fasta / list of files when "-L")
    inputBinding:
      position: 1
  - id: debugging
    type:
      - 'null'
      - boolean
    doc: debugging (don't remove tmp dir)
    inputBinding:
      position: 102
      prefix: -D
  - id: input_files_are_lists
    type:
      - 'null'
      - boolean
    doc: input files are list(s) of files
    inputBinding:
      position: 102
      prefix: -L
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: kmer size
    default: 21
    inputBinding:
      position: 102
      prefix: -k
  - id: sketch_size
    type:
      - 'null'
      - int
    doc: sketch size
    default: 10000
    inputBinding:
      position: 102
      prefix: -s
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    default: '[#cores, 20]'
    inputBinding:
      position: 102
      prefix: -t
  - id: tmp_dir
    type:
      - 'null'
      - Directory
    doc: tmp dir
    default: '[default system, /tmp...]'
    inputBinding:
      position: 102
      prefix: -d
  - id: tree_construction_method
    type:
      - 'null'
      - string
    doc: tree construction method (nj/upgma)
    default: nj
    inputBinding:
      position: 102
      prefix: -m
  - id: verbose_output
    type:
      - 'null'
      - boolean
    doc: verbose output
    inputBinding:
      position: 102
      prefix: -V
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: newick output
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/attotree:0.1.6--pyhdfd78af_0
