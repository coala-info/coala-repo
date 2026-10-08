cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gene_read_count_per_genome.py
label: desman_gene_read_count_per_genome.py
doc: "Count, for each gene, the reads overlapping it from each reference genome (taken from the read name: the part before the last underscore), split into unambiguous and ambiguous (XA tag) alignments, over one or more indexed BAM files. Prints a tab-separated table.\n\nTool homepage: https://github.com/chrisquince/DESMAN"
inputs:
  - id: genefile
    type: File
    doc: gene positions (gene,contig,start,end,strand)
    inputBinding:
      position: 10
  - id: reffa
    type: File
    doc: Reference fasta file
    inputBinding:
      position: 11
  - id: bamfiles
    type: File[]
    doc: BAM files with mappings to contigs (each needs a .bam.bai index)
    secondaryFiles:
      - .bai
    inputBinding:
      position: 12
  - id: max_n_processors
    type:
      - 'null'
      - int
    doc: Specify the maximum number of processors to use, if absent, all 
      present processors will be used.
    inputBinding:
      position: 1
      prefix: -m
  - id: output_name
    type: string
    doc: Name of the file that receives the count table written to stdout
    default: gene_read_counts.tsv
outputs:
  - id: counts
    type: File
    doc: Read counts per gene and reference genome (TSV)
    outputBinding:
      glob: $(inputs.output_name)
stdout: $(inputs.output_name)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/desman:2.1--py39h4747326_10
