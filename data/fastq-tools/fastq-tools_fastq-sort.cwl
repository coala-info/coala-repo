cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastq-sort
label: fastq-tools_fastq-sort
doc: "Concatenate and sort FASTQ files and write to standard output.\n\nTool homepage:
  http://homes.cs.washington.edu/~dcjones/fastq-tools/"
inputs:
  - id: files
    type:
      - 'null'
      - type: array
        items: File
    doc: FASTQ files to sort
    inputBinding:
      position: 1
  - id: buffer_size
    type:
      - 'null'
      - string
    doc: amount of memory to use for sorting
    inputBinding:
      position: 102
      prefix: --buffer-size
  - id: gc
    type:
      - 'null'
      - boolean
    doc: sort by GC content
    inputBinding:
      position: 102
      prefix: --gc
  - id: id
    type:
      - 'null'
      - boolean
    doc: sort alphabetically by read identifier
    inputBinding:
      position: 102
      prefix: --id
  - id: idn
    type:
      - 'null'
      - boolean
    doc: sort alphanumerically by read identifier according to "samtools sort 
      -n"
    inputBinding:
      position: 102
      prefix: --idn
  - id: mean_qual
    type:
      - 'null'
      - boolean
    doc: sort by median quality score
    inputBinding:
      position: 102
      prefix: --mean-qual
  - id: random
    type:
      - 'null'
      - boolean
    doc: randomly shuffle the sequences
    inputBinding:
      position: 102
      prefix: --random
  - id: reverse
    type:
      - 'null'
      - boolean
    doc: sort in reverse (i.e., descending) order
    inputBinding:
      position: 102
      prefix: --reverse
  - id: seed
    type:
      - 'null'
      - int
    doc: seed to use for random shuffle.
    inputBinding:
      position: 102
      prefix: --seed
  - id: seq
    type:
      - 'null'
      - boolean
    doc: sort alphabetically by sequence
    inputBinding:
      position: 102
      prefix: --seq
  - id: temporary_directory
    type:
      - 'null'
      - Directory
    doc: write temporary files here, instead of $TMPDIR, or /tmp
    inputBinding:
      position: 102
      prefix: --temporary-directory
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastq-tools:0.8.3--h1104d80_7
stdout: fastq-tools_fastq-sort.out
