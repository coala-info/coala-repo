cwlVersion: v1.2
class: CommandLineTool
baseCommand: mrpast sim2vcf
label: mrpast_sim2vcf
doc: "Convert .trees files to VCF format.\n\nTool homepage: https://aprilweilab.github.io/"
inputs:
  - id: arg_file
    type: File
    doc: The ARG (.trees) file to process.
    inputBinding:
      position: 1
  - id: jobs
    type:
      - 'null'
      - int
    doc: Number of jobs (threads) to use.
    default: 1
    inputBinding:
      position: 102
      prefix: --jobs
  - id: leave_out
    type:
      - 'null'
      - string
    doc: Comma-separated list of population IDs to leave out when converting to 
      VCF
    inputBinding:
      position: 102
      prefix: --leave-out
  - id: mut_rate
    type:
      - 'null'
      - float
    doc: The mutation rate, for simulating mutations on existing trees.
    inputBinding:
      position: 102
      prefix: --mut-rate
  - id: prefix
    type:
      - 'null'
      - boolean
    doc: Treat arg_file as a prefix, and search for all <arg_prefix>*.trees 
      files
    inputBinding:
      position: 102
      prefix: --prefix
  - id: seed
    type:
      - 'null'
      - int
    doc: Set the random seed.
    inputBinding:
      position: 102
      prefix: --seed
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output, including timing information.
    inputBinding:
      position: 102
      prefix: --verbose
  - id: zarr
    type:
      - 'null'
      - boolean
    doc: Output VCF/ZARR files, required for tsinfer usage.
    inputBinding:
      position: 102
      prefix: --zarr
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mrpast:0.2--py312h8f4af18_0
stdout: mrpast_sim2vcf.out
