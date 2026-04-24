cwlVersion: v1.2
class: CommandLineTool
baseCommand: isafe
label: isafe
doc: "iSAFE: (i)ntegrated (S)election of (A)llele (F)avored by (E)volution\n\nTool
  homepage: https://github.com/alek0991/iSAFE"
inputs:
  - id: aa
    type:
      - 'null'
      - string
    doc: "<string>: Path to the Ancestral Allele (AA) file in FASTA (.fa) format.\n\
      \  * This is strongly recommended  in --format vcf. However, if the ancestral
      allele file is not available the program raises a warning and assumes reference
      allele (REF) is ancestral allele.\n  * Download link (GRCh37/hg19): http://ftp.ensembl.org/pub/release-75/fasta/ancestral_alleles/\n\
      \  * Download link (GRCh38/hg38): http://ftp.ensemblorg.ebi.ac.uk/pub/release-88/fasta/ancestral_alleles/"
    inputBinding:
      position: 101
      prefix: --AA
  - id: force_random_sample
    type:
      - 'null'
      - boolean
    doc: "<bool>: Set this flag to force the iSAFE to use random samples even when
      MDDAF doesn't recommend.\n  * --vcf-cont must be provided."
    inputBinding:
      position: 101
      prefix: --ForceRandomSample
  - id: format
    type:
      - 'null'
      - string
    doc: "<string>: Input format. <FORMAT> must be either hap or vcf (see the manual
      for more details).\niSAFE can handle two types of inputs (phased haplotypes
      are required):\n  * vcf format: --format vcf or -f vcf\n    - vcf format only
      accepts indexed bgzipped VCF (vcf.gz with index file) or indexed bcf files (.bcf
      with index file).\n    - When input format is vcf, Ancestral Allele file (--AA)
      must be given.\n  * hap format: --format hap or -f hap\n    - Input with hap
      format is not allowed with any of these: --vcf-cont, --sample-case, --sample-cont,
      --AA.\n    - With hap format, iSAFE assumes that derived allele is 1 and ancestral
      allele is 0 in the input file,\n      and the selection is ongoing (the favored
      mutation is not fixed)."
    inputBinding:
      position: 101
      prefix: --format
  - id: ignore_gaps
    type:
      - 'null'
      - boolean
    doc: '<bool>: Set this flag to ignore gaps.'
    inputBinding:
      position: 101
      prefix: --IgnoreGaps
  - id: input
    type: string
    doc: "<string>: Path to the input (case population).\n  * Input positions must
      be sorted numerically, in increasing order."
    inputBinding:
      position: 101
      prefix: --input
  - id: max_freq
    type:
      - 'null'
      - float
    doc: '<float>: Ignore SNPs with frequency higher than MaxFreq.'
    inputBinding:
      position: 101
      prefix: --MaxFreq
  - id: max_gap_size
    type:
      - 'null'
      - int
    doc: "<int>: Maximum gap size in bp.\n  * When there is a gap larger than --MaxGapSize
      the program raise an error.\n  * You can ignore this by setting the --IgnoreGaps
      flag."
    inputBinding:
      position: 101
      prefix: --MaxGapSize
  - id: max_rank
    type:
      - 'null'
      - int
    doc: "<int>: Ignore SNPs with rank higher than MAXRANK.\n  * For considering all
      SNPs set --MaxRank > --window.\n  * The higher the --MaxRank, the higher the
      computation time."
    inputBinding:
      position: 101
      prefix: --MaxRank
  - id: max_region_size
    type:
      - 'null'
      - int
    doc: "<int>: Maximum region size in bp.\n  * Consider the memory (RAM) size when
      change this parameter."
    inputBinding:
      position: 101
      prefix: --MaxRegionSize
  - id: min_region_size_bp
    type:
      - 'null'
      - int
    doc: '<int>: Minimum region size in bp.'
    inputBinding:
      position: 101
      prefix: --MinRegionSize-bp
  - id: min_region_size_ps
    type:
      - 'null'
      - int
    doc: "<int>: Minimum region size in polymorphic sites.\n  * Note that --window
      cannot be smaller than --MinRegionSize-ps."
    inputBinding:
      position: 101
      prefix: --MinRegionSize-ps
  - id: output_psi
    type:
      - 'null'
      - boolean
    doc: '<bool>: Set this flag to output Psi_1 in a text file with suffix .Psi.out.'
    inputBinding:
      position: 101
      prefix: --OutputPsi
  - id: random_sample_rate
    type:
      - 'null'
      - float
    doc: "<float>: Portion of added random samples.\n  * RandomSampleRate = RandomSamples/(RandomSamples+CaseSamples).\n\
      \  * Must be non-negative and less than 1.\n  * Ignored when --vcf-case is not
      used.\n  * Ignored when MDDAF criterion doesn't recommend adding random samples.
      The option --ForceRandomSample\n    can be used to override MDDAF criterion."
    inputBinding:
      position: 101
      prefix: --RandomSampleRate
  - id: region
    type:
      - 'null'
      - string
    doc: "<chr:string>:<start position:int>-<end position:int>, the coordinates of
      the target region in the genome.\n  * This is required in --format vcf but optional
      in the --format hap.\n  * In vcf format, <chr> style (e.g. chr2 or 2) must be
      consistent with vcf files.\n  * The <chr> is dumped in --format hap.\n  * Valid
      Examples:\n      2:10000000-15000000\n      chr2:10000000-15000000\n      2:10,000,000-15,000,000\n\
      \      chr2:10,000,000-15,000,000"
    inputBinding:
      position: 101
      prefix: --region
  - id: safe
    type:
      - 'null'
      - boolean
    doc: "<bool>: Set this flag to report the SAFE score of the entire region.\n \
      \ * When the region size is less than --MinRegionSize-ps (Default: 1000 SNPs)
      or --MinRegionSize-bp (Default: 200kbp), \n    the region is too small for iSAFE
      analysis. Therefore, It's better to use --SAFE flag to report the SAFE scores
      of \n    the entire region instead of iSAFE scores."
    inputBinding:
      position: 101
      prefix: --SAFE
  - id: sample_case
    type:
      - 'null'
      - string
    doc: "<string>: Path to the file containing sample ID's of the case population.\n\
      \  * This option is only available in --format vcf.\n  * When this option is
      not used all the samples in the --input are considered as the case samples.\n\
      \  * This file must have two columns, the first one is population and the second
      column\n    is sample ID's (must be a subset of ID's used in the --input vcf
      file).\n  * This file must be TAB separated, no header, and comments by #.\n\
      \  * You must use --sample-case and --sample-cont when --input and --vcf-cont
      are the same (all samples are provided in a single vcf file).\n  * Population
      column (first column) can have more than one population name. They are all considered
      the case populations.\n  * Sample ID's must be subset of the --input vcf file"
    inputBinding:
      position: 101
      prefix: --sample-case
  - id: sample_cont
    type:
      - 'null'
      - string
    doc: "<string>: Path to the file containing sample ID's of the control population(s).\n\
      \  * This option is only available in --format vcf.\n  * When this option is
      not used all the samples in the --vcf-cont are considered as the control samples.\n\
      \  * This file must have two columns, the first one is population and the second
      column\n    is sample ID's (must be a subset of ID's used in the --vcf-cont
      file).\n  * This file must be TAB separated, no header, and comments by #.\n\
      \  * You must use --sample-case and --sample-cont when --input and --vcf-cont
      are the same (all samples are provided in a single vcf file).\n  * Population
      column (first column) can have more than one population name. They are all considered
      the control populations.\n  * Sample ID's must be subset of the --vcf-cont file"
    inputBinding:
      position: 101
      prefix: --sample-cont
  - id: status_off
    type:
      - 'null'
      - boolean
    doc: '<bool>: Set this flag to turn off printing status.'
    inputBinding:
      position: 101
      prefix: --StatusOff
  - id: step
    type:
      - 'null'
      - int
    doc: '<int>: Step size of sliding window in polymorphic sites.'
    inputBinding:
      position: 101
      prefix: --step
  - id: topk
    type:
      - 'null'
      - int
    doc: '<int>: Rank of SNPs used for learning window weights (alpha).'
    inputBinding:
      position: 101
      prefix: --topk
  - id: vcf_cont
    type:
      - 'null'
      - string
    doc: "<string>: Path to the phased control population.\n  * only accepts indexed
      bgzipped VCF (vcf.gz with index file) or indexed bcf files (.bcf with index
      file).\n  * This is optional but recommended for capturing fixed sweeps.\n \
      \ * This option is only available with --format vcf.\n  * You can choose a subset
      of samples in this file by using --sample-cont option,\n    otherwise all the
      samples in this file are cosidered as control population.\n  * You must use
      --sample-case and --sample-cont when --input and --vcf-cont are the same (all
      samples are provided in a single vcf file).\n  * You can (you don't have to)
      use 1000 Genome Project populations as control.\n    - Download link of phased
      VCF files of 1000GP (GRCh37/hg19): http://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/\n\
      \    - Download link of phased VCF files of 1000GP (GRCh38/hg38): http://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/supporting/GRCh38_positions/"
    inputBinding:
      position: 101
      prefix: --vcf-cont
  - id: warning_off
    type:
      - 'null'
      - boolean
    doc: '<bool>: Set this flag to turn off warnings.'
    inputBinding:
      position: 101
      prefix: --WarningOff
  - id: window
    type:
      - 'null'
      - int
    doc: '<int>: Sliding window size in polymorphic sites.'
    inputBinding:
      position: 101
      prefix: --window
outputs:
  - id: output
    type: File
    doc: "<string>: Path to the output(s).\n  * iSAFE generates <OUTPUT>.iSAFE.out\n\
      \  * When --OutputPsi is set, iSAFE generates <OUTPUT>.Psi.out in addition to
      <OUTPUT>.iSAFE.out"
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/isafe:1.1.1--pyh5e36f6f_0
