cwlVersion: v1.2
class: CommandLineTool
baseCommand: StrainScan.py
label: strainscan
doc: "A kmer-based strain-level identification tool.\n\nTool homepage: https://github.com/liaoherui/StrainScan"
inputs:
  - id: database_dir
    type: Directory
    doc: The dir of your database
    inputBinding:
      position: 101
      prefix: --database_dir
  - id: extraRegion_mode
    type:
      - 'null'
      - int
    doc: If this parameter is set to 1, the intra-cluster searching process will
      search possible strains and return strains with extra regions (could be 
      different genes, SNVs or SVs to the possible strains) covered.
    inputBinding:
      position: 101
      prefix: --extraRegion_mode
  - id: input_fastq
    type: File
    doc: The dir of input fastq data
    inputBinding:
      position: 101
      prefix: --input_fastq
  - id: input_fastq_2
    type:
      - 'null'
      - File
    doc: The dir of input fastq data (for pair-end data).
    inputBinding:
      position: 101
      prefix: --input_fastq_2
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: The size of kmer, should be odd number.
    inputBinding:
      position: 101
      prefix: --kmer_size
  - id: low_dep
    type:
      - 'null'
      - string
    doc: This parameter can be set to "1" if the sequencing depth of input data 
      is very low (e.g. < 10x). For super low depth ( < 1x ), you can use "-l 2"
    inputBinding:
      position: 101
      prefix: --low_dep
  - id: minimum_snv_num
    type:
      - 'null'
      - int
    doc: The minimum number of SNV at Layer-2 identification.
    inputBinding:
      position: 101
      prefix: --minimum_snv_num
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Output dir
    inputBinding:
      position: 101
      prefix: --output_dir
  - id: plasmid_mode
    type:
      - 'null'
      - int
    doc: If this parameter is set to 1, the intra-cluster searching process will
      search possible plasmids using short contigs (<100000 bp) in strain 
      genomes, which are likely to be plasmids. If this parameter is set to 2, 
      the intra-cluster searching process will search possible strains using 
      given reference genomes by "-r". Reference genome sequences (-r) are 
      required if this mode is used.
    inputBinding:
      position: 101
      prefix: --plasmid_mode
  - id: ref_genome
    type:
      - 'null'
      - Directory
    doc: The dir of reference genomes of identified cluster or all strains. If 
      plasmid_mode is used, then this parameter is required.
    inputBinding:
      position: 101
      prefix: --ref_genome
  - id: strain_prob
    type:
      - 'null'
      - int
    doc: If this parameter is set to 1, then the algorithm will output the 
      probabolity of detecting a strain (or cluster) in low-depth (e.g. <1x) 
      samples.
    inputBinding:
      position: 101
      prefix: --strain_prob
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/strainscan:1.0.14--pyhdfd78af_1
stdout: strainscan.out
