cwlVersion: v1.2
class: CommandLineTool
baseCommand: ebolaseq
label: ebolaseq
doc: "Download and analyze Ebola virus sequences (v0.1.5)\n\nTool homepage: https://github.com/DaanJansen94/ebolaseq"
inputs:
  - id: alignment
    type:
      - 'null'
      - boolean
    doc: Create multiple sequence alignment and trimming (without phylogenetic 
      tree)
    inputBinding:
      position: 101
      prefix: --alignment
  - id: beast
    type:
      - 'null'
      - string
    doc: 'BEAST format: 1=No, 2=Yes'
    inputBinding:
      position: 101
      prefix: --beast
  - id: completeness
    type:
      - 'null'
      - string
    doc: Minimum completeness percentage (1-100) when using --genome 2
    inputBinding:
      position: 101
      prefix: --completeness
  - id: consensus_file
    type:
      - 'null'
      - File
    doc: Path to consensus FASTA file to include
    inputBinding:
      position: 101
      prefix: --consensus-file
  - id: genome
    type:
      - 'null'
      - string
    doc: 'Genome type: 1=Complete, 2=Partial, 3=All'
    inputBinding:
      position: 101
      prefix: --genome
  - id: host
    type:
      - 'null'
      - string
    doc: 'Host: 1=Human, 2=Non-human, 3=All'
    inputBinding:
      position: 101
      prefix: --host
  - id: metadata
    type:
      - 'null'
      - string
    doc: 'Metadata filter: 1=Location, 2=Date, 3=Both, 4=None'
    inputBinding:
      position: 101
      prefix: --metadata
  - id: output_dir
    type: Directory
    doc: Output directory for results
    inputBinding:
      position: 101
      prefix: --output-dir
  - id: phylogeny
    type:
      - 'null'
      - boolean
    doc: Create phylogenetic tree using IQTree2
    inputBinding:
      position: 101
      prefix: --phylogeny
  - id: remove
    type:
      - 'null'
      - File
    doc: Path to text file containing headers/accession IDs to remove
    inputBinding:
      position: 101
      prefix: --remove
  - id: virus
    type:
      - 'null'
      - string
    doc: 'Virus choice: 1=Zaire, 2=Sudan, 3=Bundibugyo, 4=Tai Forest, 5=Reston'
    inputBinding:
      position: 101
      prefix: --virus
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ebolaseq:0.1.6--pyhdfd78af_0
stdout: ebolaseq.out
