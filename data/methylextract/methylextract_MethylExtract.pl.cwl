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
    inputBinding:
      position: 101
      prefix: bedOut=
  - id: chrom_div
    type:
      - 'null'
      - int
    doc: number of chromosome divisions to sort reads
    inputBinding:
      position: 101
      prefix: chromDiv=
  - id: chrom_splitted
    type:
      - 'null'
      - string
    doc: skip alignment chromosome splitting, files must be chromosome splitted 
      and named by chromosome
    inputBinding:
      position: 101
      prefix: chromSplitted=
  - id: context
    type:
      - 'null'
      - string
    doc: 'methylation context to extract: CG, CHG, CHH or ALL'
    inputBinding:
      position: 101
      prefix: context=
  - id: del_dup
    type:
      - 'null'
      - string
    doc: 'delete duplicated reads: Y or N'
    inputBinding:
      position: 101
      prefix: delDup=
  - id: first_ignor
    type:
      - 'null'
      - int
    doc: number of first bases ignored (5' end)
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
    inputBinding:
      position: 101
      prefix: LastIgnor=
  - id: max_pval
    type:
      - 'null'
      - float
    doc: Variation p-value threshold
    inputBinding:
      position: 101
      prefix: maxPval=
  - id: max_strand_bias
    type:
      - 'null'
      - float
    doc: Maximum strand bias (0 deactivates the threshold)
    inputBinding:
      position: 101
      prefix: maxStrandBias=
  - id: mem_num_reads
    type:
      - 'null'
      - int
    doc: number of lines kept on memory for each thread
    inputBinding:
      position: 101
      prefix: memNumReads=
  - id: meth_non_cpgs
    type:
      - 'null'
      - float
    doc: nonCpG contexts methylated to discard read (0 deactivates bisulfite 
      read check)
    inputBinding:
      position: 101
      prefix: methNonCpGs=
  - id: min_depth_meth
    type:
      - 'null'
      - int
    doc: minimum number of reads requiered to consider a methylation value in a 
      certain position
    inputBinding:
      position: 101
      prefix: minDepthMeth=
  - id: min_depth_snv
    type:
      - 'null'
      - int
    doc: minimum number of reads requiered to consider a SNV value in a certain 
      position
    inputBinding:
      position: 101
      prefix: minDepthSNV=
  - id: min_q
    type:
      - 'null'
      - int
    doc: minimun PHRED quality per sequenced nucleotide
    inputBinding:
      position: 101
      prefix: minQ=
  - id: pe_overlap
    type:
      - 'null'
      - string
    doc: 'discard second mate overlapping segment on pair-end alignment reads: Y or
      N'
    inputBinding:
      position: 101
      prefix: peOverlap=
  - id: qscore
    type:
      - 'null'
      - string
    doc: 'fastq quality score: phred33-quals, phred64-quals, solexa-quals, solexa1.3-quals
      or NA'
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
    inputBinding:
      position: 101
      prefix: simDupPb=
  - id: threads
    type:
      - 'null'
      - int
    doc: threads number
    inputBinding:
      position: 101
      prefix: p=
  - id: var_fraction
    type:
      - 'null'
      - float
    doc: Minimum allele frequency
    inputBinding:
      position: 101
      prefix: varFraction=
  - id: wig_out
    type:
      - 'null'
      - string
    doc: methylation output in WIG format
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
