cwlVersion: v1.2
class: CommandLineTool
baseCommand: get_pair_reads.py
label: getorganelle_get_pair_reads.py
doc: "Split two fastq files into properly paired reads and unpaired reads.\n\nTool homepage: http://github.com/Kinggerm/GetOrganelle"
inputs:
  - id: fastq_1
    type:
      - File
    doc: "First fastq file (*_1.fq or *_1.fastq)."
    inputBinding:
      position: 1
  - id: fastq_2
    type:
      - File
    doc: "Second fastq file (*_2.fq or *_2.fastq)."
    inputBinding:
      position: 2
outputs:
  - id: paired_fastq
    type:
      type: array
      items: File
    doc: "Paired reads (*_paired.fq)."
    outputBinding:
      glob: "*_paired.fq"
  - id: unpaired_fastq
    type:
      type: array
      items: File
    doc: "Unpaired reads (*_unpaired.fq)."
    outputBinding:
      glob: "*_unpaired.fq"
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.fastq_1)
        writable: true
      - entry: $(inputs.fastq_2)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/getorganelle:1.7.7.1--pyhdfd78af_0
stdout: getorganelle_get_pair_reads.py.out
