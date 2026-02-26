cwlVersion: v1.2
class: CommandLineTool
baseCommand: deBWT
label: debwt_deBWT
doc: "Please make sure your sequence don't contain any uncertain characters like 'N'\n\
  \nTool homepage: https://github.com/DixianZhu/deBWT"
inputs:
  - id: reference
    type: File
    doc: sequence in fasta or fastq format
    inputBinding:
      position: 1
  - id: jellyfish_directory
    type:
      - 'null'
      - Directory
    doc: jellyfish directory
    inputBinding:
      position: 102
      prefix: -j
  - id: kmer_length
    type:
      - 'null'
      - int
    doc: k-mer length (from 12 to 32)
    default: 32
    inputBinding:
      position: 102
      prefix: -k
  - id: output_bwt_file
    type:
      - 'null'
      - boolean
    doc: output bwt file(binary)
    inputBinding:
      position: 102
      prefix: -o
  - id: threads
    type:
      - 'null'
      - int
    doc: maximum thread number
    default: 8
    inputBinding:
      position: 102
      prefix: -t
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/debwt:1.0.1--h577a1d6_8
stdout: debwt_deBWT.out
