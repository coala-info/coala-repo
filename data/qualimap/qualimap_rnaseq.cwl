cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - qualimap
  - rnaseq
label: qualimap_rnaseq
doc: "QualiMap v.2.3\n\nTool homepage: http://qualimap.bioinfo.cipf.es/"
inputs:
  - id: algorithm
    type:
      - 'null'
      - string
    doc: 'Counting algorithm: uniquely-mapped-reads(default) or proportional.'
    inputBinding:
      position: 101
      prefix: --algorithm
  - id: bam
    type: File
    doc: Input mapping file in BAM format.
    inputBinding:
      position: 101
      prefix: --bam
  - id: gtf
    type: File
    doc: Annotations file in Ensembl GTF format.
    inputBinding:
      position: 101
      prefix: --gtf
  - id: num_pr_bases
    type:
      - 'null'
      - int
    doc: Number of upstream/downstream nucleotide bases to compute 5'-3' bias
    default: 100
    inputBinding:
      position: 101
      prefix: --num-pr-bases
  - id: num_tr_bias
    type:
      - 'null'
      - int
    doc: Number of top highly expressed transcripts to compute 5'-3' bias
    default: 1000
    inputBinding:
      position: 101
      prefix: --num-tr-bias
  - id: outformat
    type:
      - 'null'
      - string
    doc: Format of the output report (PDF, HTML or both PDF:HTML, default is 
      HTML).
    default: HTML
    inputBinding:
      position: 101
      prefix: --outformat
  - id: output_counts_file
    type:
      - 'null'
      - File
    doc: Output file for computed counts. If only name of the file is provided, 
      then the file will be saved in the output folder.
    inputBinding:
      position: 101
      prefix: -oc
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Output folder for HTML report and raw data.
    inputBinding:
      position: 101
      prefix: --outdir
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file for PDF report
    default: report.pdf
    inputBinding:
      position: 101
      prefix: --outfile
  - id: paired_end
    type:
      - 'null'
      - boolean
    doc: Setting this flag for paired-end experiments will result in counting 
      fragments instead of reads
    inputBinding:
      position: 101
      prefix: --paired
  - id: sequencing_protocol
    type:
      - 'null'
      - string
    doc: 'Sequencing library protocol: strand-specific-forward, strand-specific-reverse
      or non-strand-specific (default)'
    inputBinding:
      position: 101
      prefix: --sequencing-protocol
  - id: sorted
    type:
      - 'null'
      - boolean
    doc: This flag indicates that the input file is already sorted by name. If 
      not set, additional sorting by name will be performed. Only required for 
      paired-end analysis.
    inputBinding:
      position: 101
      prefix: --sorted
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/qualimap:2.3--hdfd78af_0
stdout: qualimap_rnaseq.out
