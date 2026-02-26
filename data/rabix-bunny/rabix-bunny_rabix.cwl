cwlVersion: v1.2
class: CommandLineTool
baseCommand: rabix
label: rabix-bunny_rabix
doc: "Executes CWL application with provided inputs.\n\nTool homepage: https://github.com/rabix/bunny"
inputs:
  - id: app
    type: File
    doc: is the path to a CWL document that describes the app.
    inputBinding:
      position: 1
  - id: inputs
    type:
      - 'null'
      - File
    doc: is the JSON or YAML file that provides the values of app inputs.
    inputBinding:
      position: 2
  - id: input_parameters
    type:
      - 'null'
      - type: array
        items: string
    doc: are the app input values specified directly from the command line
    inputBinding:
      position: 3
  - id: cache_dir
    type:
      - 'null'
      - Directory
    doc: basic tool result caching (experimental)
    inputBinding:
      position: 104
      prefix: --cache-dir
  - id: configuration_dir
    type:
      - 'null'
      - Directory
    doc: configuration directory
    inputBinding:
      position: 104
      prefix: --configuration-dir
  - id: execution_directory
    type:
      - 'null'
      - string
    doc: execution directory
    inputBinding:
      position: 104
      prefix: --basedir
  - id: no_container
    type:
      - 'null'
      - boolean
    doc: don't use containers
    inputBinding:
      position: 104
      prefix: --no-container
  - id: outdir
    type:
      - 'null'
      - string
    doc: legacy compatibility parameter, doesn't do anything
    inputBinding:
      position: 104
      prefix: --outdir
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: don't print anything except final result on standard output
    inputBinding:
      position: 104
      prefix: --quiet
  - id: resolve_app
    type:
      - 'null'
      - boolean
    doc: resolve all referenced fragments and print application as a single JSON
      document
    inputBinding:
      position: 104
      prefix: --resolve-app
  - id: tes_storage
    type:
      - 'null'
      - string
    doc: path to the storage used by the ga4gh tes server (currently supports 
      locall dirs and google storage cloud paths)
    inputBinding:
      position: 104
      prefix: --tes-storage
  - id: tes_url
    type:
      - 'null'
      - string
    doc: url of the ga4gh task execution server instance (experimental)
    inputBinding:
      position: 104
      prefix: --tes-url
  - id: tmp_outdir_prefix
    type:
      - 'null'
      - string
    doc: legacy compatibility parameter, doesn't do anything
    inputBinding:
      position: 104
      prefix: --tmp-outdir-prefix
  - id: tmpdir_prefix
    type:
      - 'null'
      - string
    doc: legacy compatibility parameter, doesn't do anything
    inputBinding:
      position: 104
      prefix: --tmpdir-prefix
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: print more information on the standard output
    inputBinding:
      position: 104
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rabix-bunny:1.0.4--0
stdout: rabix-bunny_rabix.out
