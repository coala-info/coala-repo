cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - psirc-quant
  - pseudo
label: psirc_pseudo
doc: "Computes equivalence classes for reads (pseudoalignment step)\n\nTool homepage: https://github.com/nictru/psirc"
inputs:
  - id: fastq_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "FASTQ file(s); not needed with --batch"
    inputBinding:
      position: 30
  - id: index
    type: File
    doc: "Index to be used for pseudoalignment"
    inputBinding:
      position: 1
      prefix: -i
  - id: output_dir
    type: string
    doc: "Directory to write output to"
    inputBinding:
      position: 2
      prefix: -o
  - id: umi
    type:
      - 'null'
      - boolean
    doc: "First file in pair is a UMI file"
    inputBinding:
      position: 3
      prefix: --umi
  - id: batch
    type:
      - 'null'
      - File
    doc: "Process files listed in FILE"
    inputBinding:
      position: 4
      prefix: --batch
  - id: single
    type:
      - 'null'
      - boolean
    doc: "Quantify single-end reads"
    inputBinding:
      position: 5
      prefix: --single
  - id: fragment_length
    type:
      - 'null'
      - float
    doc: "Estimated average fragment length"
    inputBinding:
      position: 6
      prefix: -l
  - id: sd
    type:
      - 'null'
      - float
    doc: "Estimated standard deviation of fragment length"
    inputBinding:
      position: 7
      prefix: -s
  - id: min_fragment_length
    type:
      - 'null'
      - int
    doc: "Minimum length of a valid fragment"
    inputBinding:
      position: 8
      prefix: -x
  - id: max_fragment_length
    type:
      - 'null'
      - int
    doc: "Maximum length of a valid fragment"
    inputBinding:
      position: 9
      prefix: -X
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads to use (default: 1)"
    inputBinding:
      position: 10
      prefix: -t
outputs:
  - id: output
    type: Directory
    doc: "Output directory with the pseudoalignment results"
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/psirc:1.0.0--h6f0a7f7_1
