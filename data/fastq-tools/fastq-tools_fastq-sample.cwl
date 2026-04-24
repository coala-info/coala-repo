cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastq-sample
label: fastq-tools_fastq-sample
doc: "Sample random reads from a FASTQ file.\n\nTool homepage: http://homes.cs.washington.edu/~dcjones/fastq-tools/"
inputs:
  - id: input_file
    type: File
    doc: FASTQ file to sample from
    inputBinding:
      position: 1
  - id: input_file2
    type:
      - 'null'
      - File
    doc: Second FASTQ file to sample from
    inputBinding:
      position: 2
  - id: complement_output_prefix
    type:
      - 'null'
      - string
    doc: output reads not included in the random sample to a file (or files) 
      with the given prefix
    inputBinding:
      position: 103
      prefix: --complement-output
  - id: num_reads
    type:
      - 'null'
      - int
    doc: the number of reads to sample
    inputBinding:
      position: 103
      prefix: -n
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: output file prefix
    inputBinding:
      position: 103
      prefix: --output
  - id: proportion
    type:
      - 'null'
      - float
    doc: the proportion of the total reads to sample
    inputBinding:
      position: 103
      prefix: -p
  - id: seed
    type:
      - 'null'
      - int
    doc: a manual seed to the random number generator
    inputBinding:
      position: 103
      prefix: --seed
  - id: with_replacement
    type:
      - 'null'
      - boolean
    doc: sample with replacement
    inputBinding:
      position: 103
      prefix: --with-replacement
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastq-tools:0.8.3--h1104d80_7
stdout: fastq-tools_fastq-sample.out
