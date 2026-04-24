cwlVersion: v1.2
class: CommandLineTool
baseCommand: counterr
label: counterr
doc: "Counterr is a tool for analyzing BAM files.\n\nTool homepage: https://github.com/dayzerodx/counterr"
inputs:
  - id: bai
    type:
      - 'null'
      - File
    doc: the input bai filename if non-conventionally named
    inputBinding:
      position: 101
      prefix: -bai
  - id: bam_file
    type: File
    doc: the input bam file
    inputBinding:
      position: 101
      prefix: -bam
  - id: bitflag
    type:
      - 'null'
      - int
    doc: bit flag for read filter (as specified in SAM doc)
    inputBinding:
      position: 101
      prefix: -bitflag
  - id: genome
    type: File
    doc: the input fasta file
    inputBinding:
      position: 101
      prefix: -genome
  - id: len_context_ins
    type:
      - 'null'
      - int
    doc: length of the k-mer context for context dependent insertion table
    inputBinding:
      position: 101
      prefix: -len_context_ins
  - id: len_context_sub
    type:
      - 'null'
      - int
    doc: length of the k-mer context for context dependent substitution table
    inputBinding:
      position: 101
      prefix: -len_context_sub
  - id: len_max_hp
    type:
      - 'null'
      - int
    doc: maximum homopolymer length
    inputBinding:
      position: 101
      prefix: -len_max_hp
  - id: len_max_indel
    type:
      - 'null'
      - int
    doc: maximum length of indels to consider
    inputBinding:
      position: 101
      prefix: -len_max_indel
  - id: len_min_aln
    type:
      - 'null'
      - int
    doc: minimum length aligned
    inputBinding:
      position: 101
      prefix: -len_min_aln
  - id: len_min_contig
    type:
      - 'null'
      - int
    doc: minimum contig length
    inputBinding:
      position: 101
      prefix: -len_min_contig
  - id: len_min_hp
    type:
      - 'null'
      - int
    doc: minimum homopolymer length
    inputBinding:
      position: 101
      prefix: -len_min_hp
  - id: len_min_read
    type:
      - 'null'
      - int
    doc: minimum read length
    inputBinding:
      position: 101
      prefix: -len_min_read
  - id: len_trim_contig_edge
    type:
      - 'null'
      - int
    doc: length of the contig edge to trim before computing various statistics
    inputBinding:
      position: 101
      prefix: -len_trim_contig_edge
  - id: lim
    type:
      - 'null'
      - int
    doc: pass this flag to run the program with 'lim' randomly selected reads 
      (both pass and fail)
    inputBinding:
      position: 101
      prefix: -lim
  - id: mapq_thres
    type:
      - 'null'
      - int
    doc: minimum mapq threshold
    inputBinding:
      position: 101
      prefix: -mapq_thres
  - id: no_figures
    type:
      - 'null'
      - boolean
    doc: pass this flag to not generate figures
    inputBinding:
      position: 101
      prefix: -no_figures
  - id: num_pts_max
    type:
      - 'null'
      - int
    doc: maximum number of points to be plotted for any scatter plots
    inputBinding:
      position: 101
      prefix: -num_pts_max
  - id: output_dir
    type: Directory
    doc: the output directory for figures and stats
    inputBinding:
      position: 101
      prefix: -output_dir
  - id: report_name
    type:
      - 'null'
      - string
    doc: the name of the output PDF report if the user wishes to use a 
      non-default name.
    inputBinding:
      position: 101
      prefix: -report_name
  - id: use_recorded
    type:
      - 'null'
      - boolean
    doc: pass this flag to NOT perform reverse complementing of the reverse 
      complement mapped reads
    inputBinding:
      position: 101
      prefix: -use_recorded
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: pass this flag to follow progress in the terminal
    inputBinding:
      position: 101
      prefix: -verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/counterr:0.1--py_0
stdout: counterr.out
