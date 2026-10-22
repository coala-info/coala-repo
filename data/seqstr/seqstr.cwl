cwlVersion: v1.2
class: CommandLineTool
baseCommand: seqstr
label: seqstr
doc: "Compile simple string input (genome intervals, raw sequence and mutations) into long genomic sequences in FASTA format.\n\nTool homepage: https://github.com/jzhoulab/Seqstr"
inputs:
  - id: input_file
    type:
      - 'null'
      - File
    doc: Specify the input file
    inputBinding:
      position: 1
  - id: download
    type:
      - 'null'
      - string
    doc: Specify the genome files to download
    inputBinding:
      position: 2
      prefix: --download
  - id: dir
    type:
      - 'null'
      - string
    doc: Specify the directory for downloading genome files
    inputBinding:
      position: 3
      prefix: --dir
  - id: output_path
    type: string
    doc: Specify the output fasta file path and name
    inputBinding:
      position: 4
      prefix: --output
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output FASTA file.
    outputBinding:
      glob: $(inputs.output_path)
  - id: genome_dir
    type:
      - 'null'
      - Directory
    doc: Directory with the downloaded genome files.
    outputBinding:
      glob: '$(inputs.dir ? inputs.dir : "_no_genome_dir_")'
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqstr:0.1.0--pyhdfd78af_0
