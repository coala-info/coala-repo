cwlVersion: v1.2
class: CommandLineTool
baseCommand: snippy
label: snippy
doc: fast bacterial variant calling from NGS reads
inputs:
  - id: citation
    type:
      - 'null'
      - boolean
    doc: Print citation for referencing snippy
    inputBinding:
      position: 101
      prefix: --citation
  - id: check
    type:
      - 'null'
      - boolean
    doc: Check dependences are installed then exit
    inputBinding:
      position: 101
      prefix: --check
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force overwrite of existing output folder
    inputBinding:
      position: 101
      prefix: --force
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: No screen output
    inputBinding:
      position: 101
      prefix: --quiet
  - id: cpus
    type:
      - 'null'
      - int
    doc: Maximum number of CPU cores to use
    inputBinding:
      position: 101
      prefix: --cpus
  - id: ram
    type:
      - 'null'
      - int
    doc: Try and keep RAM under this many GB
    inputBinding:
      position: 101
      prefix: --ram
  - id: tmpdir
    type:
      - 'null'
      - string
    doc: Fast temporary storage eg. local SSD
    inputBinding:
      position: 101
      prefix: --tmpdir
  - id: reference
    type:
      - 'null'
      - File
    doc: Reference genome. Supports FASTA, GenBank, EMBL (not GFF)
    secondaryFiles:
      - .fai
    inputBinding:
      position: 101
      prefix: --reference
  - id: r1
    type:
      - 'null'
      - File
    doc: Reads, paired-end R1 (left)
    inputBinding:
      position: 101
      prefix: --R1
  - id: r2
    type:
      - 'null'
      - File
    doc: Reads, paired-end R2 (right)
    inputBinding:
      position: 101
      prefix: --R2
  - id: se
    type:
      - 'null'
      - File
    doc: Single-end reads
    inputBinding:
      position: 101
      prefix: --se
  - id: ctgs
    type:
      - 'null'
      - File
    doc: Don't have reads use these contigs
    inputBinding:
      position: 101
      prefix: --ctgs
  - id: peil
    type:
      - 'null'
      - File
    doc: Reads, paired-end R1/R2 interleaved
    inputBinding:
      position: 101
      prefix: --peil
  - id: bam
    type:
      - 'null'
      - File
    doc: Use this BAM file instead of aligning reads
    inputBinding:
      position: 101
      prefix: --bam
  - id: targets
    type:
      - 'null'
      - File
    doc: Only call SNPs from this BED file
    inputBinding:
      position: 101
      prefix: --targets
  - id: subsample
    type:
      - 'null'
      - float
    doc: Subsample FASTQ to this proportion
    inputBinding:
      position: 101
      prefix: --subsample
  - id: outdir
    type:
      - 'null'
      - string
    doc: Output folder
    inputBinding:
      position: 101
      prefix: --outdir
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prefix for output files
    inputBinding:
      position: 101
      prefix: --prefix
  - id: report
    type:
      - 'null'
      - boolean
    doc: Produce report with visual alignment per variant
    inputBinding:
      position: 101
      prefix: --report
  - id: cleanup
    type:
      - 'null'
      - boolean
    doc: Remove most files not needed for snippy-core (inc. BAMs!)
    inputBinding:
      position: 101
      prefix: --cleanup
  - id: rgid
    type:
      - 'null'
      - string
    doc: 'Use this @RG ID: in the BAM header'
    inputBinding:
      position: 101
      prefix: --rgid
  - id: unmapped
    type:
      - 'null'
      - boolean
    doc: Keep unmapped reads in BAM and write FASTQ
    inputBinding:
      position: 101
      prefix: --unmapped
  - id: mapqual
    type:
      - 'null'
      - int
    doc: Minimum read mapping quality to consider
    inputBinding:
      position: 101
      prefix: --mapqual
  - id: basequal
    type:
      - 'null'
      - int
    doc: Minimum base quality to consider
    inputBinding:
      position: 101
      prefix: --basequal
  - id: mincov
    type:
      - 'null'
      - int
    doc: Minimum site depth to for calling alleles
    inputBinding:
      position: 101
      prefix: --mincov
  - id: minfrac
    type:
      - 'null'
      - float
    doc: Minumum proportion for variant evidence (0=AUTO)
    inputBinding:
      position: 101
      prefix: --minfrac
  - id: minqual
    type:
      - 'null'
      - float
    doc: Minumum QUALITY in VCF column 6
    inputBinding:
      position: 101
      prefix: --minqual
  - id: maxsoft
    type:
      - 'null'
      - int
    doc: Maximum soft clipping to allow
    inputBinding:
      position: 101
      prefix: --maxsoft
  - id: bwaopt
    type:
      - 'null'
      - string
    doc: Extra BWA MEM options, eg. -x pacbio
    inputBinding:
      position: 101
      prefix: --bwaopt
  - id: fbopt
    type:
      - 'null'
      - string
    doc: Extra Freebayes options, eg. --theta 1E-6 --read-snp-limit 2
    inputBinding:
      position: 101
      prefix: --fbopt
outputs:
  - id: output_outdir
    type:
      - 'null'
      - Directory
    doc: Output folder
    outputBinding:
      glob: $(inputs.outdir)
  - id: output_prefix
    type:
      - 'null'
      - File[]
    doc: Prefix for output files
    outputBinding:
      glob: $(inputs.prefix)*
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snippy:4.6.0--hdfd78af_6
s:url: https://github.com/tseemann/snippy
$namespaces:
  s: https://schema.org/
