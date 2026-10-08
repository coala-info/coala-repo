cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pyensembl
  - list
label: pyensembl_list
doc: "Show all Ensembl genomes installed in the pyensembl cache.\n\nTool homepage: https://github.com/openvax/pyensembl"
inputs:
  - id: cache_dir
    type: Directory
    doc: pyensembl cache directory (set as PYENSEMBL_CACHE_DIR)
outputs:
  - id: stdout
    type: stdout
    doc: List of installed Ensembl genomes and their directories
requirements:
  - class: EnvVarRequirement
    envDef:
      PYENSEMBL_CACHE_DIR: $(inputs.cache_dir.path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyensembl:2.3.13--pyh7cba7a3_0
stdout: pyensembl_list.out
