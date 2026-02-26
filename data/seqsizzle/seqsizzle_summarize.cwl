cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seqsizzle
  - summarize
label: seqsizzle_summarize
doc: "Summarize the reads with patterns specified by the --patterns argument or the
  adapter flags. Make sure you supply the flags BEFORE the subcommand, e.g. `./SeqSizzle
  my.fastq -p my_patterns.csv --adapter-3p summarize`. '..' indicats unmatched regions
  of positive length, '-' indicates the patterns are overlapped, print the number
  of reads that match each pattern combination in TSV format. To be moved to the UI
  in the future\n\nTool homepage: https://github.com/ChangqingW/SeqSizzle"
inputs:
  - id: input_file
    type: File
    doc: Input FASTQ file
    inputBinding:
      position: 1
  - id: counts
    type:
      - 'null'
      - boolean
    doc: Print the counts of each summarized catagory instead of the percentage
    inputBinding:
      position: 102
      prefix: --counts
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqsizzle:0.4.1--h790517f_0
stdout: seqsizzle_summarize.out
