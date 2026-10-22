cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - traitar
  - pfam
label: traitar_pfam
doc: "Download and uncompress pfam files.\nThe files are required for gene annotation.\n\
  \nTool homepage: http://github.com/aweimann/traitar"
inputs:
  - id: download_dir
    type: string
    doc: Name of the directory to download the Pfam HMMs into (the tool creates it,
      then uncompresses the files)
    inputBinding:
      position: 1
  - id: local_pfam_dir
    type:
      - 'null'
      - Directory
    doc: Directory that already holds Pfam-A.hmm; it is copied to the download_dir
      name in the working directory (use with --local)
  - id: local
    type:
      - 'null'
      - boolean
    doc: The Pfam HMMs are in the above directory with name "Pfam-A.hmm"
    inputBinding:
      position: 102
      prefix: --local
outputs:
  - id: pfam_dir
    type: Directory
    doc: Directory with Pfam-A.hmm
    outputBinding:
      glob: $(inputs.download_dir)
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.download_dir)
        entry: '$(inputs.local_pfam_dir ? inputs.local_pfam_dir : {"class": "Directory", "listing": []})'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/traitar:3.0.1--pyhdfd78af_0
stdout: traitar_pfam.out
