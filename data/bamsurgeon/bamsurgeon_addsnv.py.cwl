cwlVersion: v1.2
class: CommandLineTool
baseCommand: addsnv.py
label: bamsurgeon_addsnv.py
doc: "Add SNVs to reads, outputs modified reads as .bam along with mates.\n\nTool homepage: https://github.com/adamewing/bamsurgeon"
inputs:
  - id: varfile
    type: File
    doc: Target regions to try and add a SNV, as BED
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
  - id: snvfrac
    type:
      - 'null'
      - float
    doc: maximum allowable linked SNP MAF (for avoiding haplotypes) (default = 1)
    inputBinding:
      position: 101
      prefix: --snvfrac
  - id: mutfrac
    type:
      - 'null'
      - float
    doc: allelic fraction at which to make SNVs (default = 0.5)
    inputBinding:
      position: 101
      prefix: --mutfrac
  - id: numsnvs
    type:
      - 'null'
      - int
    doc: 'maximum number of mutations to try (default: entire input)'
    inputBinding:
      position: 101
      prefix: --numsnvs
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
  - id: coverdiff
    type:
      - 'null'
      - float
    doc: allow difference in input and output coverage (default=0.9)
    inputBinding:
      position: 101
      prefix: --coverdiff
  - id: haplosize
    type:
      - 'null'
      - string
    doc: haplotype size (default = 0); 'auto' is also accepted
    inputBinding:
      position: 101
      prefix: --haplosize
  - id: procs
    type:
      - 'null'
      - int
    doc: split into multiple processes (default=1)
    inputBinding:
      position: 101
      prefix: --procs
  - id: picardjar
    type:
      - 'null'
      - File
    doc: path to picard.jar, required for most aligners
    inputBinding:
      position: 101
      prefix: --picardjar
  - id: mindepth
    type:
      - 'null'
      - int
    doc: minimum read depth to make mutation (default = 10)
    inputBinding:
      position: 101
      prefix: --mindepth
  - id: maxdepth
    type:
      - 'null'
      - int
    doc: maximum read depth to make mutation (default = 2000)
    inputBinding:
      position: 101
      prefix: --maxdepth
  - id: minmutreads
    type:
      - 'null'
      - int
    doc: minimum number of mutated reads to output per site
    inputBinding:
      position: 101
      prefix: --minmutreads
  - id: avoidreads
    type:
      - 'null'
      - File
    doc: file of read names to avoid (mutations will be skipped if overlap)
    inputBinding:
      position: 101
      prefix: --avoidreads
  - id: nomut
    type:
      - 'null'
      - boolean
    doc: dry run
    inputBinding:
      position: 101
      prefix: --nomut
  - id: ignoresnps
    type:
      - 'null'
      - boolean
    doc: make mutations even if there are non-reference alleles sharing the relevant reads
    inputBinding:
      position: 101
      prefix: --ignoresnps
  - id: ignoreref
    type:
      - 'null'
      - boolean
    doc: make mutations even if the mutation is back to the reference allele
    inputBinding:
      position: 101
      prefix: --ignoreref
  - id: force
    type:
      - 'null'
      - boolean
    doc: force mutation to happen regardless of nearby SNP or low coverage
    inputBinding:
      position: 101
      prefix: --force
  - id: insane
    type:
      - 'null'
      - boolean
    doc: ignore sanity check enforcing input read count = output read count in realignment
    inputBinding:
      position: 101
      prefix: --insane
  - id: single
    type:
      - 'null'
      - boolean
    doc: input BAM is single-ended (default is paired-end)
    inputBinding:
      position: 101
      prefix: --single
  - id: maxopen
    type:
      - 'null'
      - int
    doc: maximum number of open files during merge (default 1000)
    inputBinding:
      position: 101
      prefix: --maxopen
  - id: requirepaired
    type:
      - 'null'
      - boolean
    doc: skip mutations if unpaired reads are present
    inputBinding:
      position: 101
      prefix: --requirepaired
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
    doc: final output is tmp file to be merged
    inputBinding:
      position: 101
      prefix: --skipmerge
  - id: ignorepileup
    type:
      - 'null'
      - boolean
    doc: do not check pileup depth in mutation regions
    inputBinding:
      position: 101
      prefix: --ignorepileup
  - id: aligner
    type:
      - 'null'
      - string
    doc: 'supported aligners: backtrack,mem,novoalign,gsnap,STAR,bowtie2,tmap,bwakit,minimap2'
    inputBinding:
      position: 101
      prefix: --aligner
  - id: alignerthreads
    type:
      - 'null'
      - int
    doc: threads used per realignment (default = 1)
    inputBinding:
      position: 101
      prefix: --alignerthreads
  - id: alignopts
    type:
      - 'null'
      - string
    doc: 'aligner-specific options as comma delimited list of option1:value1,option2:value2,...'
    inputBinding:
      position: 101
      prefix: --alignopts
  - id: tmpdir
    type:
      - 'null'
      - string
    doc: temporary directory (default=addsnv.tmp)
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
      glob: '*.addsnv.*.vcf'
  - id: log_dir
    type:
      - 'null'
      - Directory
    doc: Per-mutation log directory
    outputBinding:
      glob: addsnv_logs_$(inputs.output_bam_path.split('/').pop())
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bamsurgeon:1.4.1--pyhdfd78af_0
