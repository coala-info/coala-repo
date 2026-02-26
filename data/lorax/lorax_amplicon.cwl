cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - lorax
  - amplicon
label: lorax_amplicon
doc: "Amplicon analysis tool\n\nTool homepage: https://github.com/tobiasrausch/lorax"
inputs:
  - id: tumor_bam
    type: File
    doc: tumor BAM file
    inputBinding:
      position: 1
  - id: bedfile
    type: File
    doc: amplicon regions in BED format
    inputBinding:
      position: 102
      prefix: --bedfile
  - id: breakpoint_uncertainty
    type:
      - 'null'
      - int
    doc: breakpoint uncertainty (in bp)
    default: 1000
    inputBinding:
      position: 102
      prefix: --uncertain
  - id: coverage_window_length
    type:
      - 'null'
      - int
    doc: coverage window length
    default: 1000
    inputBinding:
      position: 102
      prefix: --wincov
  - id: genome
    type: File
    doc: genome fasta file
    inputBinding:
      position: 102
      prefix: --genome
  - id: min_clipping_length
    type:
      - 'null'
      - int
    doc: min. clipping length
    default: 100
    inputBinding:
      position: 102
      prefix: --minclip
  - id: min_sequence_quality
    type:
      - 'null'
      - int
    doc: min. sequence quality
    default: 10
    inputBinding:
      position: 102
      prefix: --quality
  - id: outprefix
    type:
      - 'null'
      - string
    doc: output prefix
    default: out
    inputBinding:
      position: 102
      prefix: --outprefix
  - id: ploidy
    type:
      - 'null'
      - int
    doc: ploidy
    default: 2
    inputBinding:
      position: 102
      prefix: --ploidy
  - id: sample_name
    type:
      - 'null'
      - string
    doc: sample name (as in VCF/BCF file)
    default: NA12878
    inputBinding:
      position: 102
      prefix: --sample
  - id: vcffile
    type: File
    doc: input VCF/BCF file
    inputBinding:
      position: 102
      prefix: --vcffile
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lorax:0.5.1--h4d20210_0
stdout: lorax_amplicon.out
