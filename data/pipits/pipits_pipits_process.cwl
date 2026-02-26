cwlVersion: v1.2
class: CommandLineTool
baseCommand: PIPITS_PROCESS
label: pipits_pipits_process
doc: "Sequences to OTU Table\n\nTool homepage: https://github.com/hsgweon/pipits"
inputs:
  - id: identity_threshold
    type:
      - 'null'
      - float
    doc: VSEARCH - Identity threshold
    default: 0.97
    inputBinding:
      position: 101
      prefix: -d
  - id: ignore_db_download
    type:
      - 'null'
      - boolean
    doc: Ignore automatic download of database files. Assumes databases are 
      already present in 'pipits_db/'.
    inputBinding:
      position: 101
      prefix: --ignore-db-download
  - id: include_unique_sequences
    type:
      - 'null'
      - boolean
    doc: PIPITS by default removes unique sequences before clustering. If you 
      want singletons, choose this option.
    inputBinding:
      position: 101
      prefix: --includeuniqueseqs
  - id: input_file
    type: File
    doc: ITS sequences in FASTA. Typically output from pipits_funits
    inputBinding:
      position: 101
      prefix: -i
  - id: jvm_max_memory
    type:
      - 'null'
      - string
    doc: The maximum size, in bytes, of the memory allocation pool for JVM
    inputBinding:
      position: 101
      prefix: --Xmx
  - id: jvm_min_memory
    type:
      - 'null'
      - string
    doc: The minimum size, in bytes, of the memory allocation pool for JVM
    inputBinding:
      position: 101
      prefix: --Xms
  - id: rdp_confidence_threshold
    type:
      - 'null'
      - float
    doc: RDP assignment confidence threshold - RDP Classifier confidence 
      threshold for output
    default: 0.85
    inputBinding:
      position: 101
      prefix: -c
  - id: retain_intermediate_files
    type:
      - 'null'
      - boolean
    doc: Retain intermediate files (Beware intermediate files use excessive disk
      space!)
    inputBinding:
      position: 101
      prefix: -r
  - id: sample_list_file
    type:
      - 'null'
      - File
    doc: Sample list file. One sample ID per line. If not provided, it will be 
      generated automatically from FASTA headers (part before first '_').
    inputBinding:
      position: 101
      prefix: -l
  - id: sintax_confidence_threshold
    type:
      - 'null'
      - float
    doc: VSEARCH SINTAX assignment confidence threshold
    default: 0.85
    inputBinding:
      position: 101
      prefix: --sintaxconfidence
  - id: taxonomic_assignment_method
    type:
      - 'null'
      - string
    doc: Choice of taxonomic assignment. By default, PIPITS will run SINTAX 
      (VSEARCH). Selecting 'all' runs both RDP and SINTAX. Databases downloaded 
      automatically unless --ignore-db-download is specified.
    inputBinding:
      position: 101
      prefix: --taxassignmentmethod
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of Threads
    default: 1
    inputBinding:
      position: 101
      prefix: -t
  - id: unite_db_version
    type:
      - 'null'
      - string
    doc: UNITE db version to be used - PIPITS will download db automaticlly 
      unless --ignore-db-download is specified. Leaving this option out will 
      default to the most recent version of UNITE available to PIPITS.
    inputBinding:
      position: 101
      prefix: --unite
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose mode (more detailed logging).
    inputBinding:
      position: 101
      prefix: -v
outputs:
  - id: output_dir
    type: Directory
    doc: Directory to output results.
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pipits:4.0--pyhdfd78af_0
