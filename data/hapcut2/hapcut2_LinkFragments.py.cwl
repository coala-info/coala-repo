cwlVersion: v1.2
class: CommandLineTool
baseCommand: LinkFragments.py
label: hapcut2_LinkFragments.py
doc: "Link the fragments of 10X linked reads into molecules. Input is the unlinked fragment file made by extractHAIRS with --10X 1; output is the linked fragment file for HAPCUT2.\n\nTool homepage: https://github.com/vibansal/HapCUT2/"
inputs:
  - id: fragments
    type: File
    doc: file with unlinked hapcut2 fragments (generate using --10X 1 option
      in extractHAIRS)
    inputBinding:
      position: 1
      prefix: --fragments
  - id: vcf
    type: File
    doc: vcf file for phasing
    inputBinding:
      position: 2
      prefix: --VCF
  - id: bam_file
    type: File
    doc: bam file with barcoded reads
    secondaryFiles:
      - pattern: .bai
        required: false
    inputBinding:
      position: 3
      prefix: --bam_file
  - id: outfile_path
    type: string
    doc: output file with linked fragments
    inputBinding:
      position: 4
      prefix: --outfile
  - id: distance
    type:
      - 'null'
      - int
    doc: distance in base pairs that delineates separate 10X molecules,
      default=20kb
    inputBinding:
      position: 5
      prefix: --distance
  - id: maxbq
    type:
      - 'null'
      - int
    doc: maximum base quality for an allele call, default=40
    inputBinding:
      position: 6
      prefix: --maxbq
  - id: use_tag
    type:
      - 'null'
      - boolean
    doc: use molecule tag (MI) to separate between molecules
    inputBinding:
      position: 7
      prefix: --use-tag
  - id: single_snp_frags
    type:
      - 'null'
      - boolean
    doc: whether to keep fragments overlapping only one SNP
    inputBinding:
      position: 8
      prefix: --single_SNP_frags
outputs:
  - id: outfile
    type: File
    doc: output file with linked fragments
    outputBinding:
      glob: $(inputs.outfile_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hapcut2:1.3.4--h7e4f606_2
