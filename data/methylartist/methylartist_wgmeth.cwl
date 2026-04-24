cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - methylartist
  - wgmeth
label: methylartist_wgmeth
doc: "Whole-genome methylation calling and processing tool\n\nTool homepage: https://github.com/adamewing/methylartist"
inputs:
  - id: bam
    type: File
    doc: bam used for methylation calling
    inputBinding:
      position: 101
      prefix: --bam
  - id: binsize
    type:
      - 'null'
      - int
    doc: bin size for parallelisation
    inputBinding:
      position: 101
      prefix: --binsize
  - id: can_thresh
    type:
      - 'null'
      - float
    doc: canonical base threshold
    inputBinding:
      position: 101
      prefix: --can_thresh
  - id: chrom
    type:
      - 'null'
      - string
    doc: limit analysis to one chromosome
    inputBinding:
      position: 101
      prefix: --chrom
  - id: ctbam
    type:
      - 'null'
      - type: array
        items: string
    doc: specify which .bam(s) are C/T substitution data (can be 
      comma-delimited)
    inputBinding:
      position: 101
      prefix: --ctbam
  - id: dss
    type:
      - 'null'
      - boolean
    doc: output in DSS format (default = bedMethyl)
    inputBinding:
      position: 101
      prefix: --dss
  - id: fai
    type:
      - 'null'
      - File
    doc: fasta index (.fai), default = --ref + .fai, required for .db files
    inputBinding:
      position: 101
      prefix: --fai
  - id: max_read_density
    type:
      - 'null'
      - int
    doc: filter reads with call density greater >= value, can be helpful in 
      footprinting assays
    inputBinding:
      position: 101
      prefix: --max_read_density
  - id: meth_thresh
    type:
      - 'null'
      - float
    doc: modified base threshold
    inputBinding:
      position: 101
      prefix: --meth_thresh
  - id: methdb
    type:
      - 'null'
      - File
    doc: methylation database
    inputBinding:
      position: 101
      prefix: --methdb
  - id: min_mapq
    type:
      - 'null'
      - int
    doc: minimum mapping quality (mapq)
    inputBinding:
      position: 101
      prefix: --min_mapq
  - id: minlen
    type:
      - 'null'
      - int
    doc: minimum chromosome length
    inputBinding:
      position: 101
      prefix: --minlen
  - id: mod
    type:
      - 'null'
      - string
    doc: output for specific mod (names vary, see output for hints)
    inputBinding:
      position: 101
      prefix: --mod
  - id: motif
    type:
      - 'null'
      - string
    doc: expected modification motif (e.g. CG for 5mCpG required for mod bams)
    inputBinding:
      position: 101
      prefix: --motif
  - id: phased
    type:
      - 'null'
      - boolean
    doc: split output into phases (currently just 1,2)
    inputBinding:
      position: 101
      prefix: --phased
  - id: primary_only
    type:
      - 'null'
      - boolean
    doc: ignore non-primary alignments
    inputBinding:
      position: 101
      prefix: --primary_only
  - id: procs
    type:
      - 'null'
      - int
    doc: multiprocessing
    inputBinding:
      position: 101
      prefix: --procs
  - id: ref
    type:
      - 'null'
      - File
    doc: reference genome .fa (build .fai index with samtools faidx) (required 
      for mod bams)
    inputBinding:
      position: 101
      prefix: --ref
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: 'output file name (default: generated from input)'
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/methylartist:1.5.3--pyhdfd78af_0
