cwlVersion: v1.2
class: CommandLineTool
baseCommand: deinterleave_fastq.sh
label: atlas-fastq-provider_deinterleave_fastq.sh
doc: "Deinterleaves paired-end FASTQ files.\n\nTool homepage: https://github.com/ebi-gene-expression-group/atlas-fastq-provider"
inputs:
  - id: interleaved_fastq
    type: File
    doc: The interleaved FASTQ file.
    inputBinding:
      position: 1
  - id: output_prefix
    type: string
    doc: Prefix for the output FASTQ files (e.g., 'sample_'). This will create 
      'sample_1.fastq' and 'sample_2.fastq'.
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/atlas-fastq-provider:0.4.8--hdfd78af_0
stdout: atlas-fastq-provider_deinterleave_fastq.sh.out
