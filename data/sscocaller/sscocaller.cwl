cwlVersion: v1.2
class: CommandLineTool
baseCommand: sscocaller
label: sscocaller
doc: "Call SNPs in single-cell DNA sequencing data\n\nTool homepage: https://gitlab.svi.edu.au/biocellgen-public/sscocaller"
inputs:
  - id: bam
    type: File
    doc: the read alignment file with records of single-cell DNA reads
    inputBinding:
      position: 1
  - id: vcf
    type: File
    doc: the variant call file with records of SNPs
    inputBinding:
      position: 2
  - id: barcode_file
    type: File
    doc: the text file containing the list of cell barcodes
    inputBinding:
      position: 3
  - id: out_prefix
    type: string
    doc: the prefix of output files
    inputBinding:
      position: 4
  - id: baseq
    type:
      - 'null'
      - int
    doc: base quality threshold for a base to be used for counting
    inputBinding:
      position: 105
      prefix: --baseq
  - id: cellbarcode
    type:
      - 'null'
      - string
    doc: the cell barcode tag, by default it is CB
    inputBinding:
      position: 105
      prefix: --cellbarcode
  - id: chr_name
    type:
      - 'null'
      - string
    doc: the chr names with chr prefix or not, if not supplied then no prefix
    inputBinding:
      position: 105
      prefix: --chrName
  - id: chrom
    type:
      - 'null'
      - string
    doc: the selected chromsome (whole genome if not supplied,separate by comma 
      if multiple chroms)
    inputBinding:
      position: 105
      prefix: --chrom
  - id: cm_pmb
    type:
      - 'null'
      - float
    doc: the average centiMorgan distances per megabases default 0.1 cm per Mb
    inputBinding:
      position: 105
      prefix: --cmPmb
  - id: max_dp
    type:
      - 'null'
      - int
    doc: the maximum DP for a SNP to be included in the output file
    inputBinding:
      position: 105
      prefix: --maxDP
  - id: max_total_dp
    type:
      - 'null'
      - int
    doc: the maximum DP across all barcodes for a SNP to be included in the 
      output file
    inputBinding:
      position: 105
      prefix: --maxTotalDP
  - id: min_dp
    type:
      - 'null'
      - int
    doc: the minimum DP for a SNP to be included in the output file
    inputBinding:
      position: 105
      prefix: --minDP
  - id: min_mapq
    type:
      - 'null'
      - int
    doc: Minimum MAPQ for read filtering
    inputBinding:
      position: 105
      prefix: --minMAPQ
  - id: min_total_dp
    type:
      - 'null'
      - int
    doc: the minimum DP across all barcodes for a SNP to be included in the 
      output file
    inputBinding:
      position: 105
      prefix: --minTotalDP
  - id: theta_alt
    type:
      - 'null'
      - float
    doc: the theta for the binomial distribution conditioning on hidden state 
      being ALT
    inputBinding:
      position: 105
      prefix: --thetaALT
  - id: theta_ref
    type:
      - 'null'
      - float
    doc: the theta for the binomial distribution conditioning on hidden state 
      being REF
    inputBinding:
      position: 105
      prefix: --thetaREF
  - id: threads
    type:
      - 'null'
      - int
    doc: number of BAM decompression threads
    inputBinding:
      position: 105
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sscocaller:0.2.2--hda81887_4
stdout: sscocaller.out
