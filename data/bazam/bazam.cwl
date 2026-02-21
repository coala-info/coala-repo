cwlVersion: v1.2
class: CommandLineTool
baseCommand: bazam
label: bazam
doc: "Bazam is a tool to extract paired reads from a coordinate-sorted BAM file and
  output them as FASTQ, suitable for piping into a new alignment.\n\nTool homepage:
  https://github.com/ssadedin/bazam"
inputs:
  - id: bam
    type: File
    doc: The input BAM file
    inputBinding:
      position: 101
      prefix: -bam
  - id: dragen
    type:
      - 'null'
      - boolean
    doc: Enable DRAGEN-specific extraction
    inputBinding:
      position: 101
      prefix: -dragen
  - id: n_threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    inputBinding:
      position: 101
      prefix: -n
  - id: name_sorted
    type:
      - 'null'
      - boolean
    doc: Input BAM is already name sorted
    inputBinding:
      position: 101
      prefix: -namesorted
  - id: pad
    type:
      - 'null'
      - int
    doc: Amount of padding to add to regions
    inputBinding:
      position: 101
      prefix: -pad
  - id: regions
    type:
      - 'null'
      - string
    doc: Regions to extract (e.g. chr1:1-100 or a BED file)
    inputBinding:
      position: 101
      prefix: -L
outputs:
  - id: fastq_output
    type:
      - 'null'
      - File
    doc: Output FASTQ file (if not specified, outputs to stdout)
    outputBinding:
      glob: $(inputs.fastq_output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bazam:1.0.1--0
