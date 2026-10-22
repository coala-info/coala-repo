cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - SigProfilerMatrixGenerator
  - install
label: sigprofilermatrixgenerator_install
doc: "Install reference genome files (required to generate matrices).\n\nTool homepage:
  https://github.com/AlexandrovLab/SigProfilerMatrixGenerator"
inputs:
  - id: local_genome
    type:
      - 'null'
      - File
    doc: Install an offline reference genome downloaded from the Alexandrov Lab's
      FTP server.
    inputBinding:
      position: 1
      prefix: --local_genome
  - id: volume
    type: string
    doc: Destination for the downloaded genomes
    inputBinding:
      position: 2
      prefix: --volume
  - id: genome
    type: string
    doc: "The reference genome to install. Supported genomes include {c_elegans,
      dog, ebv, GRCh37, GRCh38, mm9, mm10, mm39, rn6, rn7, yeast}."
    inputBinding:
      position: 3
outputs:
  - id: genome_volume
    type: Directory
    doc: Directory with the installed reference genome files
    outputBinding:
      glob: $(inputs.volume)
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sigprofilermatrixgenerator:1.3.3--pyhdfd78af_1
stdout: sigprofilermatrixgenerator_install.out
