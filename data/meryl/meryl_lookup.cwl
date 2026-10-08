cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - meryl-lookup
label: meryl_lookup
doc: "Compare kmers in input sequences (FASTA or FASTQ) against kmers in meryl databases and report their positions (BED), multiplicity or depth (WIGGLE), existence counts, or copy the sequences that contain (-include) or lack (-exclude) database kmers.\n\nTool homepage: https://github.com/marbl/meryl"
inputs:
  - id: bed
    type:
      - 'null'
      - boolean
    doc: "Report type: BED file with the location of each kmer found in any database (-bed)"
    inputBinding:
      position: 1
      prefix: -bed
  - id: bed_runs
    type:
      - 'null'
      - boolean
    doc: "Report type: BED file where overlapping kmers are combined into one record (-bed-runs)"
    inputBinding:
      position: 1
      prefix: -bed-runs
  - id: wig_count
    type:
      - 'null'
      - boolean
    doc: "Report type: WIGGLE file with the multiplicity of the kmer starting at each position (-wig-count)"
    inputBinding:
      position: 1
      prefix: -wig-count
  - id: wig_depth
    type:
      - 'null'
      - boolean
    doc: "Report type: WIGGLE file with the number of database kmers covering each position (-wig-depth)"
    inputBinding:
      position: 1
      prefix: -wig-depth
  - id: existence
    type:
      - 'null'
      - boolean
    doc: "Report type: one line per sequence with the kmers in the sequence, in the database and shared (-existence)"
    inputBinding:
      position: 1
      prefix: -existence
  - id: include
    type:
      - 'null'
      - boolean
    doc: "Report type: copy sequences with at least one kmer present in the database (-include)"
    inputBinding:
      position: 1
      prefix: -include
  - id: exclude
    type:
      - 'null'
      - boolean
    doc: "Report type: copy sequences with no kmer present in the database (-exclude)"
    inputBinding:
      position: 1
      prefix: -exclude
  - id: sequence1
    type: File
    doc: "Input sequences, FASTA or FASTQ, uncompressed or compressed with gzip, xz or bzip2 (-sequence input1.fasta)"
    inputBinding:
      position: 2
      prefix: -sequence
  - id: sequence2
    type:
      - 'null'
      - File
    doc: "Second input sequence file, for paired -include and -exclude"
    inputBinding:
      position: 3
  - id: output1
    type:
      - 'null'
      - string
    doc: "Output file name (-output output1)"
    inputBinding:
      position: 4
      prefix: -output
  - id: output2
    type:
      - 'null'
      - string
    doc: "Second output file name, for paired -include and -exclude"
    inputBinding:
      position: 5
  - id: mers
    type:
      type: array
      items: Directory
    doc: "Input meryl databases (-mers input1.meryl [input2.meryl ...])"
    inputBinding:
      position: 6
      prefix: -mers
  - id: labels
    type:
      - 'null'
      - type: array
        items: string
    doc: "Labels for the input databases (-labels)"
    inputBinding:
      position: 7
      prefix: -labels
  - id: min_value
    type:
      - 'null'
      - int
    doc: "Ignore database kmers with a value below this (-min)"
    inputBinding:
      position: 8
      prefix: -min
  - id: max_value
    type:
      - 'null'
      - int
    doc: "Ignore database kmers with a value above this (-max)"
    inputBinding:
      position: 9
      prefix: -max
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of compute threads (-threads)"
    inputBinding:
      position: 10
      prefix: -threads
  - id: loadthreads
    type:
      - 'null'
      - int
    doc: "Number of threads for loading the kmer databases (-loadthreads)"
    inputBinding:
      position: 11
      prefix: -loadthreads
  - id: memory
    type:
      - 'null'
      - float
    doc: "Memory limit in GB (-memory)"
    inputBinding:
      position: 12
      prefix: -memory
  - id: ten_x
    type:
      - 'null'
      - boolean
    doc: "Ignore the first 23 bp of every sequence in input1.fasta (10x barcodes) with -include and -exclude (-10x)"
    inputBinding:
      position: 13
      prefix: -10x
  - id: estimate
    type:
      - 'null'
      - boolean
    doc: "Only compute and report the estimated memory usage (-estimate)"
    inputBinding:
      position: 14
      prefix: -estimate
  - id: show_progress
    type:
      - 'null'
      - boolean
    doc: "Show progress (-V)"
    inputBinding:
      position: 15
      prefix: -V
outputs:
  - id: report
    type:
      - 'null'
      - File
    doc: "Report written to the first output file"
    outputBinding:
      glob: $(inputs.output1)
  - id: report2
    type:
      - 'null'
      - File
    doc: "Second output file, for paired -include and -exclude"
    outputBinding:
      glob: $(inputs.output2)
requirements:
  - class: InlineJavascriptRequirement
  - class: ResourceRequirement
    coresMin: 1
    ramMin: 2048
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/meryl:1.4.1--h9948957_2
