cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - genometreetk
  - rna_tree
label: genometreetk_rna_tree
doc: "Infer a concatenated 16S + 23S tree spanning GTDB genomes.\n\nTool homepage:
  http://pypi.python.org/pypi/genometreetk/"
inputs:
  - id: ssu_msa
    type: File
    doc: FASTA file with MSA of 16S rRNA gene sequences
    inputBinding:
      position: 1
  - id: ssu_tree
    type: File
    doc: decorated 16S tree
    inputBinding:
      position: 2
  - id: lsu_msa
    type: File
    doc: FASTA file with MSA of 23S rRNA gene sequences
    inputBinding:
      position: 3
  - id: lsu_tree
    type: File
    doc: decorated 23S tree
    inputBinding:
      position: 4
  - id: output_dir
    type: Directory
    doc: output directory
    inputBinding:
      position: 5
  - id: cpus
    type:
      - 'null'
      - int
    doc: number of cpus
    inputBinding:
      position: 106
      prefix: --cpus
  - id: silent
    type:
      - 'null'
      - boolean
    doc: suppress output
    inputBinding:
      position: 106
      prefix: --silent
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genometreetk:0.1.6--py_2
stdout: genometreetk_rna_tree.out
