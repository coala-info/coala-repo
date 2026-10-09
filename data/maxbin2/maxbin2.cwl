cwlVersion: v1.2
class: CommandLineTool
baseCommand: run_MaxBin.pl
label: maxbin2
doc: "MaxBin is a software for binning metagenomic sequences based on an Expectation-Maximization
  algorithm.\n\nTool homepage: http://downloads.jbei.org/data/microbial_communities/MaxBin/MaxBin.html"
inputs:
  - id: abund
    type:
      - 'null'
      - File
    doc: Abundance file
    inputBinding:
      position: 101
      prefix: -abund
  - id: abund2
    type:
      - 'null'
      - File
    doc: Second abundance file
    inputBinding:
      position: 101
      prefix: -abund2
  - id: abund3
    type:
      - 'null'
      - File
    doc: Third abundance file
    inputBinding:
      position: 101
      prefix: -abund3
  - id: abund4
    type:
      - 'null'
      - File
    doc: Fourth abundance file
    inputBinding:
      position: 101
      prefix: -abund4
  - id: abund_list
    type:
      - 'null'
      - File
    doc: A list of abundance files
    inputBinding:
      position: 101
      prefix: -abund_list
  - id: contig
    type: File
    doc: Contig file in fasta format
    inputBinding:
      position: 101
      prefix: -contig
  - id: markerset
    type:
      - 'null'
      - int
    doc: Marker gene sets (107 or 40)
    inputBinding:
      position: 101
      prefix: -markerset
  - id: max_iteration
    type:
      - 'null'
      - int
    doc: Maximum Expectation-Maximization algorithm iteration number (default 50)
    inputBinding:
      position: 101
      prefix: -max_iteration
  - id: min_contig_length
    type:
      - 'null'
      - int
    doc: Minimum contig length
    inputBinding:
      position: 101
      prefix: -min_contig_length
  - id: plotmarker
    type:
      - 'null'
      - boolean
    doc: Plot marker gene distribution
    inputBinding:
      position: 101
      prefix: -plotmarker
  - id: prob_threshold
    type:
      - 'null'
      - float
    doc: Probability threshold for EM final classification
    inputBinding:
      position: 101
      prefix: -prob_threshold
  - id: reads
    type:
      - 'null'
      - File
    doc: Reads file in fasta or fastq format
    inputBinding:
      position: 101
      prefix: -reads
  - id: reads2
    type:
      - 'null'
      - File
    doc: Second reads file
    inputBinding:
      position: 101
      prefix: -reads2
  - id: reads3
    type:
      - 'null'
      - File
    doc: Third reads file
    inputBinding:
      position: 101
      prefix: -reads3
  - id: reads4
    type:
      - 'null'
      - File
    doc: Fourth reads file
    inputBinding:
      position: 101
      prefix: -reads4
  - id: reads_list
    type:
      - 'null'
      - File
    doc: A list of reads files
    inputBinding:
      position: 101
      prefix: -reads_list
  - id: preserve_intermediate
    type:
      - 'null'
      - boolean
    doc: Preserve intermediate files (debug)
    inputBinding:
      position: 101
      prefix: -preserve_intermediate
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output (debug)
    inputBinding:
      position: 101
      prefix: -verbose
  - id: thread
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 101
      prefix: -thread
  - id: out_path
    type: string
    doc: Output file prefix
    inputBinding:
      position: 102
      prefix: -out
outputs:
  - id: out
    type:
      type: array
      items: File
    doc: Output files (bins, summary, log, marker, noclass, tooshort, ...)
    outputBinding:
      glob: $(inputs.out_path)*
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/maxbin2:2.2.7--h503566f_8
