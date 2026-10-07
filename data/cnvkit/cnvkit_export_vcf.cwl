cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cnvkit.py
  - export
  - vcf
label: cnvkit_export_vcf
doc: "Convert segments to VCF format. Input is a segmentation file (.cns) where, preferably, log2 ratios have already been adjusted to integer absolute values using the 'call' command.\n\nTool homepage: https://github.com/etal/cnvkit"
inputs:
  - id: segments
    type: File
    doc: "Segmented copy ratio data file (*.cns), the output of the 'segment' or 'call' sub-commands."
    inputBinding:
      position: 1
  - id: cnr
    type:
      - 'null'
      - File
    doc: "Bin-level copy ratios (*.cnr). Used to indicate fuzzy boundaries for segments in the output VCF via the CIPOS and CIEND tags."
    inputBinding:
      position: 101
      prefix: --cnr
  - id: sample_id
    type:
      - 'null'
      - string
    doc: "Sample name to write in the genotype field of the output VCF file. [Default: use the sample ID, taken from the file name]"
    inputBinding:
      position: 101
      prefix: --sample-id
  - id: ploidy
    type:
      - 'null'
      - int
    doc: "Ploidy of the sample cells. [Default: %(default)d]"
    inputBinding:
      position: 101
      prefix: --ploidy
  - id: sample_sex
    type:
      - 'null'
      - string
    doc: "Specify the sample's chromosomal sex as male or female. (Otherwise guessed from X and Y coverage). (choices: m, y, male, Male, f, x, female, Female)"
    inputBinding:
      position: 101
      prefix: --sample-sex
  - id: male_reference
    type:
      - 'null'
      - boolean
    doc: "Was a male reference used? If so, expect half ploidy on chrX and chrY; otherwise, only chrY has half ploidy. In CNVkit, if a male reference was used, the \"neutral\" copy number (ploidy) of chrX is 1; chrY is haploid for either reference sex."
    inputBinding:
      position: 101
      prefix: --male-reference
  - id: output
    type: string
    doc: "Output file name."
    inputBinding:
      position: 101
      prefix: --output
  - id: diploid_parx_genome
    type:
      - 'null'
      - string
    doc: "Considers the given human genome's PAR of chromosome X as autosomal. Example: 'grch38'"
    inputBinding:
      position: 101
      prefix: --diploid-parx-genome
outputs:
  - id: output_out
    type:
      - 'null'
      - File
    doc: "Output file name."
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cnvkit:0.9.12--pyhdfd78af_1
