cwlVersion: v1.2
class: CommandLineTool
baseCommand: PrimedLAMP_Custom
label: primedlamp_PrimedLAMP_Custom
doc: "Assess user-supplied (custom) LAMP primer sets.\n\nTool homepage: https://github.com/MatthewHiggins2017/bioconda-PrimedRPA"
inputs:
  - id: run_id
    type: string
    doc: "Desired Run ID"
    inputBinding:
      position: 1
      prefix: --RunID
  - id: input_file
    type: File
    doc: "Path to Custom Sets Input File (CSV)"
    inputBinding:
      position: 1
      prefix: --InputFile
  - id: input_fasta
    type:
      - 'null'
      - File
    doc: "Path to target sequence in fasta format"
    inputBinding:
      position: 1
      prefix: --InputFasta
  - id: prior_align
    type:
      - 'null'
      - File
    doc: "Path to Alignment Summary CSV File"
    inputBinding:
      position: 1
      prefix: --PriorAlign
  - id: background_check
    type:
      - 'null'
      - File
    doc: "Path to cross-reactivity fasta file (leave unset for no cross reactivity check); needs a samtools .fai index beside it"
    inputBinding:
      position: 1
      prefix: --BackgroundCheck
    secondaryFiles:
      - '.fai'
  - id: blast_db_path
    type:
      - 'null'
      - string
    doc: "Path to BlastnDB for cross reactivity check."
    inputBinding:
      position: 1
      prefix: --BlastDBPath
  - id: background_search_sensitivity
    type:
      - 'null'
      - string
    doc: "Options [Basic or Advanced or Fast]"
    inputBinding:
      position: 1
      prefix: --BackgroundSearchSensitivity
  - id: evalue_thresh
    type:
      - 'null'
      - int
    doc: "Cross Reactivity search sensntivity."
    inputBinding:
      position: 1
      prefix: --EvalueThresh
  - id: threads
    type:
      - 'null'
      - int
    doc: "Default set to 1"
    inputBinding:
      position: 1
      prefix: --Threads
  - id: tspacer_len
    type:
      - 'null'
      - int
    doc: "Length of T Spacer in FIP and BIP if required"
    inputBinding:
      position: 1
      prefix: --TspacerLen
  - id: inclusivity_check
    type:
      - 'null'
      - string
    doc: "Inclusivity and binding site assessment (YES or NO)"
    inputBinding:
      position: 1
      prefix: --InclusivityCheck
outputs:
  - id: output_files
    type:
      type: array
      items: File
    doc: Result tables written with the run ID as prefix
    outputBinding:
      glob: $(inputs.run_id)_*.csv
  - id: temporary_directories
    type:
      - 'null'
      - Directory
    doc: Temporary directory with the Blastn output (kept when a background check is run)
    outputBinding:
      glob: $(inputs.run_id)_Temporary_Directories
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/primedlamp:1.0.1--py_0
stdout: primedlamp_PrimedLAMP_Custom.out
