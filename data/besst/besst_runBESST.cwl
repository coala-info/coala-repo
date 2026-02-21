cwlVersion: v1.2
class: CommandLineTool
baseCommand: runBESST
label: besst_runBESST
doc: "BESST (Scaffolding Tool) - Scaffolding of genomic assemblies using different
  types of libraries (e.g., paired-end, mate-pairs).\n\nTool homepage: https://github.com/ksahlin/BESST"
inputs:
  - id: bam_files
    type:
      type: array
      items: File
    doc: Path to the BAM/SAM file(s) containing alignments.
    inputBinding:
      position: 101
      prefix: -c
  - id: fasta_file
    type: File
    doc: Path to the fasta file containing contigs.
    inputBinding:
      position: 101
      prefix: -f
  - id: mean_insert_size
    type:
      - 'null'
      - int
    doc: Mean insert size of the library.
    inputBinding:
      position: 101
      prefix: -m
  - id: orientation
    type:
      - 'null'
      - string
    doc: Library orientation (e.g., fr, rf, ff, rr).
    inputBinding:
      position: 101
      prefix: -orientation
  - id: plots
    type:
      - 'null'
      - boolean
    doc: Generate plots for the scaffolding process.
    inputBinding:
      position: 101
      prefix: -p
  - id: std_dev
    type:
      - 'null'
      - int
    doc: Standard deviation of the insert size.
    inputBinding:
      position: 101
      prefix: -s
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use.
    inputBinding:
      position: 101
      prefix: -T
  - id: threshold
    type:
      - 'null'
      - int
    doc: Threshold for the number of links required to create a scaffold.
    inputBinding:
      position: 101
      prefix: -k
outputs:
  - id: output_directory
    type: Directory
    doc: Path to the output directory.
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/besst:2.2.8--py27_0
