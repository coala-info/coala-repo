cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cnvkit.py
  - export
  - bed
label: cnvkit_export_bed
doc: "Convert segments to BED format. Input is a segmentation file (.cns) where, preferably, log2 ratios have already been adjusted to integer absolute values using the 'call' command.\n\nTool homepage: https://github.com/etal/cnvkit"
inputs:
  - id: segments
    type:
      type: array
      items: File
    doc: "Segmented copy ratio data files (*.cns), the output of the 'segment' or 'call' sub-commands."
    inputBinding:
      position: 1
  - id: sample_id
    type:
      - 'null'
      - string
    doc: "Identifier to write in the 4th column of the BED file. [Default: use the sample ID, taken from the file name]"
    inputBinding:
      position: 101
      prefix: --sample-id
  - id: label_genes
    type:
      - 'null'
      - boolean
    doc: "Show gene names in the 4th column of the BED file. (This is a bad idea if >1 input files are given.)"
    inputBinding:
      position: 101
      prefix: --label-genes
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
  - id: show
    type:
      - 'null'
      - string
    doc: "Which segmented regions to show: 'all' = all segment regions; 'variant' = CNA regions with non-neutral copy number; 'ploidy' = CNA regions with non-default ploidy. [Default: ploidy] (choices: ploidy, variant, all)"
    inputBinding:
      position: 101
      prefix: --show
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
