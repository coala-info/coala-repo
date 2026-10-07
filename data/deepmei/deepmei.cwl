cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - deepmei
label: deepmei
doc: "DeepMEI: detect mobile element insertions (MEIs) from short-read BAM or CRAM
  files aligned to GRCh38, GRCh37 or hg19.\n\nTool homepage: https://github.com/Kanglu123/deepmei"
inputs:
  - id: bam_file
    type: File
    doc: input bam file or cram file full path, required
    secondaryFiles:
      - pattern: .bai
        required: false
      - pattern: ^.bai
        required: false
      - pattern: .crai
        required: false
    inputBinding:
      position: 1
      prefix: -i
  - id: reference
    type: File
    doc: reference full path, required (with .fai, .dict and bwa index files)
    secondaryFiles:
      - pattern: .fai
        required: false
      - pattern: ^.dict
        required: false
      - pattern: .dict
        required: false
      - pattern: .amb
        required: false
      - pattern: .ann
        required: false
      - pattern: .bwt
        required: false
      - pattern: .pac
        required: false
      - pattern: .sa
        required: false
    inputBinding:
      position: 1
      prefix: -r
  - id: me_reference
    type:
      - 'null'
      - File
    doc: mobile elements reference, optional
    inputBinding:
      position: 1
      prefix: -m
  - id: genotype_bed
    type:
      - 'null'
      - File
    doc: input genotype file, optional
    inputBinding:
      position: 1
      prefix: -b
  - id: quick_model
    type:
      - 'null'
      - int
    doc: quick model, optional
    inputBinding:
      position: 1
      prefix: -q
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: output prefix, optional,default is bam name
    inputBinding:
      position: 1
      prefix: -o
  - id: docker
    type:
      - 'null'
      - string
    doc: only avaliable in docker images, optional
    inputBinding:
      position: 1
      prefix: -v
  - id: output_dir
    type: string
    doc: output directory, required
    default: deepmei_out
    inputBinding:
      position: 1
      prefix: -w
  - id: depth
    type:
      - 'null'
      - int
    doc: sequencing depth, default is 25, optional
    inputBinding:
      position: 1
      prefix: -d
  - id: clean
    type:
      - 'null'
      - int
    doc: clean temp files[-c 1], optional but recommended
    inputBinding:
      position: 1
      prefix: -c
  - id: joint
    type:
      - 'null'
      - int
    doc: joint genotyping,optional
    inputBinding:
      position: 1
      prefix: -j
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output
    type: Directory
    doc: Output folder (<output_dir>/DeepMEI_output/<prefix>) with the MEI VCF, BED 
      files and supporting BAM
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deepmei:1.6.24--hdfd78af_1
stdout: deepmei.out
