cwlVersion: v1.2
class: CommandLineTool
baseCommand: python3 Aquila_step2
label: aquila_Aquila_step2
doc: "Aquila_step2\n\nTool homepage: https://github.com/maiziex/Aquila"
inputs:
  - id: block_len_use
    type:
      - 'null'
      - int
    doc: phase block len threshold
    default: 100000
    inputBinding:
      position: 101
      prefix: --block_len_use
  - id: chr_end
    type:
      - 'null'
      - int
    doc: chromosome end by
    default: 23
    inputBinding:
      position: 101
      prefix: --chr_end
  - id: chr_start
    type:
      - 'null'
      - int
    doc: chromosome start from
    default: 1
    inputBinding:
      position: 101
      prefix: --chr_start
  - id: num_threads
    type:
      - 'null'
      - int
    doc: number of threads, this correponds to number of small files get 
      assembled simulateoulsy
    default: 30
    inputBinding:
      position: 101
      prefix: --num_threads
  - id: num_threads_spades
    type:
      - 'null'
      - int
    doc: number of threads for spades
    default: 5
    inputBinding:
      position: 101
      prefix: --num_threads_spades
  - id: out_dir
    type: Directory
    doc: Directory to store assembly results
    inputBinding:
      position: 101
      prefix: --out_dir
  - id: reference
    type: File
    doc: reference fasta file, run ./install to download "source/ref.fa" for 
      GRCh38
    inputBinding:
      position: 101
      prefix: --reference
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/aquila:1.0.0--py_0
stdout: aquila_Aquila_step2.out
