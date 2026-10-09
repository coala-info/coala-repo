cwlVersion: v1.2
class: CommandLineTool
baseCommand: iu-subsample-fastq
label: illumina-utils_iu-subsample-fastq
doc: "Randomly subsample (without replacement) a FASTQ, or a pair of forward and reverse FASTQs

Tool homepage: https://github.com/meren/illumina-utils"
inputs:
  - id: r1
    type: File
    doc: "FASTQ file to be subsampled (forward reads, or merged/single reads)"
    inputBinding:
      position: 1
      prefix: '--r1'
  - id: r2
    type:
      - 'null'
      - File
    doc: "FASTQ file for the reverse reads"
    inputBinding:
      position: 2
      prefix: '--r2'
  - id: output1
    type: string
    doc: "The output filepath for the forward read"
    inputBinding:
      position: 3
      prefix: '--output1'
  - id: output2
    type:
      - 'null'
      - string
    doc: "The output filepath for the reverse read (only with --r2)"
    inputBinding:
      position: 4
      prefix: '--output2'
  - id: num_reads
    type: int
    doc: "Number of FASTQ entries to randomly sample"
    inputBinding:
      position: 5
      prefix: '-n'
outputs:
  - id: output1_file
    type: File
    doc: "Subsampled forward reads"
    outputBinding:
      glob: $(inputs.output1)
  - id: output2_file
    type:
      - 'null'
      - File
    doc: Subsampled reverse reads
    outputBinding:
      glob: $(inputs.output2)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/illumina-utils:2.13--pyhdfd78af_0
