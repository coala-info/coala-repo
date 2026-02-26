cwlVersion: v1.2
class: CommandLineTool
baseCommand: EBFilter
label: ebfilter_EBFilter
doc: "EBFilter is a tool for filtering mutations based on read counts in target and
  control BAM files.\n\nTool homepage: https://github.com/Genomon-Project/EBFilter"
inputs:
  - id: target_vcf
    type: File
    doc: the path to the mutation file
    inputBinding:
      position: 1
  - id: target_bam
    type: File
    doc: the path to the target bam file
    inputBinding:
      position: 2
  - id: control_bam_list
    type: File
    doc: the list of paths to control bam files
    inputBinding:
      position: 3
  - id: base_qual_thres
    type:
      - 'null'
      - int
    doc: threshold for base quality for calculating base counts
    inputBinding:
      position: 104
      prefix: -Q
  - id: debug
    type:
      - 'null'
      - boolean
    doc: keep intermediate files
    inputBinding:
      position: 104
      prefix: --debug
  - id: filter_flags
    type:
      - 'null'
      - string
    doc: skip reads with mask bits set
    inputBinding:
      position: 104
      prefix: --ff
  - id: format
    type:
      - 'null'
      - string
    doc: the format of mutation file vcf or annovar (tsv) format
    inputBinding:
      position: 104
      prefix: -f
  - id: loption
    type:
      - 'null'
      - boolean
    doc: use samtools mpileup -l option
    inputBinding:
      position: 104
      prefix: --loption
  - id: mapping_qual_thres
    type:
      - 'null'
      - int
    doc: threshold for mapping quality for calculating base counts
    inputBinding:
      position: 104
      prefix: -q
  - id: region
    type:
      - 'null'
      - string
    doc: restrict the chromosomal region for mutation. active only if loption is
      on
    inputBinding:
      position: 104
      prefix: --region
  - id: thread_num
    type:
      - 'null'
      - int
    doc: the number of threads
    inputBinding:
      position: 104
      prefix: -t
outputs:
  - id: output_vcf
    type: File
    doc: the path to the output
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ebfilter:0.2.2--pyh5ca1d4c_0
