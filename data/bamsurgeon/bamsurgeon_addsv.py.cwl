cwlVersion: v1.2
class: CommandLineTool
baseCommand: addsv.py
label: bamsurgeon_addsv.py
doc: "Adds SVs to reads, outputs modified reads as .bam along with mates.\n\nTool homepage: https://github.com/adamewing/bamsurgeon"
inputs:
  - id: varfile
    type: File
    doc: whitespace-delimited target regions for SV spike-in, see manual for syntax
    inputBinding:
      position: 101
      prefix: --varfile
  - id: input_bam
    type: File
    secondaryFiles:
      - .bai
    doc: sam/bam file from which to obtain reads
    inputBinding:
      position: 101
      prefix: --bamfile
  - id: reference_fasta
    type: File
    secondaryFiles:
      - .fai
      - .amb
      - .ann
      - .bwt
      - .pac
      - .sa
    doc: reference genome, fasta indexed with bwa index _and_ samtools faidx
    inputBinding:
      position: 101
      prefix: --reference
  - id: maxlibsize
    type:
      - 'null'
      - int
    doc: maximum fragment length of seq. library
    inputBinding:
      position: 101
      prefix: --maxlibsize
  - id: kmer
    type:
      - 'null'
      - int
    doc: kmer size for assembly (default = 31)
    inputBinding:
      position: 101
      prefix: --kmer
  - id: svfrac
    type:
      - 'null'
      - float
    doc: allele fraction of variant (default = 1.0)
    inputBinding:
      position: 101
      prefix: --svfrac
  - id: require_exact
    type:
      - 'null'
      - boolean
    doc: drop mutation if breakpoints cannot be made exactly as input
    inputBinding:
      position: 101
      prefix: --require_exact
  - id: mindepth
    type:
      - 'null'
      - int
    doc: minimum read depth in the breakend position to make mutation (default = 10)
    inputBinding:
      position: 101
      prefix: --mindepth
  - id: maxdepth
    type:
      - 'null'
      - int
    doc: maximum read depth in the breakend position to make mutation (default = 2000)
    inputBinding:
      position: 101
      prefix: --maxdepth
  - id: maxdfrac
    type:
      - 'null'
      - float
    doc: maximum discordant fraction (is_proper_pair / is_pair) of reads (default = 0.1)
    inputBinding:
      position: 101
      prefix: --maxdfrac
  - id: minctglen
    type:
      - 'null'
      - int
    doc: minimum length for contig generation, also used to pad assembly (default=4000)
    inputBinding:
      position: 101
      prefix: --minctglen
  - id: maxmuts
    type:
      - 'null'
      - int
    doc: maximum number of mutations to make
    inputBinding:
      position: 101
      prefix: -n
  - id: cnvfile
    type:
      - 'null'
      - File
    secondaryFiles:
      - pattern: .tbi
        required: false
    doc: tabix-indexed list of genome-wide absolute copy number values (e.g. 2
      alleles = no change)
    inputBinding:
      position: 101
      prefix: --cnvfile
  - id: donorbam
    type:
      - 'null'
      - File
    secondaryFiles:
      - pattern: .bai
        required: false
    doc: bam file for donor reads if using BIGDUP mutations
    inputBinding:
      position: 101
      prefix: --donorbam
  - id: ismean
    type:
      - 'null'
      - float
    doc: mean insert size (default = estimate from region)
    inputBinding:
      position: 101
      prefix: --ismean
  - id: issd
    type:
      - 'null'
      - float
    doc: insert size standard deviation (default = estimate from region)
    inputBinding:
      position: 101
      prefix: --issd
  - id: simerr
    type:
      - 'null'
      - float
    doc: error rate for wgsim-generated reads
    inputBinding:
      position: 101
      prefix: --simerr
  - id: procs
    type:
      - 'null'
      - int
    doc: split into multiple processes (default=1)
    inputBinding:
      position: 101
      prefix: --procs
  - id: inslib
    type:
      - 'null'
      - File
    doc: FASTA file containing library of possible insertions, use INS RND instead of INS filename to pick one
    inputBinding:
      position: 101
      prefix: --inslib
  - id: aligner
    type:
      - 'null'
      - string
    doc: 'supported aligners: backtrack,mem,novoalign'
    inputBinding:
      position: 101
      prefix: --aligner
  - id: alignopts
    type:
      - 'null'
      - string
    doc: 'aligner-specific options as comma delimited list of option1:value1,option2:value2,...'
    inputBinding:
      position: 101
      prefix: --alignopts
  - id: alignerthreads
    type:
      - 'null'
      - int
    doc: threads used per realignment (default = 1)
    inputBinding:
      position: 101
      prefix: --alignerthreads
  - id: tagreads
    type:
      - 'null'
      - boolean
    doc: add BS tag to altered reads
    inputBinding:
      position: 101
      prefix: --tagreads
  - id: skipmerge
    type:
      - 'null'
      - boolean
    doc: do not merge spike-in reads back into original BAM
    inputBinding:
      position: 101
      prefix: --skipmerge
  - id: keepsecondary
    type:
      - 'null'
      - boolean
    doc: keep secondary reads in final BAM
    inputBinding:
      position: 101
      prefix: --keepsecondary
  - id: debug
    type:
      - 'null'
      - boolean
    doc: output read tracking info to debug file, retain all intermediates
    inputBinding:
      position: 101
      prefix: --debug
  - id: tmpdir
    type:
      - 'null'
      - string
    doc: temporary directory (default=addsv.tmp)
    inputBinding:
      position: 101
      prefix: --tmpdir
  - id: seed
    type:
      - 'null'
      - int
    doc: seed random number generation
    inputBinding:
      position: 101
      prefix: --seed
  - id: allowN
    type:
      - 'null'
      - boolean
    doc: 'allow N in contigs, replace with A and warn user (default: drop mutation)'
    inputBinding:
      position: 101
      prefix: --allowN
  - id: output_bam_path
    type: string
    doc: .bam file name for output
    inputBinding:
      position: 102
      prefix: --outbam
outputs:
  - id: output_bam
    type:
      - 'null'
      - File
    doc: Output BAM file with the spiked-in variants
    outputBinding:
      glob: $(inputs.output_bam_path)
  - id: output_vcf
    type:
      - 'null'
      - File
    doc: VCF of the variants that were added
    outputBinding:
      glob: '*.addsv.*.vcf'
  - id: log_dir
    type:
      - 'null'
      - Directory
    doc: Per-mutation log directory
    outputBinding:
      glob: addsv_logs_$(inputs.output_bam_path.split('/').pop())
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bamsurgeon:1.4.1--pyhdfd78af_0
