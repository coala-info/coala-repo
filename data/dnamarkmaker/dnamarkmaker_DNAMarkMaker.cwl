cwlVersion: v1.2
class: CommandLineTool
baseCommand: DNAMarkMaker
label: dnamarkmaker_DNAMarkMaker
doc: "DNAMarkMaker version 1.0\n\nTool homepage: https://github.com/SegawaTenta/DNAMarkMaker-CUI"
inputs:
  - id: a_bam
    type:
      - 'null'
      - File
    doc: Full path of A bam
    inputBinding:
      position: 101
      prefix: --Abam
  - id: a_name
    type:
      - 'null'
      - string
    doc: A name (A)
    inputBinding:
      position: 101
      prefix: --Aname
  - id: b_bam
    type:
      - 'null'
      - File
    doc: Full path of B bam
    inputBinding:
      position: 101
      prefix: --Bbam
  - id: b_hetero
    type:
      - 'null'
      - string
    doc: Whether to target heterozygous SNP in B
    default: no
    inputBinding:
      position: 101
      prefix: --Bhetero
  - id: b_name
    type:
      - 'null'
      - string
    doc: B name (B)
    inputBinding:
      position: 101
      prefix: --Bname
  - id: b_sim
    type:
      - 'null'
      - string
    doc: B simulation file
    inputBinding:
      position: 101
      prefix: --Bsim
  - id: c_bam
    type:
      - 'null'
      - File
    doc: Full path of C bam
    inputBinding:
      position: 101
      prefix: --Cbam
  - id: c_sim
    type:
      - 'null'
      - string
    doc: C simulation file
    inputBinding:
      position: 101
      prefix: --Csim
  - id: first_size
    type:
      - 'null'
      - string
    doc: Size of first band
    default: 100:500
    inputBinding:
      position: 101
      prefix: --first_size
  - id: fragment_min_size
    type:
      - 'null'
      - int
    doc: Minimum fragment size of restricted PCR product
    default: 200
    inputBinding:
      position: 101
      prefix: --fragment_min_size
  - id: make_html
    type:
      - 'null'
      - string
    doc: Whether to html file
    default: yes
    inputBinding:
      position: 101
      prefix: --make_html
  - id: max_depth
    type:
      - 'null'
      - int
    doc: Maximum depth of target SNP
    default: 99
    inputBinding:
      position: 101
      prefix: --max_depth
  - id: min_bq
    type:
      - 'null'
      - int
    doc: Minimum base quality detected from bam
    default: 13
    inputBinding:
      position: 101
      prefix: --minBQ
  - id: min_depth
    type:
      - 'null'
      - int
    doc: Minimum depth of target SNP
    default: 10
    inputBinding:
      position: 101
      prefix: --min_depth
  - id: min_mq
    type:
      - 'null'
      - int
    doc: Minimum mapping quality detected from bam
    default: 0
    inputBinding:
      position: 101
      prefix: --minMQ
  - id: pcr_max_size
    type:
      - 'null'
      - int
    doc: Maximum size of PCR product
    default: 1000 or 700
    inputBinding:
      position: 101
      prefix: --PCR_max_size
  - id: pcr_min_size
    type:
      - 'null'
      - int
    doc: Minimum size of PCR product
    default: 500 or 100
    inputBinding:
      position: 101
      prefix: --PCR_min_size
  - id: position
    type:
      - 'null'
      - string
    doc: Target chromosome position [chr:start:end]
    default: chr:start:end
    inputBinding:
      position: 101
      prefix: --position
  - id: recipe
    type:
      - 'null'
      - File
    doc: Full path of primer recipe file
    inputBinding:
      position: 101
      prefix: --recipe
  - id: reference
    type:
      - 'null'
      - File
    doc: Full path of reference fasta
    inputBinding:
      position: 101
      prefix: --reference
  - id: restriction_enzyme
    type:
      - 'null'
      - File
    doc: Full path of restriction enzyme file
    inputBinding:
      position: 101
      prefix: --restriction_enzyme
  - id: second_size
    type:
      - 'null'
      - string
    doc: Size of second band
    default: 600:1000
    inputBinding:
      position: 101
      prefix: --second_size
  - id: snp_dist
    type:
      - 'null'
      - string
    doc: Target SNP distance
    default: 100:300
    inputBinding:
      position: 101
      prefix: --SNP_dist
  - id: work
    type: string
    doc: Choose between target_SNP_selection, CAPS, ARMS_preparation, tri_ARMS 
      and tetra_ARMS
    inputBinding:
      position: 101
      prefix: --work
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dnamarkmaker:1.0--pyhdfd78af_0
