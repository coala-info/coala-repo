cwlVersion: v1.2
class: CommandLineTool
baseCommand: sgcocaller
label: sgcocaller_xo
doc: "sgcocaller xo [options] <BAM> <VCF> <barcodeFile> <out_prefix>\n\nTool homepage:
  https://gitlab.svi.edu.au/biocellgen-public/sgcocaller"
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
  - id: barcode_tag
    type:
      - 'null'
      - string
    doc: the cell barcode tag in BAM
    inputBinding:
      position: 105
      prefix: --barcodeTag
  - id: baseq
    type:
      - 'null'
      - int
    doc: base quality threshold for a base to be used for counting
    inputBinding:
      position: 105
      prefix: --baseq
  - id: batch_size
    type:
      - 'null'
      - int
    doc: the number of cells to process in one batch when running sxo. This 
      option is only needed when the memory is limited.
    inputBinding:
      position: 105
      prefix: --batchSize
  - id: bin_size
    type:
      - 'null'
      - int
    doc: the size of SNP bins for scanning swith errors, users are recommended 
      to increase this option when SNP density is high.
    inputBinding:
      position: 105
      prefix: --binSize
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
  - id: dissim_thresh
    type:
      - 'null'
      - float
    doc: the threshold used on the allele concordance ratio for determining if a
      SNP bin contains a crossover.
    inputBinding:
      position: 105
      prefix: --dissimThresh
  - id: look_beyond_snps
    type:
      - 'null'
      - int
    doc: the number of local SNPs to use when finding switch positions
    inputBinding:
      position: 105
      prefix: --lookBeyondSnps
  - id: max_dissim
    type:
      - 'null'
      - float
    doc: the maximum dissimilarity for a pair of cell to be selected as 
      potential template cells due to not having crossovers in either cell
    inputBinding:
      position: 105
      prefix: --maxDissim
  - id: max_dp
    type:
      - 'null'
      - int
    doc: the maximum DP for a SNP to be included in the output file
    inputBinding:
      position: 105
      prefix: --maxDP
  - id: max_expand
    type:
      - 'null'
      - int
    doc: the maximum number of iterations to look for locally coexisting 
      positions for inferring missing SNPs in template haplotype sequence
    inputBinding:
      position: 105
      prefix: --maxExpand
  - id: max_total_dp
    type:
      - 'null'
      - int
    doc: the maximum DP across all barcodes for a SNP to be included in the 
      output file
    inputBinding:
      position: 105
      prefix: --maxTotalDP
  - id: max_use_ncells
    type:
      - 'null'
      - int
    doc: the number of cells to use for calculating switch scores. All cells are
      used if not set
    inputBinding:
      position: 105
      prefix: --maxUseNcells
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
  - id: min_positive_switch_scores
    type:
      - 'null'
      - int
    doc: the min number of continuing SNPs with positive switch scores to do 
      switch error correction
    inputBinding:
      position: 105
      prefix: --minPositiveSwitchScores
  - id: min_snp_depth
    type:
      - 'null'
      - int
    doc: the minimum depth of cell coverage for a SNP to be includes in 
      generated genotype matrix file
    inputBinding:
      position: 105
      prefix: --minSNPdepth
  - id: min_switch_score
    type:
      - 'null'
      - float
    doc: the minimum switch score for a site to be identified as having a switch
      error in the inferred haplotype
    inputBinding:
      position: 105
      prefix: --minSwitchScore
  - id: min_total_dp
    type:
      - 'null'
      - int
    doc: the minimum DP across all barcodes for a SNP to be included in the 
      output file
    inputBinding:
      position: 105
      prefix: --minTotalDP
  - id: not_sort_mtx
    type:
      - 'null'
      - boolean
    doc: do not sort the output mtx.
    inputBinding:
      position: 105
      prefix: --notSortMtx
  - id: outvcf
    type:
      - 'null'
      - boolean
    doc: generate the output in vcf format (sgcocaller phase)
    inputBinding:
      position: 105
      prefix: --outvcf
  - id: phased
    type:
      - 'null'
      - boolean
    doc: the input VCF for calling crossovers contains the phased GT of 
      heterozygous SNPs
    inputBinding:
      position: 105
      prefix: --phased
  - id: posterior_prob_min
    type:
      - 'null'
      - float
    doc: the min posterior probability for inferring missing SNPs
    inputBinding:
      position: 105
      prefix: --posteriorProbMin
  - id: step_size
    type:
      - 'null'
      - int
    doc: the move step size used in combination with --binSize.
    inputBinding:
      position: 105
      prefix: --stepSize
  - id: template_cell
    type:
      - 'null'
      - int
    doc: the cell's genotype to be used a template cell, as the cell's index 
      (0-starting) in the barcode file, default as not supplied
    inputBinding:
      position: 105
      prefix: --templateCell
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
    dockerPull: quay.io/biocontainers/sgcocaller:0.3.9--hda81887_2
stdout: sgcocaller_xo.out
