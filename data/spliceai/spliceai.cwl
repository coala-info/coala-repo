cwlVersion: v1.2
class: CommandLineTool
baseCommand: spliceai
label: spliceai
doc: "SpliceAI predicts the impact of variants on RNA splicing.\n\nTool homepage:
  https://github.com/Illumina/SpliceAI"
inputs:
  - id: reference
    type: File
    secondaryFiles:
      - .fai
    doc: path to the reference genome fasta file
    inputBinding:
      position: 1
      prefix: -R
  - id: annotation
    type:
      - 'null'
      - string
    doc: '"grch37" (GENCODE V24lift37 canonical annotation file in package), "grch38"
      (GENCODE V24 canonical annotation file in package). Set this or annotation_file.'
    inputBinding:
      position: 2
      prefix: -A
  - id: annotation_file
    type:
      - 'null'
      - File
    doc: path to a custom gene annotation file similar to the package annotation
      files. Use this in place of annotation.
    inputBinding:
      position: 2
      prefix: -A
  - id: input
    type:
      - 'null'
      - File
    doc: path to the input VCF file, defaults to standard in
    inputBinding:
      position: 3
      prefix: -I
  - id: output_path
    type: string
    doc: path to the output VCF file
    inputBinding:
      position: 4
      prefix: -O
  - id: distance
    type:
      - 'null'
      - int
    doc: maximum distance between the variant and gained/lost splice site, 
      defaults to 50
    inputBinding:
      position: 5
      prefix: -D
  - id: mask
    type:
      - 'null'
      - int
    doc: mask scores representing annotated acceptor/donor gain and unannotated 
      acceptor/donor loss, defaults to 0
    inputBinding:
      position: 6
      prefix: -M
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output VCF file
    outputBinding:
      glob: $(inputs.output_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/spliceai:1.3.1--pyh864c0ab_1
