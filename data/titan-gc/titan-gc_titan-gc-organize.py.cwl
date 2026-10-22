cwlVersion: v1.2
class: CommandLineTool
baseCommand: titan-gc-organize.py
label: titan-gc_titan-gc-organize.py
doc: "titan-gc-organize - Read Cromwell metadata to organize files into readable structure\n\nTool homepage: https://github.com/theiagen/public_health_viral_genomics"
inputs:
  - id: metadata_json
    type: File
    doc: The metadata.json output (-m) from the Titan GC run.
    inputBinding:
      position: 2
  - id: outdir
    type:
      - 'null'
      - string
    doc: "Directory to copy files to. (Default: ./titan-gc)."
    inputBinding:
      position: 1
      prefix: --outdir
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Print helpful information
    inputBinding:
      position: 1
      prefix: --debug
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: organized_dir
    type:
      - 'null'
      - Directory
    doc: Directory with the organized Titan GC files
    outputBinding:
      glob: $(inputs.outdir || "titan-gc")
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/titan-gc:1.5.3--hdfd78af_1
stdout: titan-gc_titan-gc-organize.py.out
