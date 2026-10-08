cwlVersion: v1.2
class: CommandLineTool
baseCommand: [sgcocaller, phase]
label: sgcocaller_phase
doc: 'sgcocaller phase [options] <BAM> <VCF> <barcodeFile> <out_prefix>


  Tool homepage: https://gitlab.svi.edu.au/biocellgen-public/sgcocaller'
inputs:
  - id: bam
    type: File
    doc: the read alignment file with records of single-cell DNA reads (BAM index
      .bai must be next to it)
    inputBinding: {position: 1}
    secondaryFiles:
      - {pattern: .bai, required: true}
  - id: vcf
    type: File
    doc: the variant call file with records of SNPs (bgzipped, with .tbi index next
      to it)
    inputBinding: {position: 2}
    secondaryFiles:
      - {pattern: .tbi, required: true}
  - id: barcode_file
    type: File
    doc: the text file containing the list of cell barcodes
    inputBinding: {position: 3}
  - id: out_prefix
    type: string
    doc: the prefix of output files (prepended to each output file name; a directory
      part must already exist)
    inputBinding: {position: 4}
  - id: threads
    type: ['null', int]
    doc: number of BAM decompression threads
    inputBinding: {prefix: --threads}
  - id: barcode_tag
    type: ['null', string]
    doc: the cell barcode tag in BAM
    inputBinding: {prefix: --barcodeTag}
  - id: min_mapq
    type: ['null', int]
    doc: Minimum MAPQ for read filtering
    inputBinding: {prefix: --minMAPQ}
  - id: baseq
    type: ['null', int]
    doc: base quality threshold for a base to be used for counting
    inputBinding: {prefix: --baseq}
  - id: chrom
    type: ['null', string]
    doc: the selected chromsome (whole genome if not supplied,separate by comma if
      multiple chroms)
    inputBinding: {prefix: --chrom}
  - id: min_dp
    type: ['null', int]
    doc: the minimum DP for a SNP to be included in the output file
    inputBinding: {prefix: --minDP}
  - id: max_dp
    type: ['null', int]
    doc: the maximum DP for a SNP to be included in the output file
    inputBinding: {prefix: --maxDP}
  - id: max_total_dp
    type: ['null', int]
    doc: the maximum DP across all barcodes for a SNP to be included in the output
      file
    inputBinding: {prefix: --maxTotalDP}
  - id: min_total_dp
    type: ['null', int]
    doc: the minimum DP across all barcodes for a SNP to be included in the output
      file
    inputBinding: {prefix: --minTotalDP}
  - id: min_snp_depth
    type: ['null', int]
    doc: the minimum depth of cell coverage for a SNP to be includes in generated
      genotype matrix file
    inputBinding: {prefix: --minSNPdepth}
  - id: theta_ref
    type: ['null', float]
    doc: the theta for the binomial distribution conditioning on hidden state being
      REF
    inputBinding: {prefix: --thetaREF}
  - id: theta_alt
    type: ['null', float]
    doc: the theta for the binomial distribution conditioning on hidden state being
      ALT
    inputBinding: {prefix: --thetaALT}
  - id: cm_pmb
    type: ['null', float]
    doc: the average centiMorgan distances per megabases default 0.1 cm per Mb
    inputBinding: {prefix: --cmPmb}
  - id: phased
    type: ['null', boolean]
    doc: the input VCF for calling crossovers contains the phased GT of heterozygous
      SNPs
    inputBinding: {prefix: --phased}
  - id: outvcf
    type: ['null', boolean]
    doc: generate the output in vcf format (sgcocaller phase)
    inputBinding: {prefix: --outvcf}
  - id: template_cell
    type: ['null', int]
    doc: the cell's genotype to be used a template cell, as the cell's index (0-starting)
      in the barcode file, default as not supplied
    inputBinding: {prefix: --templateCell}
  - id: max_dissim
    type: ['null', float]
    doc: the maximum dissimilarity for a pair of cell to be selected as potential
      template cells due to not having crossovers in either cell
    inputBinding: {prefix: --maxDissim}
  - id: max_expand
    type: ['null', int]
    doc: the maximum number of iterations to look for locally coexisting positions
      for inferring missing SNPs in template haplotype sequence
    inputBinding: {prefix: --maxExpand}
  - id: posterior_prob_min
    type: ['null', float]
    doc: the min posterior probability for inferring missing SNPs
    inputBinding: {prefix: --posteriorProbMin}
  - id: look_beyond_snps
    type: ['null', int]
    doc: the number of local SNPs to use when finding switch positions
    inputBinding: {prefix: --lookBeyondSnps}
  - id: min_switch_score
    type: ['null', float]
    doc: the minimum switch score for a site to be identified as having a switch error
      in the inferred haplotype
    inputBinding: {prefix: --minSwitchScore}
  - id: min_positive_switch_scores
    type: ['null', int]
    doc: the min number of continuing SNPs with positive switch scores to do switch
      error correction
    inputBinding: {prefix: --minPositiveSwitchScores}
  - id: bin_size
    type: ['null', int]
    doc: the size of SNP bins for scanning swith errors, users are recommended to
      increase this option when SNP density is high.
    inputBinding: {prefix: --binSize}
  - id: step_size
    type: ['null', int]
    doc: the move step size used in combination with --binSize.
    inputBinding: {prefix: --stepSize}
  - id: dissim_thresh
    type: ['null', float]
    doc: the threshold used on the allele concordance ratio for determining if a SNP
      bin contains a crossover.
    inputBinding: {prefix: --dissimThresh}
  - id: batch_size
    type: ['null', int]
    doc: the number of cells to process in one batch when running sxo. This option
      is only needed when the memory is limited.
    inputBinding: {prefix: --batchSize}
  - id: not_sort_mtx
    type: ['null', boolean]
    doc: do not sort the output mtx.
    inputBinding: {prefix: --notSortMtx}
  - id: max_use_ncells
    type: ['null', int]
    doc: the number of cells to use for calculating switch scores. All cells are used
      if not set
    inputBinding: {prefix: --maxUseNcells}
outputs:
  - {id: stdout, type: stdout, doc: Standard output}
  - id: out_prefix_files
    type: {type: array, items: File}
    doc: Files written with the prefix given in out_prefix
    outputBinding: {glob: $(inputs.out_prefix)*}
hints:
  - {class: DockerRequirement, dockerPull: 'quay.io/biocontainers/sgcocaller:0.3.9--hda81887_2'}
stdout: sgcocaller_phase.out
