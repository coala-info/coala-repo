cwlVersion: v1.2
class: CommandLineTool
baseCommand: kaiju-multi
label: kaiju_kaiju-multi
doc: "Run kaiju on several samples at once, loading the database only once.\n\nTool homepage: https://github.com/bioinformatics-centre/kaiju"
inputs:
  - id: nodes_file
    type: File
    doc: "Name of nodes.dmp file"
    inputBinding:
      position: 1
      prefix: -t
  - id: db_file
    type: File
    doc: "Name of database (.fmi) file"
    inputBinding:
      position: 2
      prefix: -f
  - id: input_files
    type:
      type: array
      items: File
    doc: "List of input files containing reads in FASTA or FASTQ format"
    inputBinding:
      position: 3
      prefix: -i
      itemSeparator: ','
  - id: output_file_paths
    type:
      type: array
      items: string
    doc: "List of output files (one name per input file)"
    inputBinding:
      position: 4
      prefix: -o
      itemSeparator: ','
  - id: input_files2
    type:
      - 'null'
      - type: array
        items: File
    doc: "List of secondary input files for paired-end reads"
    inputBinding:
      position: 5
      prefix: -j
      itemSeparator: ','
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of parallel threads for classification (default: 1)"
    inputBinding:
      position: 6
      prefix: -z
  - id: run_mode
    type:
      - 'null'
      - string
    doc: "Run mode, either \"mem\" or \"greedy\" (default: greedy)"
    inputBinding:
      position: 7
      prefix: -a
  - id: mismatches
    type:
      - 'null'
      - int
    doc: "Number of mismatches allowed in Greedy mode (default: 3)"
    inputBinding:
      position: 8
      prefix: -e
  - id: min_match_length
    type:
      - 'null'
      - int
    doc: "Minimum match length (default: 11)"
    inputBinding:
      position: 9
      prefix: -m
  - id: min_match_score
    type:
      - 'null'
      - int
    doc: "Minimum match score in Greedy mode (default: 65)"
    inputBinding:
      position: 10
      prefix: -s
  - id: min_evalue
    type:
      - 'null'
      - float
    doc: "Minimum E-value in Greedy mode (default: 0.01)"
    inputBinding:
      position: 11
      prefix: -E
  - id: seg_filter
    type:
      - 'null'
      - boolean
    doc: "Enable SEG low complexity filter (enabled by default)"
    inputBinding:
      position: 12
      prefix: -x
  - id: no_seg_filter
    type:
      - 'null'
      - boolean
    doc: "Disable SEG low complexity filter"
    inputBinding:
      position: 13
      prefix: -X
  - id: protein
    type:
      - 'null'
      - boolean
    doc: "Input sequences are protein sequences"
    inputBinding:
      position: 14
      prefix: -p
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Enable verbose output"
    inputBinding:
      position: 15
      prefix: -v
outputs:
  - id: output_files
    type:
      type: array
      items: File
    doc: "Classification output files, one per input file"
    outputBinding:
      glob: $(inputs.output_file_paths)
  - id: stdout
    type: stdout
    doc: Standard output (the result when no output file is given)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kaiju:1.10.1--h5ca1c30_3
stdout: kaiju_kaiju-multi.out
