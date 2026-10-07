cwlVersion: v1.2
class: CommandLineTool
baseCommand: ccne-acc
label: ccne_ccne-acc
doc: "Carbapenemase-encoding gene copy number estimator (accurate estimator)\n\nTool
  homepage: https://github.com/biojiang/ccne"
inputs:
  - id: amr
    type: string
    doc: AMR gene name, such as KPC-2, NDM-1, etc or AMR ID. Please refer to 
      --listdb (required)
    inputBinding:
      position: 101
      prefix: --amr
  - id: cpus
    type:
      - 'null'
      - int
    doc: Number of CPUs to use
    inputBinding:
      position: 101
      prefix: --cpus
  - id: dbdir
    type:
      - 'null'
      - Directory
    doc: CCNE database root folders
    inputBinding:
      position: 101
      prefix: --dbdir
  - id: fmtdb
    type:
      - 'null'
      - boolean
    doc: Format all the bwa index
    inputBinding:
      position: 101
      prefix: --fmtdb
  - id: input_file
    type: File
    doc: Input file name (required)
    inputBinding:
      position: 101
      prefix: --in
  - id: listdb
    type:
      - 'null'
      - boolean
    doc: List all configured AMRs
    inputBinding:
      position: 101
      prefix: --listdb
  - id: data_files
    type:
      - 'null'
      - type: array
        items: File
    doc: FASTQ read files and genome assembly FASTA files named in the --in list file; staged in the working directory so
      the relative names in the list resolve
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: No screen output (default OFF)
    inputBinding:
      position: 101
      prefix: --quiet
  - id: output_file_path
    type: string
    doc: Output file name (required)
    inputBinding:
      position: 102
      prefix: --out
outputs:
  - id: output_file
    type: File
    doc: Output file name (required)
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - "$(inputs.data_files ? inputs.data_files : [])"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ccne:1.1.2--hdfd78af_0
