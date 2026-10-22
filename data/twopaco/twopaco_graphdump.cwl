cwlVersion: v1.2
class: CommandLineTool
baseCommand: graphdump
label: twopaco_graphdump
doc: "This utility converts the binary output of TwoPaCo to another format\n\nTool\
  \ homepage: https://github.com/medvedevgroup/TwoPaCo"
stdout: $(inputs.output_name)
inputs:
  - id: input_file
    type: File
    doc: Binary de Bruijn graph file made by twopaco
    inputBinding:
      position: 10
  - id: kvalue
    type: int
    doc: Value of k
    inputBinding:
      position: 1
      prefix: --kvalue
  - id: format
    type:
      type: enum
      symbols: [seq, group, dot, gfa1, gfa2, fasta]
    doc: Output format
    inputBinding:
      position: 2
      prefix: --format
  - id: seqfile
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: --seqfile
    doc: Sequences file name (the genomes given to twopaco; needed for gfa and fasta output)
    inputBinding:
      position: 3
  - id: prefix
    type: ['null', boolean]
    doc: Add a prefix to segments in GFA (in case you have genomes with identical
      FASTA headers)
    inputBinding:
      position: 4
      prefix: --prefix
  - id: output_name
    type: ['null', string]
    default: graphdump.out
    doc: Name of the output file (standard output of the tool)
outputs:
  - id: dump
    type: File
    doc: Graph converted to the chosen format
    outputBinding:
      glob: $(inputs.output_name)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/twopaco:1.1.0--hc252753_1
