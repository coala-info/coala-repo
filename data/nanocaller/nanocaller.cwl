cwlVersion: v1.2
class: CommandLineTool
baseCommand: NanoCaller
label: nanocaller
doc: "NanoCaller is a computational tool for variant calling (SNPs and Indels) from Oxford Nanopore and PacBio sequencing data using deep learning.\n\nTool homepage: https://github.com/WGLab/NanoCaller"
inputs:
  - id: bam
    type: File
    secondaryFiles:
      - .bai
    doc: "Bam file, should be phased if 'indel' mode is selected"
    inputBinding:
      position: 10
      prefix: --bam
  - id: ref
    type: File
    secondaryFiles:
      - .fai
    doc: Reference genome file with .fai index
    inputBinding:
      position: 10
      prefix: --ref
  - id: preset
    type:
      - 'null'
      - string
    doc: "Apply recommended preset values for SNP and Indel calling parameters: ont, ul_ont, ul_ont_extreme, ccs or clr"
    inputBinding:
      position: 10
      prefix: "--preset"
  - id: mode
    type:
      - 'null'
      - string
    doc: "NanoCaller mode to run: snps, indels or all (default all)"
    inputBinding:
      position: 10
      prefix: "--mode"
  - id: sequencing
    type:
      - 'null'
      - string
    doc: "Sequencing type: short_ont, ont, ul_ont, ul_ont_extreme or pacbio (default ont)"
    inputBinding:
      position: 10
      prefix: "--sequencing"
  - id: cpu
    type:
      - 'null'
      - int
    doc: "Number of CPUs to use. (default: 1)"
    inputBinding:
      position: 10
      prefix: "--cpu"
  - id: mincov
    type:
      - 'null'
      - int
    doc: "Minimum coverage to call a variant (default: 4)"
    inputBinding:
      position: 10
      prefix: "--mincov"
  - id: maxcov
    type:
      - 'null'
      - int
    doc: "Maximum coverage of reads to use. If sequencing depth at a candidate site exceeds maxcov then reads are downsampled. (default: 160)"
    inputBinding:
      position: 10
      prefix: "--maxcov"
  - id: suppress_progress_bar
    type:
      - 'null'
      - boolean
    doc: "Do not show progress bar."
    inputBinding:
      position: 10
      prefix: "--suppress_progress_bar"
  - id: haploid_genome
    type:
      - 'null'
      - boolean
    doc: "Assume that all chromosomes in the genome are haploid."
    inputBinding:
      position: 10
      prefix: "--haploid_genome"
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Show all stdout and stderr messages"
    inputBinding:
      position: 10
      prefix: "--verbose"
  - id: haploid_X
    type:
      - 'null'
      - boolean
    doc: "Assume that chrX is haploid. chrY and chrM are assumed to be haploid by default."
    inputBinding:
      position: 10
      prefix: "--haploid_X"
  - id: regions
    type:
      - 'null'
      - type: array
        items: string
    doc: "A space separated list of regions specified as CONTIG_NAME or CONTIG_NAME:START-END"
    inputBinding:
      position: 10
      prefix: "--regions"
  - id: bed
    type:
      - 'null'
      - File
    doc: "A BED file specifying regions for variant calling."
    inputBinding:
      position: 10
      prefix: "--bed"
  - id: wgs_contigs
    type:
      - 'null'
      - string
    doc: "Preset list of chromosomes to use for variant calling on human genomes: chr1-22XY or 1-22XY"
    inputBinding:
      position: 10
      prefix: "--wgs_contigs"
  - id: exclude_bed
    type:
      - 'null'
      - string
    doc: "Intervals to ignore for variant calling: hg38, hg19, mm10 or mm39 (BED files included in NanoCaller)"
    inputBinding:
      position: 10
      prefix: "--exclude_bed"
  - id: snp_model
    type:
      - 'null'
      - string
    doc: "NanoCaller SNP model to be used (default: ONT-HG002)"
    inputBinding:
      position: 10
      prefix: "--snp_model"
  - id: min_allele_freq
    type:
      - 'null'
      - float
    doc: "minimum alternative allele frequency (default: 0.15)"
    inputBinding:
      position: 10
      prefix: "--min_allele_freq"
  - id: min_nbr_sites
    type:
      - 'null'
      - int
    doc: "minimum number of nbr sites (default: 1)"
    inputBinding:
      position: 10
      prefix: "--min_nbr_sites"
  - id: neighbor_threshold
    type:
      - 'null'
      - string
    doc: "SNP neighboring site thresholds with lower and upper bounds separated by comma (default: 0.4,0.6)"
    inputBinding:
      position: 10
      prefix: "--neighbor_threshold"
  - id: supplementary
    type:
      - 'null'
      - boolean
    doc: "Use supplementary reads, not fully supported at the moment"
    inputBinding:
      position: 10
      prefix: "--supplementary"
  - id: disable_coverage_normalization
    type:
      - 'null'
      - boolean
    doc: "Do not normalize pileup counts at a candidate site using average depth of the surrounding SNP candidate sites."
    inputBinding:
      position: 10
      prefix: "--disable_coverage_normalization"
  - id: indel_model
    type:
      - 'null'
      - string
    doc: "NanoCaller indel model to be used (default: ONT-HG002)"
    inputBinding:
      position: 10
      prefix: "--indel_model"
  - id: ins_threshold
    type:
      - 'null'
      - float
    doc: "Insertion Threshold (default: 0.4)"
    inputBinding:
      position: 10
      prefix: "--ins_threshold"
  - id: del_threshold
    type:
      - 'null'
      - float
    doc: "Deletion Threshold (default: 0.6)"
    inputBinding:
      position: 10
      prefix: "--del_threshold"
  - id: win_size
    type:
      - 'null'
      - int
    doc: "Size of the sliding window in which the number of indels is counted to determine indel candidate site (default: 40)"
    inputBinding:
      position: 10
      prefix: "--win_size"
  - id: small_win_size
    type:
      - 'null'
      - int
    doc: "Size of the sliding window in which indel frequency is determined for small indels (default: 4)"
    inputBinding:
      position: 10
      prefix: "--small_win_size"
  - id: impute_indel_phase
    type:
      - 'null'
      - boolean
    doc: "Infer read phase by rudimentary allele clustering if no or insufficient phasing information is available"
    inputBinding:
      position: 10
      prefix: "--impute_indel_phase"
  - id: phase
    type:
      - 'null'
      - boolean
    doc: "Phase SNPs and BAM files if snps mode is selected."
    inputBinding:
      position: 10
      prefix: "--phase"
  - id: phase_qual_score
    type:
      - 'null'
      - int
    doc: "SNP QUAL score cutoff for phasing via WhatsHap (default: 10)"
    inputBinding:
      position: 10
      prefix: "--phase_qual_score"
  - id: enable_whatshap
    type:
      - 'null'
      - boolean
    doc: "Allow WhatsHap to change SNP genotypes when phasing using --distrust-genotypes and --include-homozygous flags"
    inputBinding:
      position: 10
      prefix: "--enable_whatshap"
  - id: prefix
    type:
      - 'null'
      - string
    doc: "VCF file prefix (default: variant_calls)"
    inputBinding:
      position: 10
      prefix: "--prefix"
  - id: sample
    type:
      - 'null'
      - string
    doc: "VCF file sample name (default: SAMPLE)"
    inputBinding:
      position: 10
      prefix: "--sample"
  - id: output
    type: string
    default: nanocaller_out
    doc: VCF output path (a directory; default is the current working directory)
    inputBinding:
      position: 10
      prefix: --output
outputs:
  - id: output_dir
    type: Directory
    doc: Folder with the VCF files (<prefix>.snps.vcf.gz, <prefix>.indels.vcf.gz, unfiltered files) and intermediate files
    outputBinding:
      glob: $(inputs.output)
  - id: stdout
    type: stdout
    doc: Progress messages
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nanocaller:3.6.2--h42286b9_0
stdout: nanocaller.out
