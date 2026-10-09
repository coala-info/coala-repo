cwlVersion: v1.2
class: CommandLineTool
baseCommand: sample-reads-randomly.py
label: khmer_sample-reads-randomly.py
doc: |-
  Uniformly subsample sequences from a collection of files, using reservoir sampling. By default one sample of 100,000 sequences is taken. The output is placed in the --output file (for a single sample) or in <file>.subset.0 to <file>.subset.S-1 (for more than one sample).

  Tool homepage: https://khmer.readthedocs.io/
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: filenames
    type: File[]
    doc: Input FAST[AQ] sequence files
    inputBinding:
      position: 1
  - id: info
    type: ['null', boolean]
    doc: print citation information
    inputBinding:
      position: 103
      prefix: --info
  - id: num_reads
    type: ['null', int]
    doc: Number of reads to sample
    inputBinding:
      position: 103
      prefix: --num_reads
  - id: max_reads
    type: ['null', int]
    doc: Stop after the first max_reads sequences
    inputBinding:
      position: 103
      prefix: --max_reads
  - id: samples
    type: ['null', int]
    doc: Number of samples to take
    inputBinding:
      position: 103
      prefix: --samples
  - id: random_seed
    type: ['null', int]
    doc: Provide a random seed for the generator
    inputBinding:
      position: 103
      prefix: --random-seed
  - id: force_single
    type: ['null', boolean]
    doc: Ignore read pair information if present
    inputBinding:
      position: 103
      prefix: --force_single
  - id: output
    type: ['null', string]
    doc: Output file name (single sample)
    inputBinding:
      position: 103
      prefix: --output
  - id: force
    type: ['null', boolean]
    doc: Overwrite output file if it exists
    inputBinding:
      position: 103
      prefix: --force
  - id: gzip
    type: ['null', boolean]
    doc: Compress output using gzip
    inputBinding:
      position: 103
      prefix: --gzip
  - id: bzip
    type: ['null', boolean]
    doc: Compress output using bzip2
    inputBinding:
      position: 103
      prefix: --bzip
outputs:
  - id: output_output
    type: ['null', File]
    doc: Subsampled reads written to the --output file
    outputBinding:
      glob: "$(inputs.output)"
  - id: subsets
    type: File[]
    doc: Subsampled reads, one <file>.subset.N file per sample (when --output is not given)
    outputBinding:
      glob: "*.subset.*"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/khmer:3.0.0a1--py36hfc679d8_0
s:url: https://khmer.readthedocs.io/
$namespaces:
  s: https://schema.org/
