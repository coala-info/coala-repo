cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hlso
  - cli
label: haplotype-lso_cli
doc: "Classify Lso Sanger reads: align to the reference sequences, compute identity and assign haplotypes.\n\nTool homepage: https://github.com/holtgrewe/haplotype-lso"
inputs:
  - id: sample_name_from_file
    type:
      - 'null'
      - boolean
    doc: "Use sample name instead of file name"
    inputBinding:
      position: 1
      prefix: --sample-name-from-file
  - id: sample_regex
    type:
      - 'null'
      - string
    doc: "Regular expression to match file name to sample name."
    inputBinding:
      position: 1
      prefix: --sample-regex
  - id: output
    type:
      - 'null'
      - string
    doc: "Path to output file (XLSX)"
    inputBinding:
      position: 1
      prefix: --output
  - id: seq_files
    type:
      type: array
      items: File
    doc: "Sequence files (FASTA, FASTQ, AB1, SCF)"
    inputBinding:
      position: 2
outputs:
  - id: report
    type:
      - 'null'
      - File
    doc: "Haplotyping report (XLSX)"
    outputBinding:
      glob: $(inputs.output)
  - id: dendrograms
    type:
      - 'null'
      - type: array
        items: File
    doc: "Dendrogram plots per region"
    outputBinding:
      glob: '*.png'
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/haplotype-lso:0.4.4--pyhdfd78af_4
