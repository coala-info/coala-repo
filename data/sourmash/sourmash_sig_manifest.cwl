cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- sourmash
- sig
- manifest
label: sourmash_sig_manifest
doc: 'Create a manifest for a collection of signatures.


  Tool homepage: https://github.com/sourmash-bio/sourmash'
inputs:
- id: location
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
- id: output
  type: string
  doc: output information to a CSV file
  inputBinding:
    position: 1
    prefix: --output
  default: manifest.csv
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
  doc: force rebuilding manifest if available
  inputBinding:
    position: 1
    prefix: --rebuild-manifest
- id: no_rebuild_manifest
  type:
  - 'null'
  - boolean
  doc: use existing manifest if available
  inputBinding:
    position: 1
    prefix: --no-rebuild-manifest
- id: manifest_format
  type:
  - 'null'
  - string
  doc: format of manifest output file; default is 'csv')
  inputBinding:
    position: 1
    prefix: --manifest-format
- id: v4
  type:
  - 'null'
  - boolean
  doc: use sourmash v4 command-line behavior (default)
  inputBinding:
    position: 1
    prefix: --v4
- id: v5
  type:
  - 'null'
  - boolean
  doc: use sourmash v5 command-line behavior
  inputBinding:
    position: 1
    prefix: --v5
outputs:
- id: output_result
  type: File
  doc: output information to a CSV file
  outputBinding:
    glob: $(inputs.output)
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/sourmash:4.9.4--hdfd78af_0
