cwlVersion: v1.2
class: CommandLineTool
baseCommand: populations
label: stacks_populations
doc: "Stacks populations module for population genetics analysis.\n\nTool homepage:
  https://catchenlab.life.illinois.edu/stacks/"
inputs:
  - id: batch_size
    type:
      - 'null'
      - int
    doc: 'the number of loci to process in a batch (default: 10,000 in de novo mode;
      in reference mode, one chromosome per batch). Increase to speed analysis, uses
      more memory, decrease to save memory).'
    default: 10,000 in de novo mode; in reference mode, one chromosome per batch
    inputBinding:
      position: 101
      prefix: --batch-size
  - id: blacklist
    type:
      - 'null'
      - File
    doc: path to a file containing Blacklisted markers to be excluded from the 
      export.
    inputBinding:
      position: 101
      prefix: --blacklist
  - id: bootstrap
    type:
      - 'null'
      - boolean
    doc: turn on boostrap resampling for all kernel-smoothed statistics.
    inputBinding:
      position: 101
      prefix: --bootstrap
  - id: bootstrap_archive
    type:
      - 'null'
      - boolean
    doc: archive statistical values for use in bootstrap resampling in a 
      subsequent run, statistics must be enabled to be archived.
    inputBinding:
      position: 101
      prefix: --bootstrap-archive
  - id: bootstrap_div
    type:
      - 'null'
      - boolean
    doc: turn on boostrap resampling for smoothed haplotype diveristy and gene 
      diversity calculations based on haplotypes.
    inputBinding:
      position: 101
      prefix: --bootstrap-div
  - id: bootstrap_fst
    type:
      - 'null'
      - boolean
    doc: turn on boostrap resampling for smoothed Fst calculations based on 
      pairwise population comparison of SNPs.
    inputBinding:
      position: 101
      prefix: --bootstrap-fst
  - id: bootstrap_phist
    type:
      - 'null'
      - boolean
    doc: turn on boostrap resampling for smoothed Phi_st calculations based on 
      haplotypes.
    inputBinding:
      position: 101
      prefix: --bootstrap-phist
  - id: bootstrap_pifis
    type:
      - 'null'
      - boolean
    doc: turn on boostrap resampling for smoothed SNP-based Pi and Fis 
      calculations.
    inputBinding:
      position: 101
      prefix: --bootstrap-pifis
  - id: bootstrap_reps
    type:
      - 'null'
      - int
    doc: number of bootstrap resamplings to calculate (default 100).
    default: 100
    inputBinding:
      position: 101
      prefix: --bootstrap-reps
  - id: bootstrap_wl
    type:
      - 'null'
      - File
    doc: only bootstrap loci contained in this whitelist.
    inputBinding:
      position: 101
      prefix: --bootstrap-wl
  - id: fasta_loci
    type:
      - 'null'
      - boolean
    doc: output locus consensus sequences in FASTA format.
    inputBinding:
      position: 101
      prefix: --fasta-loci
  - id: fasta_samples
    type:
      - 'null'
      - boolean
    doc: output the sequences of the two haplotypes of each (diploid) sample, 
      for each locus, in FASTA format.
    inputBinding:
      position: 101
      prefix: --fasta-samples
  - id: fasta_samples_raw
    type:
      - 'null'
      - boolean
    doc: output all haplotypes observed in each sample, for each locus, in FASTA
      format.
    inputBinding:
      position: 101
      prefix: --fasta-samples-raw
  - id: filter_haplotype_wise
    type:
      - 'null'
      - boolean
    doc: apply the above filters haplotype wise (unshared SNPs will be pruned to
      reduce haplotype-wise missing data).
    inputBinding:
      position: 101
      prefix: --filter-haplotype-wise
  - id: fst_correction
    type:
      - 'null'
      - string
    doc: "specify a p-value correction to be applied to Fst values based on a Fisher's
      exact test. Default: off."
    default: off
    inputBinding:
      position: 101
      prefix: --fst-correction
  - id: fstats
    type:
      - 'null'
      - boolean
    doc: enable SNP and haplotype-based F statistics.
    inputBinding:
      position: 101
      prefix: --fstats
  - id: genepop
    type:
      - 'null'
      - boolean
    doc: output SNPs and haplotypes in GenePop format.
    inputBinding:
      position: 101
      prefix: --genepop
  - id: gtf
    type:
      - 'null'
      - boolean
    doc: output locus positions in a GTF annotation file.
    inputBinding:
      position: 101
      prefix: --gtf
  - id: hwe
    type:
      - 'null'
      - boolean
    doc: calculate divergence from Hardy-Weinberg equilibrium for each locus.
    inputBinding:
      position: 101
      prefix: --hwe
  - id: hzar
    type:
      - 'null'
      - boolean
    doc: output genotypes in Hybrid Zone Analysis using R (HZAR) format.
    inputBinding:
      position: 101
      prefix: --hzar
  - id: in_path
    type:
      - 'null'
      - Directory
    doc: path to a directory containing Stacks ouput files.
    inputBinding:
      position: 101
      prefix: --in-path
  - id: in_vcf
    type:
      - 'null'
      - File
    doc: path to a standalone input VCF file.
    inputBinding:
      position: 101
      prefix: --in-vcf
  - id: log_fst_comp
    type:
      - 'null'
      - boolean
    doc: log components of Fst/Phi_st calculations to a file.
    inputBinding:
      position: 101
      prefix: --log-fst-comp
  - id: map_format
    type:
      - 'null'
      - string
    doc: mapping program format to write, 'joinmap', 'onemap', and 'rqtl' are 
      currently supported.
    inputBinding:
      position: 101
      prefix: --map-format
  - id: map_type
    type:
      - 'null'
      - string
    doc: genetic map type to write. 'CP', 'DH', 'F2', and 'BC1' are the 
      currently supported map types.
    inputBinding:
      position: 101
      prefix: --map-type
  - id: max_obs_het
    type:
      - 'null'
      - float
    doc: specify a maximum observed heterozygosity required to process a SNP 
      (applied ot the metapopulation).
    inputBinding:
      position: 101
      prefix: --max-obs-het
  - id: min_gt_depth
    type:
      - 'null'
      - int
    doc: specify a minimum number of reads to include a called SNP (otherwise 
      marked as missing data).
    inputBinding:
      position: 101
      prefix: --min-gt-depth
  - id: min_mac
    type:
      - 'null'
      - int
    doc: specify a minimum minor allele count required to process a SNP (applied
      to the metapopulation).
    inputBinding:
      position: 101
      prefix: --min-mac
  - id: min_maf
    type:
      - 'null'
      - float
    doc: specify a minimum minor allele frequency required to process a SNP (0 <
      min_maf < 0.5; applied to the metapopulation).
    inputBinding:
      position: 101
      prefix: --min-maf
  - id: min_populations
    type:
      - 'null'
      - int
    doc: minimum number of populations a locus must be present in to process a 
      locus.
    inputBinding:
      position: 101
      prefix: --min-populations
  - id: min_samples_overall
    type:
      - 'null'
      - float
    doc: minimum percentage of individuals across populations required to 
      process a locus.
    inputBinding:
      position: 101
      prefix: --min-samples-overall
  - id: min_samples_per_pop
    type:
      - 'null'
      - float
    doc: minimum percentage of individuals in a population required to process a
      locus for that population.
    inputBinding:
      position: 101
      prefix: --min-samples-per-pop
  - id: no_hap_exports
    type:
      - 'null'
      - boolean
    doc: omit haplotype outputs.
    inputBinding:
      position: 101
      prefix: --no-hap-exports
  - id: ordered_export
    type:
      - 'null'
      - boolean
    doc: if data is reference aligned, exports will be ordered; only a single 
      representative of each overlapping site.
    inputBinding:
      position: 101
      prefix: --ordered-export
  - id: out_path
    type: Directory
    doc: path to a directory where to write the output files. (Required by -V; 
      otherwise defaults to value of -P.)
    inputBinding:
      position: 101
      prefix: --out-path
  - id: p_value_cutoff
    type:
      - 'null'
      - float
    doc: 'maximum p-value to keep an Fst measurement. Default: 0.05.'
    default: 0.05
    inputBinding:
      position: 101
      prefix: --p-value-cutoff
  - id: phylip
    type:
      - 'null'
      - boolean
    doc: output nucleotides that are fixed-within, and variant among populations
      in Phylip format for phylogenetic tree construction.
    inputBinding:
      position: 101
      prefix: --phylip
  - id: phylip_var
    type:
      - 'null'
      - boolean
    doc: include variable sites in the phylip output encoded using IUPAC 
      notation.
    inputBinding:
      position: 101
      prefix: --phylip-var
  - id: phylip_var_all
    type:
      - 'null'
      - boolean
    doc: include all sequence as well as variable sites in the phylip output 
      encoded using IUPAC notation.
    inputBinding:
      position: 101
      prefix: --phylip-var-all
  - id: plink
    type:
      - 'null'
      - boolean
    doc: output genotypes in PLINK format.
    inputBinding:
      position: 101
      prefix: --plink
  - id: popmap
    type:
      - 'null'
      - File
    doc: path to a population map. (Format is 'SAMPLE1 \t POP1 \n SAMPLE2 ...'.)
    inputBinding:
      position: 101
      prefix: --popmap
  - id: radpainter
    type:
      - 'null'
      - boolean
    doc: output results in fineRADstructure/RADpainter format.
    inputBinding:
      position: 101
      prefix: --radpainter
  - id: sigma
    type:
      - 'null'
      - int
    doc: standard deviation of the kernel smoothing weight distribution. Sliding
      window size is defined as 3 x sigma; (default sigma = 150kbp).
    default: 150kbp
    inputBinding:
      position: 101
      prefix: --sigma
  - id: smooth
    type:
      - 'null'
      - boolean
    doc: enable kernel-smoothed Pi, Fis, Fst, Fst', and Phi_st calculations.
    inputBinding:
      position: 101
      prefix: --smooth
  - id: smooth_fstats
    type:
      - 'null'
      - boolean
    doc: enable kernel-smoothed Fst, Fst', and Phi_st calculations.
    inputBinding:
      position: 101
      prefix: --smooth-fstats
  - id: smooth_popstats
    type:
      - 'null'
      - boolean
    doc: enable kernel-smoothed Pi and Fis calculations.
    inputBinding:
      position: 101
      prefix: --smooth-popstats
  - id: structure
    type:
      - 'null'
      - boolean
    doc: output results in Structure format.
    inputBinding:
      position: 101
      prefix: --structure
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads to run in parallel sections of code.
    inputBinding:
      position: 101
      prefix: --threads
  - id: treemix
    type:
      - 'null'
      - boolean
    doc: output SNPs in a format useable for the TreeMix program (Pickrell and 
      Pritchard).
    inputBinding:
      position: 101
      prefix: --treemix
  - id: vcf
    type:
      - 'null'
      - boolean
    doc: output SNPs and haplotypes in Variant Call Format (VCF).
    inputBinding:
      position: 101
      prefix: --vcf
  - id: vcf_all
    type:
      - 'null'
      - boolean
    doc: output all sites in Variant Call Format (VCF).
    inputBinding:
      position: 101
      prefix: --vcf-all
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: turn on additional logging.
    inputBinding:
      position: 101
      prefix: --verbose
  - id: whitelist
    type:
      - 'null'
      - File
    doc: path to a file containing Whitelisted markers to include in the export.
    inputBinding:
      position: 101
      prefix: --whitelist
  - id: write_random_snp
    type:
      - 'null'
      - boolean
    doc: restrict data analysis to one random SNP per locus (implies --no-haps).
    inputBinding:
      position: 101
      prefix: --write-random-snp
  - id: write_single_snp
    type:
      - 'null'
      - boolean
    doc: restrict data analysis to only the first SNP per locus (implies 
      --no-haps).
    inputBinding:
      position: 101
      prefix: --write-single-snp
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/stacks:2.68--h077b44d_3
stdout: stacks_populations.out
