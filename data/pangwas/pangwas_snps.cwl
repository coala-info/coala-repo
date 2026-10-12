cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pangwas
  - snps
label: pangwas_snps
doc: "Extract SNPs from a pangenome alignment.\n\nTakes as input the pangenome alignment fasta, bed, and consensus file from align.\nOutputs an Rtab file of SNPs.\n\nTool homepage: https://github.com/phac-nml/pangwas"
inputs:
  - id: alignment
    type: File
    doc: "Fasta sequences alignment."
    inputBinding:
      position: 101
      prefix: --alignment
  - id: bed
    type: File
    doc: "Bed file of coordinates."
    inputBinding:
      position: 101
      prefix: --bed
  - id: consensus
    type: File
    doc: "Fasta consensus/representative sequence."
    inputBinding:
      position: 101
      prefix: --consensus
  - id: structural
    type:
      - 'null'
      - File
    doc: "Rtab from the structural subcommand, used to avoid treating terminal ends as indels."
    inputBinding:
      position: 101
      prefix: --structural
  - id: outdir
    type:
      - 'null'
      - string
    doc: "Output directory. (default: . )"
    inputBinding:
      position: 101
      prefix: --outdir
  - id: prefix
    type:
      - 'null'
      - string
    doc: "Prefix for output files."
    inputBinding:
      position: 101
      prefix: --prefix
  - id: core
    type:
      - 'null'
      - float
    doc: "Core threshold for calling core SNPs. (default: 0.95)"
    inputBinding:
      position: 101
      prefix: --core
  - id: indel_window
    type:
      - 'null'
      - int
    doc: "Exclude SNPs that are within this proximity to indels. (default: 0)"
    inputBinding:
      position: 101
      prefix: --indel-window
  - id: snp_window
    type:
      - 'null'
      - int
    doc: "Exclude SNPs that are within this proximity to another SNP. (default: 0)"
    inputBinding:
      position: 101
      prefix: --snp-window
outputs:
  - id: snps_rtab
    type: File
    doc: "Rtab file of SNPs"
    outputBinding:
      glob: "$((inputs.outdir ? inputs.outdir + '/' : '') + (inputs.prefix ? inputs.prefix + '.' : '') + 'snps.Rtab')"
  - id: all_alignment
    type:
      - 'null'
      - File
    doc: "Alignment of all SNP sites"
    outputBinding:
      glob: "$((inputs.outdir ? inputs.outdir + '/' : '') + (inputs.prefix ? inputs.prefix + '.' : '') + 'snps.all.fasta')"
  - id: core_alignment
    type:
      - 'null'
      - File
    doc: "Alignment of core SNP sites"
    outputBinding:
      glob: "$((inputs.outdir ? inputs.outdir + '/' : '') + (inputs.prefix ? inputs.prefix + '.' : '') + 'snps.core.fasta')"
  - id: constant_sites
    type:
      - 'null'
      - File
    doc: "Constant sites for ascertainment bias correction"
    outputBinding:
      glob: "$((inputs.outdir ? inputs.outdir + '/' : '') + (inputs.prefix ? inputs.prefix + '.' : '') + 'snps.constant_sites.txt')"
  - id: all_tsv
    type:
      - 'null'
      - File
    doc: "Table of all SNPs"
    outputBinding:
      glob: "$((inputs.outdir ? inputs.outdir + '/' : '') + (inputs.prefix ? inputs.prefix + '.' : '') + 'snps.all.tsv')"
  - id: core_tsv
    type:
      - 'null'
      - File
    doc: "Table of core SNPs"
    outputBinding:
      glob: "$((inputs.outdir ? inputs.outdir + '/' : '') + (inputs.prefix ? inputs.prefix + '.' : '') + 'snps.core.tsv')"
  - id: all_vcf
    type:
      - 'null'
      - File
    doc: "VCF of all SNPs"
    outputBinding:
      glob: "$((inputs.outdir ? inputs.outdir + '/' : '') + (inputs.prefix ? inputs.prefix + '.' : '') + 'snps.all.vcf')"
  - id: core_vcf
    type:
      - 'null'
      - File
    doc: "VCF of core SNPs"
    outputBinding:
      glob: "$((inputs.outdir ? inputs.outdir + '/' : '') + (inputs.prefix ? inputs.prefix + '.' : '') + 'snps.core.vcf')"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pangwas:0.1.0--pyh7e72e81_0
