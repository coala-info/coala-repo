cwlVersion: v1.2
class: CommandLineTool
baseCommand: GTbarcode
label: vireosnp_GTbarcode
doc: "Select informative genotype variants (a genotype barcode) from a donor VCF file and plot them.\n\nTool homepage: https://github.com/huangyh09/vireoSNP"
inputs:
  - id: vcf_file
    type: File
    doc: The VCF file for genotype of samples
    inputBinding:
      position: 101
      prefix: --vcfFile
  - id: out_file
    type: string
    doc: "Output file, given with a directory part such as gtb/GTbarcode.tsv (the tool crashes on a bare file name because it creates the parent directory; the default location is next to the VCF file, which is read-only when staged)"
    inputBinding:
      position: 101
      prefix: --outFile
  - id: geno_tag
    type:
      - 'null'
      - string
    doc: 'The tag for donor genotype: GT, GP, PL [default: GT]'
    inputBinding:
      position: 101
      prefix: --genoTag
  - id: no_homo_alt
    type:
      - 'null'
      - boolean
    doc: Filter out variants with homozygous ALT.
    inputBinding:
      position: 101
      prefix: --noHomoAlt
  - id: no_plot
    type:
      - 'null'
      - boolean
    doc: Turn off the plot for the barcode.
    inputBinding:
      position: 101
      prefix: --noPlot
  - id: fig_size
    type:
      - 'null'
      - string
    doc: Size for the output figure, comma separated [default 4,2].
    inputBinding:
      position: 101
      prefix: --figSize
  - id: fig_format
    type:
      - 'null'
      - string
    doc: 'Format of output figure: png or pdf [default: png].'
    inputBinding:
      position: 101
      prefix: --figFormat
  - id: rand_seed
    type:
      - 'null'
      - int
    doc: "Seed for random pick variants with same information gain [default: none]"
    inputBinding:
      position: 101
      prefix: --randSeed
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: barcode_tsv
    type: File
    doc: Genotype barcode table
    outputBinding:
      glob: $(inputs.out_file)
  - id: figures
    type:
      type: array
      items: File
    doc: Barcode figure(s) written next to the output file
    outputBinding:
      glob: "${ return inputs.out_file.replace(/[^\\/]*$/, '') + '*.png'; }"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vireosnp:0.5.9--pyh7e72e81_0
stdout: vireosnp_GTbarcode.out
