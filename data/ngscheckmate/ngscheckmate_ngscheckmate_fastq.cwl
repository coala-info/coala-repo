cwlVersion: v1.2
class: CommandLineTool
baseCommand: ngscheckmate_fastq
label: ngscheckmate_ngscheckmate_fastq
doc: "Counts reads that match the SNP flanking sequences of a pattern file in a
  FASTQ file and prints the reference and alternative counts and the variant allele
  fraction (VAF) per SNP site to standard output.\n\nTool homepage: https://github.com/parklab/NGSCheckMate"
inputs:
  - id: fastq1
    type: File
    doc: fastq file for SE data or first fastq file for a PE data. File can be 
      gzipped (auto-detect).
    inputBinding:
      position: 1
      prefix: '-1'
  - id: fastq2
    type:
      - 'null'
      - File
    doc: second fastq file for a PE data. File can be gzipped (auto-detect)
    inputBinding:
      position: 1
      prefix: '-2'
  - id: subsampling_rate
    type:
      - 'null'
      - float
    doc: subsampling rate (default 1.0)
    inputBinding:
      position: 1
      prefix: -s
  - id: desired_depth
    type:
      - 'null'
      - int
    doc: as an alternative to a user-defined subsampling rate, let the program 
      compute the subsampling rate given a user-defined desired_depth and the 
      data.
    inputBinding:
      position: 1
      prefix: -d
  - id: reference_length
    type:
      - 'null'
      - float
    doc: The reference length (default 3E9) to be used for computing 
      subsampling rate. If the data is NOT WGS from human, and if you are using
      the -d option, it is highly recommended to specify the reference length.
    inputBinding:
      position: 1
      prefix: -R
  - id: pattern_length
    type:
      - 'null'
      - int
    doc: The length of the flanking sequences being used to identify SNV sites. 
      Default is 21bp. It is recommended not to change this value, unless you 
      have created your own pattern file with a different pattern length.
    inputBinding:
      position: 1
      prefix: -L
  - id: maxthread
    type:
      - 'null'
      - int
    doc: number of threads to use (default 1)
    inputBinding:
      position: 1
      prefix: -p
  - id: patternfile
    type: File
    doc: a binary file containing sequences flanking representative snv sites, 
      along with markers indicating the snv index and whether the sequence 
      represents reference or alternative allele.
    inputBinding:
      position: 2
outputs:
  - id: vaf_table
    type: stdout
    doc: Tab-separated table with index, ref, alt and vaf per SNP site
stdout: ngscheckmate_fastq.vaf.txt
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngscheckmate:1.0.1--py312pl5321h577a1d6_4
