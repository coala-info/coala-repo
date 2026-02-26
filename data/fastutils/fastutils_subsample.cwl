cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fastutils
  - subsample
label: fastutils_subsample
doc: "Subsamples reads from an input file based on coverage depth and genome size.\n\
  \nTool homepage: https://github.com/haghshenas/fastutils"
inputs:
  - id: comment
    type:
      - 'null'
      - boolean
    doc: print comments in headers
    inputBinding:
      position: 101
      prefix: --comment
  - id: depth
    type: int
    doc: coverage of the subsampled set
    inputBinding:
      position: 101
      prefix: --depth
  - id: fastq
    type:
      - 'null'
      - boolean
    doc: output reads in fastq format if possible
    inputBinding:
      position: 101
      prefix: --fastq
  - id: fofn
    type:
      - 'null'
      - boolean
    doc: input file is a file of file names
    inputBinding:
      position: 101
      prefix: --fofn
  - id: genome_size
    type: float
    doc: length of the genome. Accepted suffixes are k,m,g
    inputBinding:
      position: 101
      prefix: --genomeSize
  - id: input_file
    type: File
    doc: input file in fasta/q format. This options is required if -r or -l are 
      used
    inputBinding:
      position: 101
      prefix: --in
  - id: keep
    type:
      - 'null'
      - boolean
    doc: keep name as a comment when using -n
    inputBinding:
      position: 101
      prefix: --keep
  - id: longest
    type:
      - 'null'
      - boolean
    doc: subsample longest reads instead of selecting top reads
    inputBinding:
      position: 101
      prefix: --longest
  - id: num
    type:
      - 'null'
      - boolean
    doc: use read index instead of read name
    inputBinding:
      position: 101
      prefix: --num
  - id: random
    type:
      - 'null'
      - boolean
    doc: subsample randomly instead of selecting top reads
    inputBinding:
      position: 101
      prefix: --random
  - id: seed
    type:
      - 'null'
      - int
    doc: seed for random number generator
    inputBinding:
      position: 101
      prefix: --seed
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: output file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastutils:0.3--h077b44d_5
