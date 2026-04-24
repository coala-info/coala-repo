cwlVersion: v1.2
class: CommandLineTool
baseCommand: snaptools index-genome
label: snaptools_index-genome
doc: "Builds genome index for snaptools.\n\nTool homepage: https://github.com/r3fang/SnapTools.git"
inputs:
  - id: aligner
    type:
      - 'null'
      - string
    doc: aligner to use. Currently, snaptools supports bwa, bowtie, bowtie2 and 
      minimap2.
    inputBinding:
      position: 101
      prefix: --aligner
  - id: input_fasta
    type: File
    doc: genome fasta file to build the index from
    inputBinding:
      position: 101
      prefix: --input-fasta
  - id: num_threads
    type:
      - 'null'
      - int
    doc: =number of indexing threads
    inputBinding:
      position: 101
      prefix: --num-threads
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: prefix of indexed file
    inputBinding:
      position: 101
      prefix: --output-prefix
  - id: path_to_aligner
    type:
      - 'null'
      - Directory
    doc: path to fold that contains bwa
    inputBinding:
      position: 101
      prefix: --path-to-aligner
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snaptools:1.4.8--py_0
stdout: snaptools_index-genome.out
