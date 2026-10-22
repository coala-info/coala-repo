cwlVersion: v1.2
class: CommandLineTool
baseCommand: [scrappie, squiggle]
label: scrappie_squiggle
doc: "Scrappie squiggler\n\nTool homepage: https://github.com/nanoporetech/scrappie"
inputs:
  - id: fasta_files
    type:
      type: array
      items: File
    doc: "Input fasta files"
    inputBinding:
      position: 200
  - id: limit
    type: ['null', int]
    doc: "Maximum number of reads to call (0 is unlimited)"
    inputBinding:
      prefix: --limit
  - id: model
    type: ['null', string]
    doc: "Squiggle model to use: \"squiggle_r94\", \"squiggle_r94_rna\", \"squiggle_r10\""
    inputBinding:
      prefix: --model
  - id: output
    type: ['null', string]
    doc: "Write to file rather than stdout"
    inputBinding:
      prefix: --output
  - id: prefix
    type: ['null', string]
    doc: "Prefix to append to name of each read"
    inputBinding:
      prefix: --prefix
  - id: rescale
    type: ['null', boolean]
    doc: "Rescale network output"
    inputBinding:
      prefix: --rescale
  - id: no_rescale
    type: ['null', boolean]
    doc: "Do not rescale network output"
    inputBinding:
      prefix: --no-rescale
outputs:
  - id: stdout
    type: stdout
    doc: Standard output (used when --output is not set)
  - id: output_file
    type: ['null', File]
    doc: Output file written with --output
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scrappie:1.4.2--py310pl5321h9a1f509_7
stdout: scrappie_squiggle.out
