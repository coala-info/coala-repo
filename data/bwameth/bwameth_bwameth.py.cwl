cwlVersion: v1.2
class: CommandLineTool
baseCommand: python bwameth.py
label: bwameth_bwameth.py
doc: "map bisulfite converted reads to an insilico converted genome using bwa mem.\n\
  \nTool homepage: https://github.com/brentp/bwa-meth"
inputs:
  - id: fastqs
    type:
      type: array
      items: File
    doc: "bs-seq fastqs to align. Runmultiple sets separated by commas, e.g. ... a_R1.fastq,b_R1.fastq\n\
      a_R2.fastq,b_R2.fastq note that the order must be maintained."
    inputBinding:
      position: 1
  - id: read_group
    type:
      - 'null'
      - string
    doc: "read-group to add to bam in same format as to bwa: '@RG\\tID:foo\\tSM:bar'"
    inputBinding:
      position: 102
      prefix: --read-group
  - id: reference
    type: File
    doc: reference fasta
    inputBinding:
      position: 102
      prefix: --reference
  - id: set_as_failed
    type:
      - 'null'
      - string
    doc: flag alignments to this strand as not passing QC (0x200). Targetted 
      BS-Seq libraries are often to a single strand, so we can flag them as QC 
      failures. Note f == OT, r == OB. Likely, this will be 'f' as we will 
      expect reads to align to the original-bottom (OB) strand and will flag as 
      failed those aligning to the forward, or original top (OT).
    inputBinding:
      position: 102
      prefix: --set-as-failed
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bwameth:0.20--py35_0
stdout: bwameth_bwameth.py.out
