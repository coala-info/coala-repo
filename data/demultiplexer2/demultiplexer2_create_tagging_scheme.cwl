cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - demultiplexer2
  - create_tagging_scheme
label: demultiplexer2_create_tagging_scheme
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.data_dir)
doc: "Create a tagging scheme for demultiplexing.\n\nTool homepage: https://github.com/DominikBuchner/demultiplexer2"
inputs:
  - id: data_dir
    type: Directory
    doc: Path to the directory that contains the files to demultiplex 
      (*.fastq.gz pairs). It is staged into the working directory so the 
      scheme records relative file paths.
    inputBinding:
      position: 101
      prefix: --data_dir
      valueFrom: $(self.basename)
  - id: name
    type: string
    doc: Define the name for the tagging scheme to create
    inputBinding:
      position: 101
      prefix: --name
  - id: primerset_path
    type: File
    doc: Path to the primerset to be used for demultiplexing.
    inputBinding:
      position: 101
      prefix: --primerset_path
  - id: combinations_file
    type: File
    doc: Text file with the answers the tool asks for interactively, passed on
      standard input - an empty line, then the primer combinations used, as 
      line numbers of the primer set in the format fwd-rev,fwd-rev (e.g. 
      1-1,2-2).
outputs:
  - id: tagging_scheme
    type: File
    doc: Tagging scheme (Excel) to fill with sample names
    outputBinding:
      glob: $(inputs.name)_tagging_scheme.xlsx
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/demultiplexer2:1.1.6--pyhdfd78af_0
stdin: $(inputs.combinations_file.path)
stdout: demultiplexer2_create_tagging_scheme.out
