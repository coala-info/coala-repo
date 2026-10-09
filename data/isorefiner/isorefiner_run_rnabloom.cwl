cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - isorefiner
  - run_rnabloom
label: isorefiner_run_rnabloom
doc: "Run RNA-Bloom (de novo assembly-based tool) and GMAP (contig mapping).\n\nTool homepage: https://github.com/rkajitani/IsoRefiner"
inputs:
  - id: reads
    type: File[]
    doc: "Reads (FASTQ or FASTA, gzip allowed)."
    inputBinding:
      position: 1
      prefix: --reads
  - id: genome
    type: ['null', File]
    doc: "Reference genome (FASTA)."
    inputBinding:
      position: 2
      prefix: --genome
  - id: out_gtf
    type: string
    default: isorefiner_rnabloom.gtf
    doc: "Final output file name (GTF)."
    inputBinding:
      position: 3
      prefix: --out_gtf
  - id: max_mem
    type: ['null', string]
    doc: "Max memory for RNA-Bloom (java -Xmx). Default: 400g"
    inputBinding:
      position: 5
      prefix: --max_mem
  - id: rnabloom_option
    type: ['null', string]
    doc: "Option for RNA-Bloom (quoted string)."
    inputBinding:
      position: 6
      prefix: --rnabloom_option
  - id: gmap_min_cov
    type: ['null', float]
    doc: "Min alignment coverage for GMAP [0-1]."
    inputBinding:
      position: 7
      prefix: --gmap_min_cov
  - id: gmap_min_idt
    type: ['null', float]
    doc: "Min identity for GMAP [0-1]."
    inputBinding:
      position: 8
      prefix: --gmap_min_idt
  - id: gmap_max_intron
    type: ['null', int]
    doc: "Max intron length for GMAP (bp)."
    inputBinding:
      position: 9
      prefix: --gmap_max_intron
  - id: gmap_option
    type: ['null', string]
    doc: "Option for GMAP (quoted string). Default: -n 1 --no-chimeras"
    inputBinding:
      position: 10
      prefix: --gmap_option
  - id: work_dir
    type: string
    default: isorefiner_rnabloom_work
    doc: "Working directory containing intermediate and log files."
    inputBinding:
      position: 4
      prefix: --work_dir
  - id: threads
    type: ['null', int]
    doc: "Number of threads."
    inputBinding:
      position: 4
      prefix: --threads
outputs:
  - id: output_gtf
    type: File
    doc: "Transcript isoform structures from RNA-Bloom contigs mapped with GMAP."
    outputBinding:
      glob: $(inputs.out_gtf)
  - id: log_file
    type: ['null', File]
    doc: "Log file of the run (in the working directory)."
    outputBinding:
      glob: $(inputs.work_dir)/log.txt
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/isorefiner:0.1.0--pyh7e72e81_1
