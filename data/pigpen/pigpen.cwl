cwlVersion: v1.2
class: CommandLineTool
baseCommand: pigpen
label: pigpen
doc: "Pipeline for Identification Of Guanosine Positions Erroneously Notated\n\nTool
  homepage: https://github.com/TaliaferroLab/OINC-seq"
inputs:
  - id: ROIbed
    type:
      - 'null'
      - File
    doc: Optional. Bed file of specific regions of interest in which to quantify
      conversions. If supplied, only conversions in these regions will be 
      quantified.
    inputBinding:
      position: 101
      prefix: --ROIbed
  - id: SNPcoverage
    type:
      - 'null'
      - int
    doc: Minimum coverage to call SNPs. Default = 20
    default: 20
    inputBinding:
      position: 101
      prefix: --SNPcoverage
  - id: SNPfreq
    type:
      - 'null'
      - float
    doc: Minimum variant frequency to call SNPs. Default = 0.4
    default: 0.4
    inputBinding:
      position: 101
      prefix: --SNPfreq
  - id: controlsamples
    type:
      - 'null'
      - string
    doc: Comma separated list of control samples (i.e. those where no *induced* 
      conversions are expected). May be a subset of samplenames. Required if 
      SNPs are to be considered and a snpfile is not supplied.
    inputBinding:
      position: 101
      prefix: --controlsamples
  - id: datatype
    type: string
    doc: Single end or paired end data?
    inputBinding:
      position: 101
      prefix: --datatype
  - id: genomefasta
    type:
      - 'null'
      - File
    doc: Genome sequence in fasta format. Required if SNPs are to be considered.
    inputBinding:
      position: 101
      prefix: --genomeFasta
  - id: gff
    type:
      - 'null'
      - File
    doc: Genome annotation in gff format.
    inputBinding:
      position: 101
      prefix: --gff
  - id: gfftype
    type: string
    doc: Source of genome annotation file.
    inputBinding:
      position: 101
      prefix: --gfftype
  - id: maskbed
    type:
      - 'null'
      - File
    doc: Optional. Bed file of positions to mask from analysis.
    inputBinding:
      position: 101
      prefix: --maskbed
  - id: minMappingQual
    type: int
    doc: Minimum mapping quality for a read to be considered in conversion 
      counting. STAR unique mappers have MAPQ 255.
    inputBinding:
      position: 101
      prefix: --minMappingQual
  - id: minPhred
    type:
      - 'null'
      - int
    doc: Minimum phred quality score for a base to be considered. Default = 30
    default: 30
    inputBinding:
      position: 101
      prefix: --minPhred
  - id: nConv
    type:
      - 'null'
      - int
    doc: Minimum number of required G->T and/or G->C conversions in a read pair 
      in order for those conversions to be counted. Default is 1.
    default: 1
    inputBinding:
      position: 101
      prefix: --nConv
  - id: nproc
    type:
      - 'null'
      - int
    doc: Number of processors to use. Default is 1.
    default: 1
    inputBinding:
      position: 101
      prefix: --nproc
  - id: onlyConsiderOverlap
    type:
      - 'null'
      - boolean
    doc: Only consider conversions seen in both reads of a read pair? Only 
      possible with paired end data.
    inputBinding:
      position: 101
      prefix: --onlyConsiderOverlap
  - id: samplenames
    type: string
    doc: Comma separated list of samples to quantify.
    inputBinding:
      position: 101
      prefix: --samplenames
  - id: snpfile
    type:
      - 'null'
      - File
    doc: VCF file of snps to mask. If --useSNPs but a --snpfile is not supplied,
      a VCF of snps will be created using --controlsamples.
    inputBinding:
      position: 101
      prefix: --snpfile
  - id: useSNPs
    type:
      - 'null'
      - boolean
    doc: Consider SNPs?
    inputBinding:
      position: 101
      prefix: --useSNPs
  - id: use_g_c
    type:
      - 'null'
      - boolean
    doc: Consider G->C conversions?
    inputBinding:
      position: 101
      prefix: --use_g_c
  - id: use_g_t
    type:
      - 'null'
      - boolean
    doc: Consider G->T conversions?
    inputBinding:
      position: 101
      prefix: --use_g_t
  - id: use_g_x
    type:
      - 'null'
      - boolean
    doc: Consider G->deletion conversions?
    inputBinding:
      position: 101
      prefix: --use_g_x
  - id: use_ng_xg
    type:
      - 'null'
      - boolean
    doc: Consider NG->deletionG conversions?
    inputBinding:
      position: 101
      prefix: --use_ng_xg
  - id: use_read1
    type:
      - 'null'
      - boolean
    doc: Use read1 when looking for conversions? Only useful with paired end 
      data.
    inputBinding:
      position: 101
      prefix: --use_read1
  - id: use_read2
    type:
      - 'null'
      - boolean
    doc: Use read2 when looking for conversions? Only useful with paired end 
      data.
    inputBinding:
      position: 101
      prefix: --use_read2
outputs:
  - id: outputDir
    type: Directory
    doc: Output directory.
    outputBinding:
      glob: $(inputs.outputDir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pigpen:0.0.9--pyhdfd78af_0
