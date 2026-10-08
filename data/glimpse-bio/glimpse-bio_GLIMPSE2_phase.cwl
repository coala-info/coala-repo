cwlVersion: v1.2
class: CommandLineTool
baseCommand: GLIMPSE2_phase
label: glimpse-bio_GLIMPSE2_phase
doc: "Phase and impute low coverage sequencing data\n\nTool homepage: https://github.com/odelaneau/GLIMPSE"
inputs:
  - id: seed
    type:
      - 'null'
      - int
    doc: "Seed of the random number generator"
    inputBinding:
      position: 101
      prefix: --seed
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads"
    inputBinding:
      position: 101
      prefix: --threads
  - id: bam_file
    type:
      - 'null'
      - File
    doc: "Input BAM/CRAM file containing low-coverage sequencing reads. Only one of the following options can be declared: --input-gl, --bam-file, --bam-list."
    secondaryFiles:
      - pattern: '.bai'
        required: false
      - pattern: '.crai'
        required: false
      - pattern: '.csi'
        required: false
    inputBinding:
      position: 101
      prefix: --bam-file
  - id: bam_list
    type:
      - 'null'
      - File
    doc: "List (.txt file) of input BAM/CRAM files containing low-coverage sequencing reads. One file per line. A second column (space separated) can be used to specify the sample name, otherwise the name of the file is used. Only one of the following options can be declared: --input-gl, --bam-file, --bam-list."
    inputBinding:
      position: 101
      prefix: --bam-list
  - id: input_gl
    type:
      - 'null'
      - File
    doc: "VCF/BCF file containing the genotype likelihoods. Only one of the following options can be declared: --input-gl, --bam-file, --bam-list."
    secondaryFiles:
      - pattern: '.csi'
        required: false
      - pattern: '.tbi'
        required: false
    inputBinding:
      position: 101
      prefix: --input-gl
  - id: reference
    type:
      - 'null'
      - File
    doc: "Haplotype reference in VCF/BCF or binary format"
    secondaryFiles:
      - pattern: '.csi'
        required: false
      - pattern: '.tbi'
        required: false
    inputBinding:
      position: 101
      prefix: --reference
  - id: map
    type:
      - 'null'
      - File
    doc: "Genetic map"
    inputBinding:
      position: 101
      prefix: --map
  - id: input_region
    type:
      - 'null'
      - string
    doc: "Imputation region with buffers"
    inputBinding:
      position: 101
      prefix: --input-region
  - id: output_region
    type:
      - 'null'
      - string
    doc: "Imputation region without buffers"
    inputBinding:
      position: 101
      prefix: --output-region
  - id: sparse_maf
    type:
      - 'null'
      - float
    doc: "(Expert setting) Rare variant threshold"
    inputBinding:
      position: 101
      prefix: --sparse-maf
  - id: samples_file
    type:
      - 'null'
      - File
    doc: "File with sample names and ploidy information. One sample per line with a mandatory second column indicating ploidy (1 or 2). Sample names that are not present are assumed to have ploidy 2 (diploids). If the parameter is omitted, all samples are assumed to be diploid. GLIMPSE does NOT handle the use of sex (M/F) instead of ploidy."
    inputBinding:
      position: 101
      prefix: --samples-file
  - id: ind_name
    type:
      - 'null'
      - string
    doc: "Only used together with --bam-file. Name of the sample to be processed. If not specified the prefix of the BAM/CRAM file (--bam-file) is used."
    inputBinding:
      position: 101
      prefix: --ind-name
  - id: keep_monomorphic_ref_sites
    type:
      - 'null'
      - boolean
    doc: "(Expert setting) Keeps monomorphic markers in the reference panel (removed by default)"
    inputBinding:
      position: 101
      prefix: --keep-monomorphic-ref-sites
  - id: impute_reference_only_variants
    type:
      - 'null'
      - boolean
    doc: "Only used together with --input-gl. Allows imputation at variants only present in the reference panel. The use of this option is intended only to allow imputation at sporadic missing variants. If the number of missing variants is non-sporadic, please re-run the genotype likelihood computation at all reference variants and avoid using this option, since data from the reads should be used. A warning is thrown if reference-only variants are found."
    inputBinding:
      position: 101
      prefix: --impute-reference-only-variants
  - id: input_field_gl
    type:
      - 'null'
      - boolean
    doc: "Only used together with --input-gl. Use FORMAT/GL field instead of FORMAT/PL to read genotype likelihoods"
    inputBinding:
      position: 101
      prefix: --input-field-gl
  - id: use_gl_indels
    type:
      - 'null'
      - boolean
    doc: "(Expert setting) Only used together with --input-gl. Use genotype likelihoods at indels from the VCF/BCF file. By default GLIMPSE assumes flat likelihoods at non-SNP variants, as genotype likelihoods from low-coverage data are often miscalibrated, potentially affecting neighbouring variants."
    inputBinding:
      position: 101
      prefix: --use-gl-indels
  - id: burnin
    type:
      - 'null'
      - int
    doc: "(Expert setting) Number of burn-in iterations of the Gibbs sampler"
    inputBinding:
      position: 101
      prefix: --burnin
  - id: main
    type:
      - 'null'
      - int
    doc: "(Expert setting) Number of main iterations of the Gibbs sampler"
    inputBinding:
      position: 101
      prefix: --main
  - id: ne
    type:
      - 'null'
      - int
    doc: "(Expert setting) Effective diploid population size modelling recombination frequency"
    inputBinding:
      position: 101
      prefix: --ne
  - id: min_gl
    type:
      - 'null'
      - float
    doc: "(Expert setting) Minimim haploid likelihood"
    inputBinding:
      position: 101
      prefix: --min-gl
  - id: err_imp
    type:
      - 'null'
      - float
    doc: "(Expert setting) Imputation HMM error rate"
    inputBinding:
      position: 101
      prefix: --err-imp
  - id: err_phase
    type:
      - 'null'
      - float
    doc: "(Expert setting) Phasing HMM error rate"
    inputBinding:
      position: 101
      prefix: --err-phase
  - id: pbwt_depth
    type:
      - 'null'
      - int
    doc: "(Expert setting) Number of neighbors in the sparse PBWT selection step (positive number)"
    inputBinding:
      position: 101
      prefix: --pbwt-depth
  - id: pbwt_modulo_cm
    type:
      - 'null'
      - float
    doc: "(Expert setting) Frequency of PBWT selection in cM (positive number). This parameter is automatically adjusted in case of small imputation regions"
    inputBinding:
      position: 101
      prefix: --pbwt-modulo-cm
  - id: Kinit
    type:
      - 'null'
      - int
    doc: "(Expert setting) Number of states used for initialization (positive number). Can be set to zero only when \u2013state-list is set, to skip the selection for the initialization step"
    inputBinding:
      position: 101
      prefix: --Kinit
  - id: Kpbwt
    type:
      - 'null'
      - int
    doc: "(Expert setting)  Maximum number of states selected from the sparse PBWT (positive number). Can be set to zero only when \u2013state-list is set, to skip the selection for during the Gibbs iterations"
    inputBinding:
      position: 101
      prefix: --Kpbwt
  - id: state_list
    type:
      - 'null'
      - File
    doc: "(Expert setting) List (.txt file) of haplotypes always present in the conditioning set, independent from state selection. Not affected by other selection parameters. Each row is a target haplotype (two lines per sample in case of diploid individuals) each column is a space separated list of reference haplotypes (in numberical order 0-(2N-1) ). Useful when prior knowledge of relatedness between the reference and target panel is known a priori."
    inputBinding:
      position: 101
      prefix: --state-list
  - id: call_model
    type:
      - 'null'
      - string
    doc: "Model to use to call the data. Only the standard model is available at the moment."
    inputBinding:
      position: 101
      prefix: --call-model
  - id: call_indels
    type:
      - 'null'
      - boolean
    doc: "(Expert setting) Use the calling model to produce genotype likelihoods at indels. However the likelihoods from low-coverage data can be miscalibrated, therefore by default GLIMPSE does only imputation into the haplotype scaffold (assuming flat likelihoods)"
    inputBinding:
      position: 101
      prefix: --call-indels
  - id: fasta
    type:
      - 'null'
      - File
    doc: "Faidx-indexed reference sequence file in the appropriate genome build. Necessary for CRAM files"
    secondaryFiles:
      - pattern: '.fai'
        required: false
      - pattern: '.gzi'
        required: false
    inputBinding:
      position: 101
      prefix: --fasta
  - id: mapq
    type:
      - 'null'
      - int
    doc: "Minimum mapping quality for a read to be considered"
    inputBinding:
      position: 101
      prefix: --mapq
  - id: baseq
    type:
      - 'null'
      - int
    doc: "Minimum phred-scalde based quality to be considered"
    inputBinding:
      position: 101
      prefix: --baseq
  - id: max_depth
    type:
      - 'null'
      - int
    doc: "(Expert setting) Max read depth at a site. If the number of reads exceeds this number, the reads at the sites are downsampled (e.g. to avoid artifactual coverage increases)"
    inputBinding:
      position: 101
      prefix: --max-depth
  - id: keep_orphan_reads
    type:
      - 'null'
      - boolean
    doc: "(Expert setting) Keep paired end reads where one of mates is unmapped"
    inputBinding:
      position: 101
      prefix: --keep-orphan-reads
  - id: ignore_orientation
    type:
      - 'null'
      - boolean
    doc: "(Expert setting) Ignore the orientation of mate pairs"
    inputBinding:
      position: 101
      prefix: --ignore-orientation
  - id: check_proper_pairing
    type:
      - 'null'
      - boolean
    doc: "(Expert setting) Discard reads that are not properly paired"
    inputBinding:
      position: 101
      prefix: --check-proper-pairing
  - id: keep_failed_qc
    type:
      - 'null'
      - boolean
    doc: "(Expert setting) Keep reads that fail sequencing QC (as indicated by the sequencer)"
    inputBinding:
      position: 101
      prefix: --keep-failed-qc
  - id: keep_duplicates
    type:
      - 'null'
      - boolean
    doc: "(Expert setting) Keep duplicate sequencing reads in the process"
    inputBinding:
      position: 101
      prefix: --keep-duplicates
  - id: illumina13_plus
    type:
      - 'null'
      - boolean
    doc: "(Expert setting) Use illimina 1.3 encoding for the base quality (for older sequencing machines)"
    inputBinding:
      position: 101
      prefix: --illumina13+
  - id: output_path
    type: string
    doc: "Phased and imputed haplotypes in VCF/BCF/BGEN format"
    inputBinding:
      position: 102
      prefix: --output
  - id: contigs_fai
    type:
      - 'null'
      - File
    doc: "If specified, header contig names and their lengths are copied from the provided fasta index file (.fai). This allows to create imputed whole-genome files as contigs are present and can be easily merged by bcftools"
    inputBinding:
      position: 101
      prefix: --contigs-fai
  - id: bgen_bits
    type:
      - 'null'
      - int
    doc: "(Expert setting) Only used toghether when the output is in BGEN file format. Specifies the number of bits to be used for the encoding probabilities of the output BGEN file. If the output is in the .vcf[.gz]/.bcf format, this value is ignored. Accepted values: 1-32"
    inputBinding:
      position: 101
      prefix: --bgen-bits
  - id: bgen_compr
    type:
      - 'null'
      - string
    doc: "(Expert setting) Only used toghether when the output is in BGEN file format. Specifies the compression of the output BGEN file. If the output is in the .vcf[.gz]/.bcf format, this value is ignored. Accepted values: [no,zlib,zstd]"
    inputBinding:
      position: 101
      prefix: --bgen-compr
  - id: log_path
    type:
      - 'null'
      - string
    doc: "Log file"
    inputBinding:
      position: 101
      prefix: --log
  - id: list_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Files named inside --bam-list or --state-list (for example BAM/CRAM files with their indexes), staged in the working directory
    secondaryFiles:
      - pattern: '.bai'
        required: false
      - pattern: '.crai'
        required: false
outputs:
  - id: output
    type: File
    doc: Phased and imputed haplotypes in VCF/BCF/BGEN format
    secondaryFiles:
      - pattern: '.csi'
        required: false
    outputBinding:
      glob: $(inputs.output_path)
  - id: log
    type:
      - 'null'
      - File
    doc: Log file
    outputBinding:
      glob: $(inputs.log_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: $(inputs.list_files || [])
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/glimpse-bio:2.0.1--ha5d29c5_3
