cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - perl
  - MethylExtract.pl
label: methylextract_MethylExtract.pl
doc: "MethylExtract is a tool for cytosine methylation profiling and SNV calling from
  bisulfite sequencing data.\n\nTool homepage: http://bioinfo2.ugr.es/MethylExtract/"
inputs:
  - id: bed_out
    type:
      - 'null'
      - string
    doc: methylation output in BED format
    default: N
    inputBinding:
      position: 101
      prefix: bedOut=
  - id: chrom_div
    type:
      - 'null'
      - int
    doc: number of chromosome divisions to sort reads
    default: 400
    inputBinding:
      position: 101
      prefix: chromDiv=
  - id: chrom_splitted
    type:
      - 'null'
      - string
    doc: skip alignment chromosome splitting, files must be chromosome splitted 
      and named by chromosome
    default: N
    inputBinding:
      position: 101
      prefix: chromSplitted=
  - id: context
    type:
      - 'null'
      - string
    doc: 'methylation context to extract: CG, CHG, CHH or ALL'
    default: CG
    inputBinding:
      position: 101
      prefix: context=
  - id: del_dup
    type:
      - 'null'
      - string
    doc: 'delete duplicated reads: Y or N'
    default: N
    inputBinding:
      position: 101
      prefix: delDup=
  - id: first_ignor
    type:
      - 'null'
      - int
    doc: number of first bases ignored (5' end)
    default: 0
    inputBinding:
      position: 101
      prefix: FirstIgnor=
  - id: flag_c
    type:
      type: array
      items: string
    doc: Crick FLAGs (multiple FLAGs comma separated)
    inputBinding:
      position: 101
      prefix: flagC=
  - id: flag_w
    type:
      type: array
      items: string
    doc: Watson FLAGs (multiple FLAGs comma separated)
    inputBinding:
      position: 101
      prefix: flagW=
  - id: in_dir
    type: Directory
    doc: alignments' directory
    inputBinding:
      position: 101
      prefix: inDir=
  - id: last_ignor
    type:
      - 'null'
      - int
    doc: number of last bases ignored (3' end)
    default: 0
    inputBinding:
      position: 101
      prefix: LastIgnor=
  - id: max_pval
    type:
      - 'null'
      - float
    doc: Variation p-value threshold
    default: 0.05
    inputBinding:
      position: 101
      prefix: maxPval=
  - id: max_strand_bias
    type:
      - 'null'
      - float
    doc: Maximum strand bias (0 deactivates the threshold)
    default: 0.7
    inputBinding:
      position: 101
      prefix: maxStrandBias=
  - id: mem_num_reads
    type:
      - 'null'
      - int
    doc: number of lines kept on memory for each thread
    default: 200000
    inputBinding:
      position: 101
      prefix: memNumReads=
  - id: meth_non_cpgs
    type:
      - 'null'
      - float
    doc: nonCpG contexts methylated to discard read (0 deactivates bisulfite 
      read check)
    default: 0.9
    inputBinding:
      position: 101
      prefix: methNonCpGs=
  - id: min_depth_meth
    type:
      - 'null'
      - int
    doc: minimum number of reads requiered to consider a methylation value in a 
      certain position
    default: 1
    inputBinding:
      position: 101
      prefix: minDepthMeth=
  - id: min_depth_snv
    type:
      - 'null'
      - int
    doc: minimum number of reads requiered to consider a SNV value in a certain 
      position
    default: 1
    inputBinding:
      position: 101
      prefix: minDepthSNV=
  - id: min_q
    type:
      - 'null'
      - int
    doc: minimun PHRED quality per sequenced nucleotide
    default: 20
    inputBinding:
      position: 101
      prefix: minQ=
  - id: pe_overlap
    type:
      - 'null'
      - string
    doc: 'discard second mate overlapping segment on pair-end alignment reads: Y or
      N'
    default: N
    inputBinding:
      position: 101
      prefix: peOverlap=
  - id: qscore
    type:
      - 'null'
      - string
    doc: 'fastq quality score: phred33-quals, phred64-quals, solexa-quals, solexa1.3-quals
      or NA'
    default: phred33-quals
    inputBinding:
      position: 101
      prefix: qscore=
  - id: seq
    type: File
    doc: sequences directory or multifasta single file
    inputBinding:
      position: 101
      prefix: seq=
  - id: sim_dup_pb
    type:
      - 'null'
      - int
    doc: number of similar nucleotides to detect a duplicated read
    default: 32
    inputBinding:
      position: 101
      prefix: simDupPb=
  - id: threads
    type:
      - 'null'
      - int
    doc: threads number
    default: 4
    inputBinding:
      position: 101
      prefix: p=
  - id: var_fraction
    type:
      - 'null'
      - float
    doc: Minimum allele frequency
    default: 0.1
    inputBinding:
      position: 101
      prefix: varFraction=
  - id: wig_out
    type:
      - 'null'
      - string
    doc: methylation output in WIG format
    default: N
    inputBinding:
      position: 101
      prefix: wigOut=
outputs:
  - id: out_dir
    type:
      - 'null'
      - Directory
    doc: output directory
    outputBinding:
      glob: $(inputs.out_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/methylextract:1.9.1--0
