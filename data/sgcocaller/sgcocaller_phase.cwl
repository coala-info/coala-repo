cwlVersion: v1.2
class: CommandLineTool
baseCommand: sgcocaller
label: sgcocaller_phase
doc: "sgcocaller phase command\n\nTool homepage: https://gitlab.svi.edu.au/biocellgen-public/sgcocaller"
inputs:
  - id: bam_file
    type: File
    doc: the read alignment file with records of single-cell DNA reads
    inputBinding:
      position: 1
  - id: gt_mtx_file
    type: File
    doc: the output gtMtx.mtx file from running sgcocaller phase
    inputBinding:
      position: 2
  - id: out_vcf_phased
    type: File
    doc: the output vcf aftering phasing blocks in hapfile
    inputBinding:
      position: 3
  - id: snp_phase_file
    type: File
    doc: SNPPhaseFile
    inputBinding:
      position: 4
  - id: phase_output_prefix
    type: string
    doc: phaseOutputPrefix
    inputBinding:
      position: 5
  - id: phased_snp_annot_file
    type: File
    doc: the output phased_snpAnnot.txt from running sgcocaller phase
    inputBinding:
      position: 6
  - id: vcf_file
    type: File
    doc: the variant call file with records of SNPs
    inputBinding:
      position: 7
  - id: barcode_file
    type: File
    doc: the text file containing the list of cell barcodes
    inputBinding:
      position: 8
  - id: reference_vcf
    type: File
    doc: the reference VCF
    inputBinding:
      position: 9
  - id: out_prefix
    type: string
    doc: the prefix of output files
    inputBinding:
      position: 10
  - id: barcode_tag
    type:
      - 'null'
      - string
    doc: the cell barcode tag in BAM
    inputBinding:
      position: 111
      prefix: --barcodeTag
  - id: baseq
    type:
      - 'null'
      - int
    doc: base quality threshold for a base to be used for counting
    inputBinding:
      position: 111
      prefix: --baseq
  - id: batch_size
    type:
      - 'null'
      - int
    doc: the number of cells to process in one batch when running sxo. This 
      option is only needed when the memory is limited.
    inputBinding:
      position: 111
      prefix: --batchSize
  - id: bin_size
    type:
      - 'null'
      - int
    doc: the size of SNP bins for scanning swith errors, users are recommended 
      to increase this option when SNP density is high.
    inputBinding:
      position: 111
      prefix: --binSize
  - id: chrom
    type:
      - 'null'
      - string
    doc: the selected chromsome (whole genome if not supplied,separate by comma 
      if multiple chroms)
    inputBinding:
      position: 111
      prefix: --chrom
  - id: cm_pmb
    type:
      - 'null'
      - float
    doc: the average centiMorgan distances per megabases default 0.1 cm per Mb
    inputBinding:
      position: 111
      prefix: --cmPmb
  - id: dissim_thresh
    type:
      - 'null'
      - float
    doc: the threshold used on the allele concordance ratio for determining if a
      SNP bin contains a crossover.
    inputBinding:
      position: 111
      prefix: --dissimThresh
  - id: look_beyond_snps
    type:
      - 'null'
      - int
    doc: the number of local SNPs to use when finding switch positions
    inputBinding:
      position: 111
      prefix: --lookBeyondSnps
  - id: max_dissim
    type:
      - 'null'
      - float
    doc: the maximum dissimilarity for a pair of cell to be selected as 
      potential template cells due to not having crossovers in either cell
    inputBinding:
      position: 111
      prefix: --maxDissim
  - id: max_dp
    type:
      - 'null'
      - int
    doc: the maximum DP for a SNP to be included in the output file
    inputBinding:
      position: 111
      prefix: --maxDP
  - id: max_expand
    type:
      - 'null'
      - int
    doc: the maximum number of iterations to look for locally coexisting 
      positions for inferring missing SNPs in template haplotype sequence
    inputBinding:
      position: 111
      prefix: --maxExpand
  - id: max_total_dp
    type:
      - 'null'
      - int
    doc: the maximum DP across all barcodes for a SNP to be included in the 
      output file
    inputBinding:
      position: 111
      prefix: --maxTotalDP
  - id: max_use_ncells
    type:
      - 'null'
      - int
    doc: the number of cells to use for calculating switch scores. All cells are
      used if not set
    inputBinding:
      position: 111
      prefix: --maxUseNcells
  - id: min_dp
    type:
      - 'null'
      - int
    doc: the minimum DP for a SNP to be included in the output file
    inputBinding:
      position: 111
      prefix: --minDP
  - id: min_mapq
    type:
      - 'null'
      - int
    doc: Minimum MAPQ for read filtering
    inputBinding:
      position: 111
      prefix: --minMAPQ
  - id: min_positive_switch_scores
    type:
      - 'null'
      - int
    doc: the min number of continuing SNPs with positive switch scores to do 
      switch error correction
    inputBinding:
      position: 111
      prefix: --minPositiveSwitchScores
  - id: min_snp_depth
    type:
      - 'null'
      - int
    doc: the minimum depth of cell coverage for a SNP to be includes in 
      generated genotype matrix file
    inputBinding:
      position: 111
      prefix: --minSNPdepth
  - id: min_switch_score
    type:
      - 'null'
      - float
    doc: the minimum switch score for a site to be identified as having a switch
      error in the inferred haplotype
    inputBinding:
      position: 111
      prefix: --minSwitchScore
  - id: min_total_dp
    type:
      - 'null'
      - int
    doc: the minimum DP across all barcodes for a SNP to be included in the 
      output file
    inputBinding:
      position: 111
      prefix: --minTotalDP
  - id: not_sort_mtx
    type:
      - 'null'
      - boolean
    doc: do not sort the output mtx.
    inputBinding:
      position: 111
      prefix: --notSortMtx
  - id: outvcf
    type:
      - 'null'
      - boolean
    doc: generate the output in vcf format (sgcocaller phase)
    inputBinding:
      position: 111
      prefix: --outvcf
  - id: phased
    type:
      - 'null'
      - boolean
    doc: the input VCF for calling crossovers contains the phased GT of 
      heterozygous SNPs
    inputBinding:
      position: 111
      prefix: --phased
  - id: posterior_prob_min
    type:
      - 'null'
      - float
    doc: the min posterior probability for inferring missing SNPs
    inputBinding:
      position: 111
      prefix: --posteriorProbMin
  - id: step_size
    type:
      - 'null'
      - int
    doc: the move step size used in combination with --binSize.
    inputBinding:
      position: 111
      prefix: --stepSize
  - id: template_cell
    type:
      - 'null'
      - int
    doc: the cell's genotype to be used a template cell, as the cell's index 
      (0-starting) in the barcode file, default as not supplied
    inputBinding:
      position: 111
      prefix: --templateCell
  - id: theta_alt
    type:
      - 'null'
      - float
    doc: the theta for the binomial distribution conditioning on hidden state 
      being ALT
    inputBinding:
      position: 111
      prefix: --thetaALT
  - id: theta_ref
    type:
      - 'null'
      - float
    doc: the theta for the binomial distribution conditioning on hidden state 
      being REF
    inputBinding:
      position: 111
      prefix: --thetaREF
  - id: threads
    type:
      - 'null'
      - int
    doc: number of BAM decompression threads
    inputBinding:
      position: 111
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sgcocaller:0.3.9--hda81887_2
stdout: sgcocaller_phase.out
