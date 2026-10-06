cwlVersion: v1.2
class: CommandLineTool
baseCommand: deinterleave_fastq.sh
label: atlas-fastq-provider_deinterleave_fastq.sh
doc: "Deinterleaves paired-end FASTQ files.\n\nTool homepage: https://github.com/ebi-gene-expression-group/atlas-fastq-provider"
inputs:
  - id: interleaved_fastq
    type: File
    doc: The interleaved FASTQ file (read from standard input).
  - id: output_prefix
    type: string
    doc: Prefix for the output FASTQ files (e.g., 'sample_'). This will create 
      'sample_1.fastq' and 'sample_2.fastq'.
  - id: compress
    type:
      - 'null'
      - boolean
    doc: GZip compress the output FASTQ files with pigz (file names stay the 
      same).
    inputBinding:
      position: 3
      valueFrom: '$(self ? "compress" : null)'
arguments:
  - position: 1
    valueFrom: $(inputs.output_prefix)1.fastq
  - position: 2
    valueFrom: $(inputs.output_prefix)2.fastq
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_prefix_files
    type:
      type: array
      items: File
    doc: Files written with the prefix given in output_prefix
    outputBinding:
      glob: $(inputs.output_prefix)*
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/atlas-fastq-provider:0.4.8--hdfd78af_0
stdin: $(inputs.interleaved_fastq.path)
stdout: atlas-fastq-provider_deinterleave_fastq.sh.out
