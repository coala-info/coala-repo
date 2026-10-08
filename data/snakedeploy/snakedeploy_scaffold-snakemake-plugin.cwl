cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - snakedeploy
  - scaffold-snakemake-plugin
label: snakedeploy_scaffold-snakemake-plugin
doc: 'Scaffold a snakemake plugin by adding recommended dependencies and code snippets.


  Tool homepage: https://github.com/snakemake/snakedeploy'
inputs:
  - id: pyproject
    type: File
    doc: pyproject.toml of the plugin project (its project name must start with snakemake-<plugin_type>-plugin-);
      it is staged writable in the working directory because the tool edits it.
  - id: plugin_type
    type:
      type: enum
      symbols:
        - executor
        - report
        - scheduler
        - storage
        - software-deployment
        - logger
    doc: Type of the plugin to scaffold.
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: pyproject_out
    type:
      - 'null'
      - File
    doc: The updated pyproject.toml
    outputBinding:
      glob: pyproject.toml
  - id: src_dir
    type:
      - 'null'
      - Directory
    doc: Scaffolded source folder
    outputBinding:
      glob: src
  - id: tests_dir
    type:
      - 'null'
      - Directory
    doc: Scaffolded tests folder
    outputBinding:
      glob: tests
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snakedeploy:0.16.0--pyhdfd78af_0
stdout: snakedeploy_scaffold-snakemake-plugin.out
requirements:
  - class: NetworkAccess
    networkAccess: true
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.pyproject)
        writable: true
