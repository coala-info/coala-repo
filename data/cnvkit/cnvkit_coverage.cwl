cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cnvkit.py
  - coverage
label: cnvkit_coverage
doc: "Calculate coverage in the given regions from BAM read depths.\n\nTool homepage: https://github.com/etal/cnvkit"
inputs:
  - id: bam_file
    type: File
    secondaryFiles:
      - pattern: .bai
        required: false
    doc: "Mapped sequence reads (.bam)"
    inputBinding:
      position: 1
  - id: interval
    type: File
    doc: "Intervals (.bed or .list)"
    inputBinding:
      position: 2
  - id: fasta
    type:
      - 'null'
      - File
    secondaryFiles:
      - pattern: .fai
        required: false
    doc: "Reference genome, FASTA format (e.g. UCSC hg19.fa)"
    inputBinding:
      position: 101
      prefix: --fasta
  - id: count
    type:
      - 'null'
      - boolean
    doc: "Get read depths by counting read midpoints within each bin. (An alternative algorithm)."
    inputBinding:
      position: 101
      prefix: --count
  - id: min_mapq
    type:
      - 'null'
      - int
    doc: "Minimum mapping quality score (phred scale 0-60) to count a read for coverage depth. [Default: 0]"
    inputBinding:
      position: 101
      prefix: --min-mapq
  - id: output
    type: string
    doc: "Output file name."
    inputBinding:
      position: 101
      prefix: --output
  - id: processes
    type:
      - 'null'
      - int
    doc: "Number of subprocesses to calculate coverage in parallel. Without an argument, use the maximum number of available CPUs. [Default: use 1 process]"
    inputBinding:
      position: 101
      prefix: --processes
outputs:
  - id: output_out
    type:
      - 'null'
      - File
    doc: "Output file name."
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cnvkit:0.9.12--pyhdfd78af_1
