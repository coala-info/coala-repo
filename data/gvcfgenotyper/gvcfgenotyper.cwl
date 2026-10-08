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
  - id: gvcf_files
    type:
      type: array
      items: File
    doc: The gVCF files named in the list file. They are staged in the working
      directory so the names in the list resolve.
    secondaryFiles:
      - pattern: .tbi
        required: false
      - pattern: .csi
        required: false
  - id: log_file
    type:
      - 'null'
      - string
    doc: logging information
    inputBinding:
      position: 101
      prefix: --log-file
  - id: max_alleles
    type:
      - 'null'
      - int
    doc: maximum number of alleles
    inputBinding:
      position: 101
      prefix: --max-alleles
  - id: output_type
    type:
      - 'null'
      - string
    doc: 'b: compressed BCF, u: uncompressed BCF, z: compressed VCF, v: uncompressed
      VCF'
    inputBinding:
      position: 101
      prefix: --output-type
  - id: reference_fasta
    type: File
    doc: reference sequence
    secondaryFiles:
      - .fai
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
  - id: output_file_path
    type: string
    doc: output file name [stdout]
    inputBinding:
      position: 102
      prefix: --output-file
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: output file name
    outputBinding:
      glob: $(inputs.output_file_path)
  - id: log_output
    type:
      - 'null'
      - File
    doc: logging information file
    outputBinding:
      glob: $(inputs.log_file)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: $(inputs.gvcf_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gvcfgenotyper:2019.02.26--h13024bc_6
