cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - deepbgc
  - download
label: deepbgc_download
doc: "Download trained models and other file dependencies to the DeepBGC downloads
  directory.\n\nTool homepage: https://github.com/Merck/DeepBGC"
inputs:
  - id: debug
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 101
      prefix: --debug
  - id: downloads_dir_name
    type: string
    doc: Name of the downloads directory to create in the output directory; 
      passed to the tool as the DEEPBGC_DOWNLOADS_DIR environment variable
    default: deepbgc_downloads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: downloads_dir
    type: Directory
    doc: DeepBGC downloads directory (trained models and Pfam database); give 
      it to deepbgc prepare, pipeline or train as downloads_dir
    outputBinding:
      glob: $(inputs.downloads_dir_name)
requirements:
  - class: EnvVarRequirement
    envDef:
      DEEPBGC_DOWNLOADS_DIR: $(runtime.outdir)/$(inputs.downloads_dir_name)
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deepbgc:0.1.31--pyhca03a8a_0
stdout: deepbgc_download.out
