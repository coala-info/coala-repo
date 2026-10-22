cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sider
  - make-vcf
label: sideretro_make-vcf
doc: "Generate a VCF file with all annotated retrocopies.\n\nTool homepage:
  https://github.com/galantelab/sideRETRO"
inputs:
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Decrease verbosity to error messages only or suppress terminal outputs
      at all if 'log-file' is passed
    inputBinding:
      position: 1
      prefix: --quiet
  - id: silent
    type:
      - 'null'
      - boolean
    doc: Same as quiet
    inputBinding:
      position: 1
      prefix: --silent
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Increase verbosity to debug level
    inputBinding:
      position: 1
      prefix: --debug
  - id: log_file
    type:
      - 'null'
      - string
    doc: Print log messages to a file
    inputBinding:
      position: 1
      prefix: --log-file
  - id: output_dir
    type: string
    doc: Output directory. Create the directory if it does not exist.
    inputBinding:
      position: 1
      prefix: --output-dir
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prefix output files [default:"out"]
    inputBinding:
      position: 1
      prefix: --prefix
  - id: near_gene_dist
    type:
      - 'null'
      - int
    doc: Minimum distance between genes in order to consider them close
      [default:"10000"]
    inputBinding:
      position: 1
      prefix: --near-gene-dist
  - id: orientation_error
    type:
      - 'null'
      - double
    doc: Maximum error allowed for orientation rho [default:"0.05"]
    inputBinding:
      position: 1
      prefix: --orientation-error
  - id: reference_file
    type:
      - 'null'
      - File
    doc: FASTA file for the reference genome
    inputBinding:
      position: 1
      prefix: --reference-file
  - id: database
    type: File
    doc: SQLite3 database generated at the process-sample and merge-call steps
    inputBinding:
      position: 2
outputs:
  - id: output_directory
    type: Directory
    doc: Output directory with the VCF file
    outputBinding:
      glob: $(inputs.output_dir)
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sideretro:1.1.6--hb728cf0_0
stdout: sideretro_make-vcf.out
