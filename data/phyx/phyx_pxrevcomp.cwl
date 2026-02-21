cwlVersion: v1.2
class: CommandLineTool
baseCommand: pxrevcomp
label: phyx_pxrevcomp
doc: "Reverse complement sequences. This will take fasta, fastq, phylip, and nexus
  formats from a file or STDIN. Results are written in fasta format.\n\nTool homepage:
  https://github.com/FePhyFoFum/phyx"
inputs:
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Input sequence files
    inputBinding:
      position: 1
  - id: citation
    type:
      - 'null'
      - boolean
    doc: display phyx citation and exit
    inputBinding:
      position: 102
      prefix: --citation
  - id: guess
    type:
      - 'null'
      - boolean
    doc: 'EXPERIMENTAL: guess whether there are seqs that need to be rev comp. uses
      edlib library on first seq'
    inputBinding:
      position: 102
      prefix: --guess
  - id: ids
    type:
      - 'null'
      - string
    doc: a comma sep list of ids to flip (NO SPACES!)
    inputBinding:
      position: 102
      prefix: --ids
  - id: pguess
    type:
      - 'null'
      - boolean
    doc: 'EXPERIMENTAL: progressively guess'
    inputBinding:
      position: 102
      prefix: --pguess
  - id: seq_file
    type:
      - 'null'
      - File
    doc: input sequence file, STDIN otherwise
    inputBinding:
      position: 102
      prefix: --seqf
  - id: sguess
    type:
      - 'null'
      - boolean
    doc: 'EXPERIMENTAL: sampled guess'
    inputBinding:
      position: 102
      prefix: --sguess
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: output sequence file, STOUT otherwise
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyx:1.1--hc0837bd_5
