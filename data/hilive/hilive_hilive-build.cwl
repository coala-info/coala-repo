cwlVersion: v1.2
class: CommandLineTool
baseCommand: hilive-build
label: hilive_hilive-build
doc: "Build the k-mer index (*.kix) of reference genomes for HiLive, the realtime
  alignment of Illumina reads.\n\nTool homepage: https://gitlab.com/SimonHTausch/HiLive"
inputs:
  - id: input
    type: File
    doc: Reference genomes in (multi-) FASTA format
    inputBinding:
      position: 1
  - id: kmer_weight
    type: int
    doc: Number of non-gap positions in a k-mer (for ungapped k-mers this is the
      k-mer size)
    inputBinding:
      position: 2
  - id: outfile
    type:
      - 'null'
      - string
    doc: 'Set output file name [Default: INPUT.kix]'
    inputBinding:
      position: 3
      prefix: --outfile
  - id: trim
    type:
      - 'null'
      - int
    doc: 'Ignore k-mers with more than t occurrences [Default: no limit]'
    inputBinding:
      position: 3
      prefix: --trim
  - id: gap_positions
    type:
      - 'null'
      - type: array
        items: int
    doc: 'Gap positions in the k-mer pattern (example: -p 3 6 7 for 1101100111 with
      k=7) [Default: ungapped]'
    inputBinding:
      position: 3
      prefix: --gap-positions
  - id: do_not_convert_spaces
    type:
      - 'null'
      - boolean
    doc: 'Do not convert all spaces in reference ids to underscores [Default: converting
      is on]'
    inputBinding:
      position: 3
      prefix: --do-not-convert-spaces
  - id: trim_after_space
    type:
      - 'null'
      - boolean
    doc: 'Trim all reference ids after first space [Default: false]'
    inputBinding:
      position: 3
      prefix: --trim-after-space
outputs:
  - id: index
    type: File
    doc: K-mer index file
    outputBinding:
      glob: $(inputs.outfile || (inputs.input.basename + '.kix'))
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/hilive:v1.1-2-deb_cv1
stdout: hilive_hilive-build.out
