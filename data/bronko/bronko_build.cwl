cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bronko
  - build
label: bronko_build
doc: "Create an bronko index of existing viral references for a given species\n\n\
  Tool homepage: https://github.com/treangenlab/bronko"
inputs:
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Debug output
    inputBinding:
      position: 101
      prefix: --debug
  - id: file_input
    type:
      - 'null'
      - File
    doc: Path to .txt file containing paths to each file, one line per file, 
      each containing a single genome
    inputBinding:
      position: 101
      prefix: --file-input
  - id: genomes
    type:
      - 'null'
      - type: array
        items: File
    doc: Genome files to be built into index (fasta/gzip)
    inputBinding:
      position: 101
      prefix: --genomes
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: Kmer size
    inputBinding:
      position: 101
      prefix: --kmer-size
  - id: output
    type:
      - 'null'
      - string
    doc: Name of index file (.bkdb will be added)
    inputBinding:
      position: 101
      prefix: --output
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: 'Verbose output (warning: very verbose)'
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bronko:0.1.3--h4349ce8_0
stdout: bronko_build.out
