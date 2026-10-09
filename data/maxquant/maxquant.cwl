cwlVersion: v1.2
class: CommandLineTool
baseCommand: maxquant
label: maxquant
doc: "Complete run of an existing mqpar.xml file\n\nTool homepage: http://www.coxdocs.org/doku.php?id=maxquant:start"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.input_files || [])
inputs:
  - id: mqpar_file
    type: string
    doc: Name of the mqpar.xml file (read, or written with --create). If you do 
      not have an mqpar.xml, you can generate one using the MaxQuant GUI or use
      --create option. An existing file is staged through input_files.
    inputBinding:
      position: 1
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Files named in the mqpar.xml (mqpar.xml itself, fasta files, raw files).
      They are staged in the working directory so relative paths resolve.
  - id: change_folder
    type:
      - 'null'
      - string
    doc: Change folder location for fasta and raw files (presuming all raw files
      are in the same folder). Expecting three locations separated by space. 1) 
      path to the mqpar file 2) path to the fasta file(s) 3) path to the raw 
      files.
    inputBinding:
      position: 102
      prefix: --changeFolder
  - id: create
    type:
      - 'null'
      - boolean
    doc: Create a template of MaxQuant parameter file.
    inputBinding:
      position: 102
      prefix: --create
  - id: dryrun
    type:
      - 'null'
      - boolean
    doc: Print job ids and job names table.
    inputBinding:
      position: 102
      prefix: --dryrun
  - id: partial_processing
    type:
      - 'null'
      - int
    doc: Start processing from the specified job id. Can be used to 
      continue/redo parts of the processing. Job id's can be obtained in the 
      MaxQuant GUI partial processing view or from --dryrun option. The first 
      job id is 1.
    inputBinding:
      position: 102
      prefix: --partial-processing
  - id: partial_processing_end
    type:
      - 'null'
      - int
    doc: Finish processing at the specified job id. 1-based indexing is used.
    inputBinding:
      position: 102
      prefix: --partial-processing-end
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: created_mqpar
    type:
      - 'null'
      - File
    doc: The template parameter file written by --create
    outputBinding:
      glob: $(inputs.mqpar_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/maxquant:2.0.3.0--py310hdfd78af_1
stdout: maxquant.out
