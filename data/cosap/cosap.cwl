cwlVersion: v1.2
class: CommandLineTool
baseCommand: cosap
label: cosap
doc: "cosap\n\nTool homepage: https://github.com/MBaysanLab/cosap"
inputs:
  - id: analysis_type
    type: string
    doc: Type of the analysis, can be somatic or germline
    inputBinding:
      position: 101
      prefix: --analysis_type
  - id: annotators
    type:
      - 'null'
      - string
    doc: Annotation tool to annotate variants in vcf files.
    inputBinding:
      position: 101
      prefix: --annotators
  - id: bam_qc
    type:
      - 'null'
      - string
    doc: Qaulity control algorithm for .bam quality check. Options = 
      ['qualimap', 'mosdepth']
    inputBinding:
      position: 101
      prefix: --bam_qc
  - id: bed_file
    type:
      - 'null'
      - File
    doc: Path to BED file
    inputBinding:
      position: 101
      prefix: --bed_file
  - id: device
    type:
      - 'null'
      - string
    doc: Device to run the pipeline on. Options = ['cpu', 'gpu']
    inputBinding:
      position: 101
      prefix: --device
  - id: gene_fusion
    type:
      - 'null'
      - boolean
    doc: Run gene fusion analysis
    inputBinding:
      position: 101
      prefix: --gene_fusion
  - id: gvcf
    type:
      - 'null'
      - boolean
    doc: Generate gvcf files
    inputBinding:
      position: 101
      prefix: --gvcf
  - id: mapper
    type:
      - 'null'
      - type: array
        items: string
    doc: Mapper algorithm to use while aligning reads. This option can be used 
      multiple times. Options = ['bwa', 'bwa2', 'bowtie2']
    inputBinding:
      position: 101
      prefix: --mapper
  - id: msi
    type:
      - 'null'
      - boolean
    doc: Run microsatellite instability analysis
    inputBinding:
      position: 101
      prefix: --msi
  - id: normal_sample
    type:
      - 'null'
      - File
    doc: Path to normal sample
    inputBinding:
      position: 101
      prefix: --normal_sample
  - id: normal_sample_name
    type:
      - 'null'
      - string
    doc: Sample name of germline to write in bam. Default is 'normal'
    inputBinding:
      position: 101
      prefix: --normal_sample_name
  - id: tumor_sample
    type:
      - 'null'
      - type: array
        items: string
    doc: Path to tumor sample. This option can be used multiple times.
    inputBinding:
      position: 101
      prefix: --tumor_sample
  - id: tumor_sample_name
    type:
      - 'null'
      - string
    doc: Sample name of tumor to write in bam. Default is 'tumor'
    inputBinding:
      position: 101
      prefix: --tumor_sample_name
  - id: variant_caller
    type:
      - 'null'
      - type: array
        items: string
    doc: Variant caller algorithm to use for variant detection. This option can 
      be used multiple times, Options = ['mutect2','varscan2','haplotype 
      caller','octopus','strelka','somaticsniper','vardict', 'deepvariant']
    inputBinding:
      position: 101
      prefix: --variant_caller
  - id: workdir
    type: Directory
    doc: Directory that outputs will be saved
    inputBinding:
      position: 101
      prefix: --workdir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cosap:0.1.0--pyh026a95a_0
stdout: cosap.out
