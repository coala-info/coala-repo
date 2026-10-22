cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - scarap
  - sample
label: scarap_sample
doc: "Sample a subset of representative genomes.\n\nTool homepage: https://github.com/SWittouck/SCARAP"
inputs:
  - id: fasta_files
    type: Directory
    doc: "Folder with one fasta file with amino acid sequences (faa file) or one fasta file with nucleic acid sequences (ffn file) per genome"
    inputBinding:
      position: 1
  - id: pangenome
    type: File
    doc: "Input file with pangenome"
    inputBinding:
      position: 2
  - id: outfolder_path
    type: string
    doc: "Output folder"
    inputBinding:
      position: 3
  - id: max_genomes
    type:
      - 'null'
      - int
    doc: "Maximum number of genomes to sample (0 = no maximum, default 0)"
    inputBinding:
      position: 101
      prefix: --max-genomes
  - id: identity
    type:
      - 'null'
      - float
    doc: "Maximum sequence identity between sampled genomes (default 1)"
    inputBinding:
      position: 102
      prefix: --identity
  - id: method
    type:
      - 'null'
      - string
    doc: "Genome-genome comparison method (default: mean)"
    inputBinding:
      position: 103
      prefix: --method
  - id: exact
    type:
      - 'null'
      - boolean
    doc: "Perform full alignments"
    inputBinding:
      position: 104
      prefix: --exact
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads to use"
    inputBinding:
      position: 101
      prefix: --threads
  - id: cont
    type:
      - 'null'
      - boolean
    doc: "Continue in existing output folder"
    inputBinding:
      position: 102
      prefix: --cont
outputs:
  - id: outfolder
    type: Directory
    doc: "Output folder with the sampled genomes"
    outputBinding:
      glob: "$(inputs.outfolder_path)"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scarap:1.0.2--pyhdfd78af_0
