cwlVersion: v1.2
class: CommandLineTool
baseCommand: ostir
label: ostir
doc: "OSTIR (Open Source Translation Initiation Rates) version 1.1.1\n\nTool homepage:
  https://github.com/barricklab/rbs-calculator"
inputs:
  - id: anti_shine_dalgarno
    type:
      - 'null'
      - string
    doc: "anti-Shine-Dalgarno sequence: the 9 bases located at the 3' end of 16S rRNA.
      May be provided as DNA or RNA. Defaults to that of E. coli (ACCTCCTTA)."
    default: ACCTCCTTA
    inputBinding:
      position: 101
      prefix: --anti-Shine-Dalgarno
  - id: circular
    type:
      - 'null'
      - boolean
    doc: Flag the input as circular
    inputBinding:
      position: 101
      prefix: --circular
  - id: end
    type:
      - 'null'
      - int
    doc: Most 3' nucleotide position to consider a start codon beginning 
      (1-indexed)
    inputBinding:
      position: 101
      prefix: --end
  - id: input
    type:
      - 'null'
      - string
    doc: "Input filename (FASTA/CSV) or DNA/RNA sequence. For CSV input files, there
      must be a 'seq' or 'sequence' column. Other columns will override any options
      provided at the command line if they are present: 'name/id', 'start', 'end',
      'anti-Shine-Dalgarno'"
    inputBinding:
      position: 101
      prefix: --input
  - id: print_anti_shine_dalgarno
    type:
      - 'null'
      - boolean
    doc: Include the anti-Shine-Dalgarno sequence in output CSV files
    inputBinding:
      position: 101
      prefix: --print-anti-Shine-Dalgarno
  - id: print_sequence
    type:
      - 'null'
      - boolean
    doc: Include the input mRNA sequence in output CSV files
    inputBinding:
      position: 101
      prefix: --print-sequence
  - id: start
    type:
      - 'null'
      - int
    doc: Most 5' nucleotide position to consider a start codon beginning 
      (1-indexed)
    inputBinding:
      position: 101
      prefix: --start
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads for multiprocessing
    inputBinding:
      position: 101
      prefix: --threads
  - id: type
    type:
      - 'null'
      - string
    doc: Input type (overrides autodetection)
    inputBinding:
      position: 101
      prefix: --type
  - id: versity
    type:
      - 'null'
      - int
    doc: Sets the verbosity level. Default 0 is quiet, 1 is normal, 2 is verbose
    default: 0
    inputBinding:
      position: 101
      prefix: --versity
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output file path. If not provided, results will output to the console
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ostir:1.1.2--pyhdfd78af_0
