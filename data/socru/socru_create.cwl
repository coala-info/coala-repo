cwlVersion: v1.2
class: CommandLineTool
baseCommand: socru_create
label: socru_create
doc: "Create genome arrangement type scheme\n\nTool homepage: https://github.com/quadram-institute-bioscience/socru"
inputs:
  - id: output_directory
    type: string
    doc: Output directory
    inputBinding:
      position: 1
  - id: input_file
    type: File
    doc: Input FASTA file (optionally gzipped)
    inputBinding:
      position: 2
  - id: max_bases_from_ends
    type:
      - 'null'
      - int
    doc: Only look at this number of bases from start and end of fragment
    inputBinding:
      position: 103
      prefix: --max_bases_from_ends
  - id: threads
    type:
      - 'null'
      - int
    doc: No. of threads to use
    inputBinding:
      position: 103
      prefix: --threads
  - id: fragment_order
    type:
      - 'null'
      - string
    doc: Order of fragments, you may need to change this, example 1-2-3-4-5-6-7
    inputBinding:
      position: 103
      prefix: --fragment_order
  - id: dnaa_fasta
    type:
      - 'null'
      - File
    doc: Location of dnaA FASTA file, defaults to bundled
    inputBinding:
      position: 103
      prefix: --dnaa_fasta
  - id: dif_fasta
    type:
      - 'null'
      - File
    doc: Location of dif FASTA file, defaults to bundled
    inputBinding:
      position: 103
      prefix: --dif_fasta
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Turn on debugging
    inputBinding:
      position: 103
      prefix: --debug
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Turn on verbose output
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: scheme_directory
    type: Directory
    doc: Genome arrangement scheme directory
    outputBinding:
      glob: $(inputs.output_directory)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/socru:2.2.5--pyhdfd78af_0
stdout: socru_create.out
