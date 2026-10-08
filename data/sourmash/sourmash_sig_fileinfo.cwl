cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- sourmash
- sig
- fileinfo
label: sourmash_sig_fileinfo
doc: 'Provide summary information on the given file.


  Tool homepage: https://github.com/sourmash-bio/sourmash'
inputs:
- id: path
  type: File
  doc: Signature file or collection.
  inputBinding:
    position: 100
- id: quiet
  type:
  - 'null'
  - boolean
  doc: suppress non-error output
  inputBinding:
    position: 1
    prefix: --quiet
- id: debug
  type:
  - 'null'
  - boolean
  doc: output debug information
  inputBinding:
    position: 1
    prefix: --debug
- id: force
  type:
  - 'null'
  - boolean
  doc: try to load all files as signatures
  inputBinding:
    position: 1
    prefix: --force
- id: rebuild_manifest
  type:
  - 'null'
  - boolean
  doc: forcibly rebuild the manifest
  inputBinding:
    position: 1
    prefix: --rebuild-manifest
- id: json_out
  type:
  - 'null'
  - boolean
  doc: output information in JSON format only
  inputBinding:
    position: 1
    prefix: --json-out
outputs:
- id: stdout
  type: stdout
  doc: Standard output
stdout: sourmash_sig_fileinfo.stdout.txt
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/sourmash:4.9.4--hdfd78af_0
