cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - alfred
  - ase
label: alfred_ase
doc: "Allele-specific expression analysis using alfred\n\nTool homepage: https://github.com/tobiasrausch/alfred"
inputs:
  - id: input_bam
    type: File
    doc: Input BAM file
    inputBinding:
      position: 1
  - id: base_qual
    type:
      - 'null'
      - int
    doc: min. base quality
    default: 10
    inputBinding:
      position: 102
      prefix: --base-qual
  - id: full
    type:
      - 'null'
      - boolean
    doc: output all het. input SNPs
    inputBinding:
      position: 102
      prefix: --full
  - id: map_qual
    type:
      - 'null'
      - int
    doc: min. mapping quality
    default: 10
    inputBinding:
      position: 102
      prefix: --map-qual
  - id: phased
    type:
      - 'null'
      - boolean
    doc: BCF file is phased and BAM is haplo-tagged
    inputBinding:
      position: 102
      prefix: --phased
  - id: reference
    type: File
    doc: reference fasta file
    inputBinding:
      position: 102
      prefix: --reference
  - id: sample
    type:
      - 'null'
      - string
    doc: sample name
    default: NA12878
    inputBinding:
      position: 102
      prefix: --sample
  - id: vcffile
    type: File
    doc: input (phased) BCF file
    inputBinding:
      position: 102
      prefix: --vcffile
outputs:
  - id: ase_output
    type:
      - 'null'
      - File
    doc: allele-specific output file
    outputBinding:
      glob: $(inputs.ase_output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/alfred:0.5.1--h4d20210_0
