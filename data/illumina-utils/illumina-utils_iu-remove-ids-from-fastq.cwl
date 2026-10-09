cwlVersion: v1.2
class: CommandLineTool
baseCommand: iu-remove-ids-from-fastq
label: illumina-utils_iu-remove-ids-from-fastq
doc: "Remove reads from a FASTQ file by ID list; writes .survived and .removed files beside the input

Tool homepage: https://github.com/meren/illumina-utils"
inputs:
  - id: input_fastq
    type: File
    doc: "Sequences file from which reads will be removed in FASTQ format"
    inputBinding:
      position: 1
      prefix: '-i'
  - id: ids_file_path
    type: File
    doc: "Input file that contains the list of ids for removal"
    inputBinding:
      position: 2
      prefix: '-l'
  - id: delimiter
    type:
      - 'null'
      - string
    doc: "Split the IDs found in the FASTQ file on this character and match the first part to the IDs file"
    inputBinding:
      position: 3
      prefix: '-d'
  - id: generate_output_for_survived_only
    type:
      - 'null'
      - boolean
    doc: "If provided then only one output file (the file with survived ids) will be produced."
    inputBinding:
      position: 4
      prefix: '-G'
  - id: keep_ids
    type:
      - 'null'
      - boolean
    doc: "If provided, then instead of removing the ids in the list, only the ids in the list will be kept."
    inputBinding:
      position: 5
      prefix: '-K'
outputs:
  - id: survived
    type: File
    doc: Reads that survived
    outputBinding:
      glob: $(inputs.input_fastq.basename).survived
  - id: removed
    type:
      - 'null'
      - File
    doc: Reads that were removed
    outputBinding:
      glob: $(inputs.input_fastq.basename).removed
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.input_fastq)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/illumina-utils:2.13--pyhdfd78af_0
