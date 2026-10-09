cwlVersion: v1.2
class: CommandLineTool
baseCommand: LDBlockShow
label: ldblockshow
doc: "A fast and convenient tool for Linkage Disequilibrium (LD) visualization and LD block analysis.\n\nTool homepage: https://github.com/BGI-shenzhen/LDBlockShow"
inputs:
  - id: in_vcf
    type: File
    doc: 'Input SNP VCF format file'
    inputBinding:
      position: 1
      prefix: -InVCF
  - id: output_prefix_path
    type: string
    doc: 'Output file directory and prefix of the output files (e.g. out)'
    inputBinding:
      position: 1
      prefix: -OutPut
  - id: region
    type:
      - 'null'
      - string
    doc: 'Region to show the LD heatmap (format chr:start:end)'
    inputBinding:
      position: 1
      prefix: -Region
  - id: sele_var
    type:
      - 'null'
      - int
    doc: "LD statistic: 1 = D', 2 = R^2, 3/4 = both (default 1)"
    inputBinding:
      position: 1
      prefix: -SeleVar
  - id: sub_pop
    type:
      - 'null'
      - File
    doc: 'Sample list file for a subgroup analysis (default all samples)'
    inputBinding:
      position: 1
      prefix: -SubPop
  - id: block_type
    type:
      - 'null'
      - int
    doc: 'Method to detect blocks: 1 = PLINK Gabriel method, 2 = solid spine of LD, 3 = self-defined cutoff (-BlockCut), 4 = fixed blocks (-FixBlock), 5 = no blocks (default 1)'
    inputBinding:
      position: 1
      prefix: -BlockType
  - id: in_gwas
    type:
      - 'null'
      - File
    doc: 'GWAS p-value file (chr position Pvalue) plotted with the LD heatmap'
    inputBinding:
      position: 1
      prefix: -InGWAS
  - id: in_gff
    type:
      - 'null'
      - File
    doc: 'GFF3 file to show gene CDS and gene names'
    inputBinding:
      position: 1
      prefix: -InGFF
  - id: block_cut
    type:
      - 'null'
      - string
    doc: 'Strong-LD cutoff and ratio for block type 3 (default 0.85:0.90)'
    inputBinding:
      position: 1
      prefix: -BlockCut
  - id: fix_block
    type:
      - 'null'
      - File
    doc: 'File with fixed block regions (chromosome, start, end) for block type 4'
    inputBinding:
      position: 1
      prefix: -FixBlock
  - id: mer_min_snp_num
    type:
      - 'null'
      - int
    doc: 'Merge colour grids when the SNP number is over N (default 50)'
    inputBinding:
      position: 1
      prefix: -MerMinSNPNum
  - id: in_genotype
    type:
      - 'null'
      - File
    doc: 'Input SNP genotype format file'
    inputBinding:
      position: 1
      prefix: -InGenotype
  - id: in_plink
    type:
      - 'null'
      - string
    doc: 'Prefix of the input PLINK files (bed+bim+fam or ped+map); give the files in plink_files'
    inputBinding:
      position: 1
      prefix: -InPlink
  - id: maf
    type:
      - 'null'
      - float
    doc: 'Minimum minor allele frequency filter (default 0.05)'
    inputBinding:
      position: 1
      prefix: -MAF
  - id: miss
    type:
      - 'null'
      - float
    doc: 'Maximum ratio of missing alleles filter (default 0.25)'
    inputBinding:
      position: 1
      prefix: -Miss
  - id: hwe
    type:
      - 'null'
      - float
    doc: 'Exact test of Hardy-Weinberg equilibrium p-value filter (default 0)'
    inputBinding:
      position: 1
      prefix: -HWE
  - id: het
    type:
      - 'null'
      - float
    doc: 'Maximum ratio of heterozygous alleles filter (default 1.00)'
    inputBinding:
      position: 1
      prefix: -Het
  - id: enable_oth_var
    type:
      - 'null'
      - boolean
    doc: 'Allow bi-allelic indel, SV, CNV and other variants'
    inputBinding:
      position: 1
      prefix: -EnableOthVar
  - id: tag_snp_cut
    type:
      - 'null'
      - float
    doc: 'Strong-LD cutoff for tag SNPs (default 0.80)'
    inputBinding:
      position: 1
      prefix: -TagSNPCut
  - id: out_png
    type:
      - 'null'
      - boolean
    doc: 'Convert the SVG figure to a PNG file'
    inputBinding:
      position: 1
      prefix: -OutPng
  - id: out_pdf
    type:
      - 'null'
      - boolean
    doc: 'Convert the SVG figure to a PDF file'
    inputBinding:
      position: 1
      prefix: -OutPdf
  - id: plink_files
    type:
      - 'null'
      - type: array
        items: File
    doc: PLINK files (bed, bim, fam or ped, map) staged next to the -InPlink prefix
outputs:
  - id: output_files
    type:
      type: array
      items: File
    doc: LD result files (.site.gz, .blocks.gz, .TriangleV.gz, .svg and, when requested, .png and .pdf)
    outputBinding:
      glob: $(inputs.output_prefix_path).*
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: "$(inputs.plink_files ? inputs.plink_files : [])"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ldblockshow:1.41--pl5321h077b44d_0
