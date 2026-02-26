cwlVersion: v1.2
class: CommandLineTool
baseCommand: modcall
label: longphase_modcall
doc: "modcall\n\nTool homepage: https://github.com/twolinin/longphase"
inputs:
  - id: reads_file
    type: File
    doc: modified sorted bam file.
    inputBinding:
      position: 1
  - id: all
    type:
      - 'null'
      - boolean
    doc: output all coordinates where modifications have been detected.
    inputBinding:
      position: 102
      prefix: --all
  - id: bam_file
    type: File
    doc: modified sorted bam file.
    inputBinding:
      position: 102
      prefix: --bam-file
  - id: connectAdjacent
    type:
      - 'null'
      - int
    doc: connect adjacent N METHs.
    default: 6
    inputBinding:
      position: 102
      prefix: --connectAdjacent
  - id: connectConfidence
    type:
      - 'null'
      - float
    doc: determine the confidence of phasing two ASMs. higher threshold requires
      greater consistency in the reads.
    default: 0.9
    inputBinding:
      position: 102
      prefix: --connectConfidence
  - id: heterRatio
    type:
      - 'null'
      - float
    doc: modified and unmodified scales. a higher threshold means that the two 
      quantities need to be closer.
    default: 0.7
    inputBinding:
      position: 102
      prefix: --heterRatio
  - id: modThreshold
    type:
      - 'null'
      - float
    doc: value extracted from MM tag and ML tag. above the threshold means 
      modification occurred.
    default: 0.8
    inputBinding:
      position: 102
      prefix: --modThreshold
  - id: noiseRatio
    type:
      - 'null'
      - float
    doc: not being judged as modified and unmodified is noise. higher threshold 
      means lower noise needs.
    default: 0.2
    inputBinding:
      position: 102
      prefix: --noiseRatio
  - id: out_prefix
    type:
      - 'null'
      - string
    doc: prefix of phasing result.
    default: modcall_result
    inputBinding:
      position: 102
      prefix: --out-prefix
  - id: reference
    type: File
    doc: reference fasta.
    inputBinding:
      position: 102
      prefix: --reference
  - id: snp_file
    type:
      - 'null'
      - File
    doc: input SNP vcf file.
    inputBinding:
      position: 102
      prefix: --snp-file
  - id: threads
    type:
      - 'null'
      - int
    doc: number of thread.
    default: 1
    inputBinding:
      position: 102
      prefix: --threads
  - id: unModThreshold
    type:
      - 'null'
      - float
    doc: value extracted from MM tag and ML tag. above the threshold means no 
      modification occurred.
    default: 0.2
    inputBinding:
      position: 102
      prefix: --unModThreshold
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/longphase:2.0.1--hfc4162c_0
stdout: longphase_modcall.out
