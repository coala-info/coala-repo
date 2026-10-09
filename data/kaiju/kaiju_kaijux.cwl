cwlVersion: v1.2
class: CommandLineTool
baseCommand: kaijux
label: kaiju_kaijux
doc: "Match protein sequences or translated reads to a protein database (.fmi) and report the matching database sequences.\n\nTool homepage: https://github.com/bioinformatics-centre/kaiju"
inputs:
  - id: db_file
    type: File
    doc: "Name of database (.fmi) file"
    inputBinding:
      position: 1
      prefix: -f
  - id: input_file
    type: File
    doc: "Name of input file containing reads in FASTA or FASTQ format"
    inputBinding:
      position: 2
      prefix: -i
  - id: input_file2
    type:
      - 'null'
      - File
    doc: "Name of second input file for paired-end reads"
    inputBinding:
      position: 3
      prefix: -j
  - id: output_file_path
    type:
      - 'null'
      - string
    doc: "Name of output file. If not specified, output will be printed to STDOUT"
    inputBinding:
      position: 4
      prefix: -o
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of parallel threads for classification (default: 1)"
    inputBinding:
      position: 5
      prefix: -z
  - id: run_mode
    type:
      - 'null'
      - string
    doc: "Run mode, either \"mem\" or \"greedy\" (default: greedy)"
    inputBinding:
      position: 6
      prefix: -a
  - id: mismatches
    type:
      - 'null'
      - int
    doc: "Number of mismatches allowed in Greedy mode (default: 3)"
    inputBinding:
      position: 7
      prefix: -e
  - id: min_match_length
    type:
      - 'null'
      - int
    doc: "Minimum match length (default: 11)"
    inputBinding:
      position: 8
      prefix: -m
  - id: min_match_score
    type:
      - 'null'
      - int
    doc: "Minimum match score in Greedy mode (default: 65)"
    inputBinding:
      position: 9
      prefix: -s
  - id: min_evalue
    type:
      - 'null'
      - float
    doc: "Minimum E-value in Greedy mode (default: 0.01)"
    inputBinding:
      position: 10
      prefix: -E
  - id: seg_filter
    type:
      - 'null'
      - boolean
    doc: "Enable SEG low complexity filter (enabled by default)"
    inputBinding:
      position: 11
      prefix: -x
  - id: no_seg_filter
    type:
      - 'null'
      - boolean
    doc: "Disable SEG low complexity filter"
    inputBinding:
      position: 12
      prefix: -X
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Enable verbose output"
    inputBinding:
      position: 13
      prefix: -v
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: "Classification output (tab separated), when -o is given"
    outputBinding:
      glob: $(inputs.output_file_path)
  - id: stdout
    type: stdout
    doc: Standard output (the result when no output file is given)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kaiju:1.10.1--h5ca1c30_3
stdout: kaiju_kaijux.out
