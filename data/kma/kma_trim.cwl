cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - kma
  - trim
label: kma_trim
doc: "kma trim trims sequences\n\nTool homepage: https://bitbucket.org/genomicepidemiology/kma"
inputs:
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: -i
    doc: "Input file(s) (default STDIN)"
    inputBinding:
      position: 1
  - id: paired_input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "Paired input files"
    inputBinding:
      position: 1
      prefix: -ipe
  - id: interleaved_input_files
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: -int
    doc: "Interleaved input file(s)"
    inputBinding:
      position: 1
  - id: output_name
    type: ['null', string]
    doc: "Output file prefix; kma appends .fq (default STDOUT)"
    inputBinding:
      position: 2
      prefix: -o
  - id: qc
    type: ['null', int]
    doc: "Report QC, repeat for verbose"
    inputBinding:
      position: 2
      prefix: -qc
  - id: min_length
    type: ['null', int]
    doc: "Minimum length (default 16)"
    inputBinding:
      position: 2
      prefix: -ml
  - id: max_length
    type: ['null', int]
    doc: "Maximum length (default 2147483647)"
    inputBinding:
      position: 2
      prefix: -xl
  - id: min_phred
    type: ['null', int]
    doc: "Minimum phred (default 20)"
    inputBinding:
      position: 2
      prefix: -mp
  - id: min_internal_phred
    type: ['null', int]
    doc: "Minimum internal phred score (default 0)"
    inputBinding:
      position: 2
      prefix: -mi
  - id: min_avg_quality
    type: ['null', int]
    doc: "Minimum average quality (default 0)"
    inputBinding:
      position: 2
      prefix: -eq
  - id: trim_5_prime
    type: ['null', int]
    doc: "Trim 5 prime (default 0)"
    inputBinding:
      position: 2
      prefix: -5p
  - id: trim_3_prime
    type: ['null', int]
    doc: "Trim 3 prime (default 0)"
    inputBinding:
      position: 2
      prefix: -3p
outputs:
  - id: trimmed_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "Trimmed sequences written with -o (name plus .fq)"
    outputBinding:
      glob: $(inputs.output_name)*
  - id: stdout
    type: stdout
    doc: Standard output (trimmed sequences when -o is not given)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kma:1.6.8--h577a1d6_0
stdout: kma_trim.out
