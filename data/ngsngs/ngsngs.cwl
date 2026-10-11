cwlVersion: v1.2
class: CommandLineTool
baseCommand: ngsngs
label: ngsngs
doc: "Next Generation Simulator for Next Generator Sequencing Data. Simulates single-end or paired-end reads (fasta, fastq, SAM, BAM or CRAM) from a reference genome with fragment length distributions, quality profiles, sequencing errors, variants, indels and post-mortem damage.\n\nTool homepage: https://github.com/RAHenriksen/NGSNGS"
inputs:
  - id: input_reference
    type: File
    doc: "Reference file in fasta format (.fa,.fasta) to sample reads."
    inputBinding:
      position: 1
      prefix: -i
      valueFrom: $(self.basename)
  - id: reads
    type:
      - 'null'
      - int
    doc: "Number of reads to simulate, conflicts with -c option."
    inputBinding:
      position: 2
      prefix: -r
  - id: coverage
    type:
      - 'null'
      - float
    doc: "Depth of Coverage to simulate, conflicts with -r option."
    inputBinding:
      position: 3
      prefix: -c
  - id: length
    type:
      - 'null'
      - int
    doc: "Fixed length of simulated fragments, conflicts with -lf & -ld option."
    inputBinding:
      position: 4
      prefix: -l
  - id: length_file
    type:
      - 'null'
      - File
    doc: "CDF of a length distribution, conflicts with -l & -ld option."
    inputBinding:
      position: 5
      prefix: -lf
  - id: length_dist
    type:
      - 'null'
      - string
    doc: "Discrete or continuous probability distributions, given their probability density function, conflicts with -l & -lf option. Uni,Min,Max; Norm,Mean,Variance; LogNorm,Mean,Variance; Pois,Rate; Exp,Rate; Gam,Shape,Scale (for example Pois,165)."
    inputBinding:
      position: 6
      prefix: -ld
  - id: sequencing
    type: string
    doc: "Simulate single-end (SE) or paired-end (PE) reads."
    inputBinding:
      position: 7
      prefix: -seq
  - id: format
    type: string
    doc: "File format of the simulated output reads: fa, fa.gz, fq, fq.gz, sam, bam or cram."
    inputBinding:
      position: 8
      prefix: -f
  - id: output
    type: string
    doc: "Prefix of output file name."
    inputBinding:
      position: 9
      prefix: -o
  - id: quality1
    type:
      - 'null'
      - File
    doc: "Read quality profile for single-end reads (SE) or first read pair (PE) for fastq or sequence alignment map formats."
    inputBinding:
      position: 10
      prefix: -q1
  - id: quality2
    type:
      - 'null'
      - File
    doc: "Read quality profile for second read pair (PE) for fastq or sequence alignment map formats."
    inputBinding:
      position: 11
      prefix: -q2
  - id: quality_score
    type:
      - 'null'
      - int
    doc: "Fixed quality score, for both read pairs in fastq or sequence alignment map formats. It overwrites the quality profiles."
    inputBinding:
      position: 12
      prefix: -qs
  - id: vcf
    type:
      - 'null'
      - File
    doc: "Variant Calling Format (.vcf) or binary format (.bcf)."
    inputBinding:
      position: 13
      prefix: -vcf
  - id: indiv
    type:
      - 'null'
      - int
    doc: "Integer value (0 - index) for the number of a specific individual defined in the bcf header from the -vcf/-bcf input file, default = -1 (no individual selected)."
    inputBinding:
      position: 14
      prefix: -id
  - id: dump_vcf
    type:
      - 'null'
      - string
    doc: "The prefix of an internally generated fasta file, containing the sequences representing the haplotypes with the variations from the provided vcf file."
    inputBinding:
      position: 15
      prefix: -DumpVCF
  - id: indel
    type:
      - 'null'
      - string
    doc: "Input probabilities and lambda values for a geometric distribution randomly generating insertions and deletions of a random length: InsProb,DelProb,InsParam,DelParam (for example 0.05,0.1,0.1,0.2)."
    inputBinding:
      position: 16
      prefix: -indel
  - id: dump_indel
    type:
      - 'null'
      - string
    doc: "The prefix of an internally generated txt file, containing the read id, number of indels, the number of indel operations saving the position before and after and length of the indel, simulated read length before and after."
    inputBinding:
      position: 17
      prefix: -DumpIndel
  - id: model
    type:
      - 'null'
      - string
    doc: "Choice of deamination model: b,nv,Lambda,Delta_s,Delta_d (or briggs,...) or b7,nv,Lambda,Delta_s,Delta_d (or briggs07,...). nv is the nick rate per site, Lambda the geometric distribution parameter for overhang length, Delta_s the PMD rate in single-strand regions and Delta_d the PMD rate in double-strand regions."
    inputBinding:
      position: 18
      prefix: -m
  - id: duplicates
    type:
      - 'null'
      - int
    doc: "Number of PCR duplicates (1, 2 or 4), used in conjunction with the briggs modern library prep model. Default = 1."
    inputBinding:
      position: 19
      prefix: -dup
  - id: mismatch
    type:
      - 'null'
      - File
    doc: "Nucleotide substitution frequency file."
    inputBinding:
      position: 20
      prefix: -mf
  - id: noerror
    type:
      - 'null'
      - boolean
    doc: "Disabling the sequencing error substitutions based on nucleotide qualities from the provided quality profiles -q1 and -q2."
    inputBinding:
      position: 21
      prefix: -ne
  - id: noalign
    type:
      - 'null'
      - boolean
    doc: "Using the SAM output as a sequence container without alignment information."
    inputBinding:
      position: 22
      prefix: -na
  - id: cycle
    type:
      - 'null'
      - int
    doc: "Read cycle length, the maximum length of sequence reads, if not provided the cycle length will be inferred from quality profiles (q1,q2)."
    inputBinding:
      position: 23
      prefix: -cl
  - id: lowerlimit
    type:
      - 'null'
      - int
    doc: "Lower fragment length limit, default = 30. The minimum fragment length for deamination is 30, so simulated fragments below will be fixed at 30."
    inputBinding:
      position: 24
      prefix: -ll
  - id: bufferlength
    type:
      - 'null'
      - int
    doc: "Buffer length for generated sequence reads stored in the output files, default = 30000000."
    inputBinding:
      position: 25
      prefix: -bl
  - id: chromosomes
    type:
      - 'null'
      - string
    doc: "Specific chromosomes from the input reference file to simulate from."
    inputBinding:
      position: 26
      prefix: -chr
  - id: adapter1
    type:
      - 'null'
      - string
    doc: "Adapter sequence to add for simulated reads (SE) or first read pair (PE)."
    inputBinding:
      position: 27
      prefix: -a1
  - id: adapter2
    type:
      - 'null'
      - string
    doc: "Adapter sequence to add for second read pair (PE)."
    inputBinding:
      position: 28
      prefix: -a2
  - id: poly
    type:
      - 'null'
      - string
    doc: "Create Poly(X) tails for reads, containing adapters with lengths below the inferred read cycle length, for example G or A."
    inputBinding:
      position: 29
      prefix: -p
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of sampling threads, default = 1."
    inputBinding:
      position: 30
      prefix: -t
  - id: threads2
    type:
      - 'null'
      - int
    doc: "Number of compression threads, default = 0."
    inputBinding:
      position: 31
      prefix: -t2
  - id: seed
    type:
      - 'null'
      - int
    doc: "Random seed, default = current calendar time (s)."
    inputBinding:
      position: 32
      prefix: -s
  - id: rand
    type:
      - 'null'
      - int
    doc: "Pseudo-random number generator, OS specific: 0 drand48_r (default for linux), 1 std::uniform_int_distribution, 2 rand_r, 3 erand48 (default for MacOS)."
    inputBinding:
      position: 33
      prefix: -rng
outputs:
  - id: output_files
    type:
      type: array
      items: File
    doc: Simulated reads (<output>*.fq/.fa/.sam/.bam/.cram, _R1/_R2 for paired-end) and the optional dump files
    outputBinding:
      glob:
        - $(inputs.output)*
        - $(inputs.dump_vcf)*
        - $(inputs.dump_indel)*
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.input_reference)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngsngs:0.9.2--hce60e53_0
