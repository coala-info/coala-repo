cwlVersion: v1.2
class: CommandLineTool
baseCommand: gvcfgenotyper
label: gvcfgenotyper
doc: "GVCF merging and genotyping for Illumina GVCFs\n\nTool homepage: https://github.com/Illumina/gvcfgenotyper"
inputs:
  - id: gvcf_list
    type: File
    doc: plain text list of gvcfs to merge
    inputBinding:
      position: 101
      prefix: --list
  - id: log_file
    type:
      - 'null'
      - File
    doc: logging information
    inputBinding:
      position: 101
      prefix: --log-file
  - id: max_alleles
    type:
      - 'null'
      - int
    doc: maximum number of alleles
    default: 50
    inputBinding:
      position: 101
      prefix: --max-alleles
  - id: output_type
    type:
      - 'null'
      - string
    doc: 'b: compressed BCF, u: uncompressed BCF, z: compressed VCF, v: uncompressed
      VCF'
    default: v
    inputBinding:
      position: 101
      prefix: --output-type
  - id: reference_fasta
    type: File
    doc: reference sequence
    inputBinding:
      position: 101
      prefix: --fasta-ref
  - id: region
    type:
      - 'null'
      - string
    doc: region to genotype eg. chr1 or chr20:5000000-6000000
    inputBinding:
      position: 101
      prefix: --region
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: output file name
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gvcfgenotyper:2019.02.26--h13024bc_6
