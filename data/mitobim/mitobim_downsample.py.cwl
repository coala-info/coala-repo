cwlVersion: v1.2
class: CommandLineTool
baseCommand: downsample.py
label: mitobim_downsample.py
doc: "Randomly subsamples reads from one or more FASTQ files (plain or gzipped) and
  writes them to standard output; two input files can be interleaved.\n\nTool homepage:
  https://github.com/chrishah/MITObim"
inputs:
  - id: reads
    type:
      type: array
      items: File
      inputBinding:
        prefix: --reads
    doc: Readfile (the flag is repeated to process several files).
    inputBinding:
      position: 1
  - id: sample
    type:
      - 'null'
      - int
    doc: Desired size of subsample in percent (1-100; default = 50)
    inputBinding:
      position: 2
      prefix: --sample
  - id: interleave
    type:
      - 'null'
      - boolean
    doc: In case of two input files, data will be interleaved from these in the
      output. Otherwise data will be treated as already interleaved.
    inputBinding:
      position: 3
      prefix: --interleave
  - id: seed
    type:
      - 'null'
      - int
    doc: Seed for the random number generator.
    inputBinding:
      position: 4
      prefix: --seed
outputs:
  - id: subsample
    type: stdout
    doc: Subsampled reads in FASTQ format
stdout: mitobim_downsample.py.fastq
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mitobim:1.9.1--hdfd78af_1
