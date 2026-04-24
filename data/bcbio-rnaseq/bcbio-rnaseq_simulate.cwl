cwlVersion: v1.2
class: CommandLineTool
baseCommand: bcbio-rnaseq simulate
label: bcbio-rnaseq_simulate
doc: "Simulate RNA-Seq data\n\nTool homepage: https://github.com/hbc/bcbioRNASeq"
inputs:
  - id: count_file
    type:
      - 'null'
      - File
    doc: Optional count file for abudance distribution
    inputBinding:
      position: 101
      prefix: --count-file
  - id: library_size
    type:
      - 'null'
      - int
    doc: Library size in millions of reads
    inputBinding:
      position: 101
      prefix: --library-size
  - id: num_genes
    type:
      - 'null'
      - int
    doc: Number of genes to simulate.
    inputBinding:
      position: 101
      prefix: --num-genes
  - id: out_dir
    type: Directory
    doc: Output directory
    inputBinding:
      position: 101
      prefix: --out-dir
  - id: sample_size
    type:
      - 'null'
      - int
    doc: Sample size of each group
    inputBinding:
      position: 101
      prefix: --sample-size
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bcbio-rnaseq:1.2.0--r3.3.2_3
stdout: bcbio-rnaseq_simulate.out
