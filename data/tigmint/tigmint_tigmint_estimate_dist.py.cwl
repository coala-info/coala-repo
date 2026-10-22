cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tigmint_estimate_dist.py
label: tigmint_tigmint_estimate_dist.py
doc: "Sample the reads from the given fasta/fastq file and estimate the Tigmint-long dist parameter based on the chosen length percentile\n\nTool homepage: https://github.com/bcgsc/tigmint"
inputs:
  - id: reads
    type: File
    doc: "Input reads file (fa or fq)"
    inputBinding:
      position: 10
  - id: n
    type:
      - 'null'
      - int
    doc: "Number of reads to sample [10000]"
    inputBinding:
      position: 1
      prefix: -n
  - id: p
    type:
      - 'null'
      - int
    doc: "Read length percentile to use for dist parameter estimation [50]"
    inputBinding:
      position: 2
      prefix: -p
  - id: d
    type:
      - 'null'
      - int
    doc: "Lower bound read length for percentile calculation [1000]"
    inputBinding:
      position: 3
      prefix: -d
  - id: o
    type:
      - 'null'
      - string
    doc: "Output file name [tigmint-long.params.tsv]"
    inputBinding:
      position: 4
      prefix: -o
outputs:
  - id: output
    type: File
    doc: "Parameter file with the estimated dist value"
    outputBinding:
      glob: $(inputs.o || 'tigmint-long.params.tsv')
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tigmint:1.2.10--py39h475c85d_4
