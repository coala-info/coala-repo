cwlVersion: v1.2
class: CommandLineTool
baseCommand: SSPACE_Basic_v2.0.pl
label: sspace
doc: "SSPACE Basic is a tool for scaffolding genome assemblies using paired-end sequencing
  data.\n\nTool homepage: https://github.com/imhuay/sspace"
inputs:
  - id: bowtie_threads
    type:
      - 'null'
      - int
    doc: Specify the number of threads in Bowtie. Corresponds to the 
      -p/--threads option in Bowtie
    default: 1
    inputBinding:
      position: 101
      prefix: -T
  - id: contig_fasta
    type: File
    doc: FASTA file containing contig sequences used for extension. Inserted 
      pairs are mapped to extended and non-extended contigs
    inputBinding:
      position: 101
      prefix: -s
  - id: extend_contigs
    type:
      - 'null'
      - boolean
    doc: Indicate whether to extend the contigs of -s using paired reads in -l 
      (-x 1=extension, -x 0=no extension, default -x 0)
    default: 0
    inputBinding:
      position: 101
      prefix: -x
  - id: library_file
    type: File
    doc: Library file containing two paired read files with insert size, error 
      and either mate pair or paired end indication
    inputBinding:
      position: 101
      prefix: -l
  - id: make_dot_file
    type:
      - 'null'
      - boolean
    doc: Make .dot file for visualisation (-p 1=yes, -p 0=no, default -p 0)
    default: 0
    inputBinding:
      position: 101
      prefix: -p
  - id: max_bowtie_gaps
    type:
      - 'null'
      - int
    doc: Maximum number of allowed gaps during mapping with Bowtie. Corresponds 
      to the -v option in Bowtie. *Higher number of allowed gaps can lead to 
      least accurate scaffolding*
    default: 0
    inputBinding:
      position: 101
      prefix: -g
  - id: max_link_ratio
    type:
      - 'null'
      - float
    doc: Maximum link ratio between two best contig pairs. *Higher values lead 
      to least accurate scaffolding*
    default: 0.7
    inputBinding:
      position: 101
      prefix: -a
  - id: min_contig_length
    type:
      - 'null'
      - int
    doc: Minimum contig length used for scaffolding. Filters out contigs below 
      this value
    default: 0
    inputBinding:
      position: 101
      prefix: -z
  - id: min_links_for_scaffold
    type:
      - 'null'
      - int
    doc: Minimum number of links (read pairs) to compute scaffold
    default: 5
    inputBinding:
      position: 101
      prefix: -k
  - id: min_overhang_ratio
    type:
      - 'null'
      - float
    doc: Minimum base ratio used to accept a overhang consensus base
    default: 0.9
    inputBinding:
      position: 101
      prefix: -r
  - id: min_overlap
    type:
      - 'null'
      - int
    doc: Minimum number of overlapping bases with the seed/contig during 
      overhang consensus build up
    default: 32
    inputBinding:
      position: 101
      prefix: -m
  - id: min_overlap_merge
    type:
      - 'null'
      - int
    doc: Minimum overlap required between contigs to merge adjacent contigs in a
      scaffold
    default: 15
    inputBinding:
      position: 101
      prefix: -n
  - id: min_reads_for_base
    type:
      - 'null'
      - int
    doc: Minimum number of reads needed to call a base during an extension
    default: 20
    inputBinding:
      position: 101
      prefix: -o
  - id: output_basename
    type:
      - 'null'
      - string
    doc: Base name for your output files
    default: standard_output
    inputBinding:
      position: 101
      prefix: -b
  - id: trim_contig_end
    type:
      - 'null'
      - int
    doc: Trim up to -t base(s) on the contig end when all possibilities have 
      been exhausted for an extension
    default: 0
    inputBinding:
      position: 101
      prefix: -t
  - id: unpaired_reads
    type:
      - 'null'
      - File
    doc: FASTA/FASTQ file containing unpaired sequence reads (optional)
    inputBinding:
      position: 101
      prefix: -u
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Runs in verbose mode (-v 1=yes, -v 0=no, default -v 0)
    default: 0
    inputBinding:
      position: 101
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/sspace:v2.1.1dfsg-4-deb_cv1
stdout: sspace.out
