cwlVersion: v1.2
class: CommandLineTool
baseCommand: phirbo
label: phirbo
doc: "Phirbo (v1.0) predicts hosts from phage (meta)genomic data\n\nTool homepage:
  https://github.com/aziele/phirbo"
inputs:
  - id: virus_dir
    type: Directory
    doc: Input directory w/ ranked lists for viruses
    inputBinding:
      position: 1
  - id: host_dir
    type: Directory
    doc: Input directory w/ ranked lists for hosts
    inputBinding:
      position: 2
  - id: k
    type:
      - 'null'
      - int
    doc: Truncate all ranked lists to the first `k` rankings to calculate RBO. 
      To disable the truncation use --k 0
    default: 30
    inputBinding:
      position: 103
      prefix: --k
  - id: num_threads
    type:
      - 'null'
      - int
    doc: Number of threads (CPUs)
    default: 20
    inputBinding:
      position: 103
      prefix: --t
  - id: p
    type:
      - 'null'
      - float
    doc: RBO parameter in range (0, 1) determines the degree of top-weightedness
      of RBO measure. High p implies strong emphasis on top ranked items
    default: 0.75
    inputBinding:
      position: 103
      prefix: --p
outputs:
  - id: output_file
    type: File
    doc: Output file name
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phirbo:1.0--hdfd78af_1
