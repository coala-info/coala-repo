cwlVersion: v1.2
class: CommandLineTool
baseCommand: bs_seeker2-call_methylation.py
label: bs-seeker2_bs_seeker2-call_methylation.py
doc: "Call methylation status from BAM files.\n\nTool homepage: http://pellegrini.mcdb.ucla.edu/BS_Seeker2/"
inputs:
  - id: db_path
    type:
      - 'null'
      - Directory
    doc: Path to the reference genome library (generated in preprocessing 
      genome)
    inputBinding:
      position: 101
      prefix: --db
  - id: input_file
    type:
      - 'null'
      - File
    doc: BAM output from bs_seeker2-align.py
    inputBinding:
      position: 101
      prefix: --input
  - id: pileup_maxdepth
    type:
      - 'null'
      - int
    doc: The max number of read depth can be called for each position. Parameter
      passing to pysam. Large number costs more time.
    inputBinding:
      position: 101
      prefix: --pileup-maxdepth
  - id: read_no
    type:
      - 'null'
      - int
    doc: The least number of reads covering one site to be shown in wig file
    inputBinding:
      position: 101
      prefix: --read-no
  - id: rm_ccgg
    type:
      - 'null'
      - boolean
    doc: Removed sites located in CCGG, avoiding the bias introduced by 
      artificial DNA methylation status 'XS:i:1', which would be considered as 
      not fully converted by bisulfite treatment
    inputBinding:
      position: 101
      prefix: --rm-CCGG
  - id: rm_overlap
    type:
      - 'null'
      - boolean
    doc: Removed one mate if two mates are overlapped, for paired-end data
    inputBinding:
      position: 101
      prefix: --rm-overlap
  - id: rm_sx
    type:
      - 'null'
      - boolean
    doc: Removed reads with tag 'XS:i:1', which would be considered as not fully
      converted by bisulfite treatment
    inputBinding:
      position: 101
      prefix: --rm-SX
  - id: sorted
    type:
      - 'null'
      - boolean
    doc: Specify when the input bam file is already sorted, the sorting step 
      will be skipped
    inputBinding:
      position: 101
      prefix: --sorted
  - id: txt
    type:
      - 'null'
      - boolean
    doc: When specified, output file will be stored in plain text instead of 
      compressed version (.gz)
    inputBinding:
      position: 101
      prefix: --txt
outputs:
  - id: output_prefix
    type:
      - 'null'
      - File
    doc: The output prefix to create ATCGmap and wiggle files. Three files 
      (ATCGmap, CGmap, wig) will be generated if specified. Omit this if only to
      generate specific format.
    outputBinding:
      glob: $(inputs.output_prefix)
  - id: wig_outfile
    type:
      - 'null'
      - File
    doc: 'Filename for wig file. Ex: output.wig, or output.wig.gz. Can be overwritten
      by "-o".'
    outputBinding:
      glob: $(inputs.wig_outfile)
  - id: cgmap_outfile
    type:
      - 'null'
      - File
    doc: 'Filename for CGmap file. Ex: output.CGmap, or output.CGmap.gz. Can be overwritten
      by "-o".'
    outputBinding:
      glob: $(inputs.cgmap_outfile)
  - id: atcgmap_outfile
    type:
      - 'null'
      - File
    doc: 'Filename for ATCGmap file. Ex: output.ATCGmap, or output.ATCGmap.gz. Can
      be overwritten by "-o".'
    outputBinding:
      glob: $(inputs.atcgmap_outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bs-seeker2:2.1.7--0
