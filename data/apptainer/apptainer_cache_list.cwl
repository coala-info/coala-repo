cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - apptainer
  - cache
  - list
label: apptainer_cache_list
doc: "List your local Apptainer cache (stored at $HOME/.apptainer/cache if APPTAINER_CACHEDIR
  is not set).\n\nTool homepage: https://github.com/apptainer/apptainer"
requirements:
  - class: EnvVarRequirement
    envDef:
      - envName: APPTAINER_CACHEDIR
        envValue: '$(inputs.cache_dir ? inputs.cache_dir.path : runtime.outdir + "/.apptainer/cache")'
  - class: InlineJavascriptRequirement
inputs:
  - id: cache_dir
    type:
      - 'null'
      - Directory
    doc: Apptainer cache directory to list (sets APPTAINER_CACHEDIR); an empty cache is
      listed when not given
  - id: type
    type:
      - 'null'
      - type: array
        items: string
    doc: 'a list of cache types to display, possible entries: library, oci, shub, blob(s),
      all (default [all])'
    inputBinding:
      position: 1
      prefix: --type
      itemSeparator: ','
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: include cache entries in the output
    inputBinding:
      position: 1
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Cache listing
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/apptainer:latest
stdout: apptainer_cache_list.out
