cwlVersion: v1.2
class: CommandLineTool
baseCommand: duet
label: duet
doc: "SNP-Assisted Structural Variant Calling and Phasing Using Oxford Nanopore Sequencing\n\
  \nTool homepage: https://github.com/yekaizhou/duet"
inputs:
  - id: bam
    type: File
    doc: sorted alignment file in .bam format (along with .bai file in the same 
      directory)
    inputBinding:
      position: 1
  - id: reference
    type: File
    doc: indexed reference genome in .fasta format (along with .fai file in the 
      same directory)
    inputBinding:
      position: 2
  - id: output
    type: Directory
    doc: working and output directory (existing files in the directory will be 
      overwritten)
    inputBinding:
      position: 3
  - id: cluster_max_distance
    type:
      - 'null'
      - float
    doc: maximum span-position distance between SV marks in a cluster to call a 
      SV candidates, when the base SV caller is SVIM
    inputBinding:
      position: 104
      prefix: --cluster_max_distance
  - id: include_all_ctgs
    type:
      - 'null'
      - boolean
    doc: call variants on all contigs, otherwise call chr{1..22,X,Y}
    inputBinding:
      position: 104
      prefix: --include_all_ctgs
  - id: min_allele_frequency
    type:
      - 'null'
      - float
    doc: minimum allele frequency required to call a candidate SNP
    inputBinding:
      position: 104
      prefix: --min_allele_frequency
  - id: min_support_read
    type:
      - 'null'
      - int
    doc: minimum number of reads that support a SV to be reported
    inputBinding:
      position: 104
      prefix: --min_support_read
  - id: sv_caller
    type:
      - 'null'
      - string
    doc: choose the base SV caller from cuteSV ("cutesv"), Sniffles (sniffles), 
      or SVIM ("svim")
    inputBinding:
      position: 104
      prefix: --sv_caller
  - id: sv_min_size
    type:
      - 'null'
      - int
    doc: minimum SV size to be reported
    inputBinding:
      position: 104
      prefix: --sv_min_size
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads to use
    inputBinding:
      position: 104
      prefix: --thread
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/duet:1.0--pyhdfd78af_0
stdout: duet.out
