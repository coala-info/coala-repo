cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - methylpy
  - build-reference
label: methylpy_build-reference
doc: "Build reference files for methylpy using specified aligners.\n\nTool homepage:
  https://github.com/yupenghe/methylpy"
inputs:
  - id: aligner
    type:
      - 'null'
      - string
    doc: Aligner to use. Currently, methylpy supports bowtie, bowtie2 and 
      minimap2.
    default: bowtie2
    inputBinding:
      position: 101
      prefix: --aligner
  - id: buffsize
    type:
      - 'null'
      - int
    doc: The number of bytes that will be read in from the reference at once.
    default: 100
    inputBinding:
      position: 101
      prefix: --buffsize
  - id: input_files
    type:
      type: array
      items: File
    doc: List of genome fasta files to build a reference from.
    inputBinding:
      position: 101
      prefix: --input-files
  - id: num_procs
    type:
      - 'null'
      - int
    doc: Number of processors you wish to use to parallelize this function
    default: 1
    inputBinding:
      position: 101
      prefix: --num-procs
  - id: path_to_aligner
    type:
      - 'null'
      - string
    doc: Path to bowtie/bowtie2 installation
    default: ''
    inputBinding:
      position: 101
      prefix: --path-to-aligner
outputs:
  - id: output_prefix
    type: File
    doc: the prefix of the two output reference files that will be created.
    outputBinding:
      glob: $(inputs.output_prefix)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/methylpy:1.4.7--py39h0ae133c_0
