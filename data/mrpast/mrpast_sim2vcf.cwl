cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mrpast
  - sim2vcf
label: mrpast_sim2vcf
doc: "Convert .trees files to VCF format.\n\nTool homepage: https://aprilweilab.github.io/"
inputs:
  - id: arg_file
    type: string
    doc: The ARG (.trees) file name to process, or a file name prefix with 
      --prefix. It names files in arg_files.
    inputBinding:
      position: 1
  - id: arg_files
    type:
      type: array
      items: File
    doc: The .trees files that arg_file names. They are staged in the working 
      directory, where the VCF and population map files are written.
  - id: jobs
    type:
      - 'null'
      - int
    doc: Number of jobs (threads) to use.
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
  - id: vcf_files
    type:
      type: array
      items: File
    doc: VCF files written for each ARG (<arg file>.vcf).
    outputBinding:
      glob: '*.vcf'
  - id: popmap_files
    type:
      type: array
      items: File
    doc: Population map JSON files (<arg file>.popmap.json).
    outputBinding:
      glob: '*.popmap.json'
  - id: zarr_dirs
    type:
      type: array
      items: Directory
    doc: VCF/ZARR folders written with --zarr.
    outputBinding:
      glob: '*.vcz'
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.arg_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mrpast:0.2--py312h8f4af18_0
stdout: mrpast_sim2vcf.out
