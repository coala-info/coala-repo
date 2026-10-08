cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gimme
  - background
label: gimmemotifs-minimal_background
doc: "Create a background file\n\nTool homepage: https://github.com/vanheeringen-lab/gimmemotifs"
inputs:
  - id: input_file
    type:
      - 'null'
      - File
    doc: "input sequences (BED or FASTA)"
    inputBinding:
      position: 1
      prefix: -i
  - id: format
    type:
      - 'null'
      - string
    doc: "output format (BED or FASTA)"
    inputBinding:
      position: 1
      prefix: -f
  - id: size
    type:
      - 'null'
      - int
    doc: "size of random sequences"
    inputBinding:
      position: 1
      prefix: -s
  - id: number
    type:
      - 'null'
      - int
    doc: "number of sequence to generate"
    inputBinding:
      position: 1
      prefix: -n
  - id: genome
    type:
      - 'null'
      - File
    doc: "Genome fasta file (not for type 'random')"
    inputBinding:
      position: 1
      prefix: -g
  - id: markov_order
    type:
      - 'null'
      - int
    doc: "order of the Markov model (only for type 'random', default 1)"
    inputBinding:
      position: 1
      prefix: -m
  - id: output_file
    type: string
    doc: "outputfile"
    inputBinding:
      position: 100
  - id: type
    type: string
    doc: "type of background sequences to generate (random,genomic,gc,promoter)"
    inputBinding:
      position: 101
outputs:
  - id: output
    type: File
    doc: "Background sequences"
    outputBinding:
      glob: $(inputs.output_file)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.genome)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gimmemotifs-minimal:0.18.1--py39hbcbf7aa_0
