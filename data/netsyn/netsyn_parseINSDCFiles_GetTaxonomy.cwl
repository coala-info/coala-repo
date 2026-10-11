cwlVersion: v1.2
class: CommandLineTool
baseCommand: [netsyn_parseINSDCFiles_GetTaxonomy]
label: netsyn_parseINSDCFiles_GetTaxonomy
doc: "Parse INSDC files to extract the genomic contexts of the target proteins and their taxonomy.\n\nTool homepage: https://github.com/labgem/netsyn"
inputs:
  - id: correspondences_file
    type: File
    doc: Correspondence file between protein_AC, nucleic_AC and nucleic_File_Path.
    inputBinding:
      position: 1
      prefix: --CorrespondencesFile
  - id: output_name
    type: string
    doc: Prefix of the output files.
    inputBinding:
      position: 2
      prefix: --outputName
  - id: included_pseudogenes
    type:
      - 'null'
      - boolean
    doc: CDS annotated as pseudogenes are part of the genomic context.
    inputBinding:
      position: 3
      prefix: --IncludedPseudogenes
  - id: nucleic_files
    type:
      - 'null'
      - type: array
        items: File
    doc: INSDC files named in the correspondences file. They are staged in the working directory, so use plain file names in the nucleic_File_Path column.
  - id: log_level
    type:
      - 'null'
      - type: enum
        symbols: [ERROR, error, WARNING, warning, INFO, info, DEBUG, debug]
        name: parseINSDCFiles_GetTaxonomy_log_level
    doc: Log level.
    inputBinding:
      position: 90
      prefix: --logLevel
  - id: log_file
    type:
      - 'null'
      - string
    doc: Log file (stderr by default).
    inputBinding:
      position: 91
      prefix: --logFile
outputs:
  - id: output_files
    type:
      type: array
      items: File
    doc: Fasta file with protein sequences, JSON protein, target and organism tables, and the report.
    outputBinding:
      glob: $(inputs.output_name)*
  - id: log_output
    type:
      - 'null'
      - File
    doc: Log file, when log_file is given.
    outputBinding:
      glob: |-
        ${ return inputs.log_file ? inputs.log_file : null; }
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.nucleic_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/netsyn:1.0.0--pyh7e72e81_0
