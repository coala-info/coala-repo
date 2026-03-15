cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - harpy
  - view
label: harpy_view
doc: View a workflow's components. These convenient commands let you view/edit 
  the latest workflow log file, snakefile, snakemake parameter file, workflow 
  config file in a directory that was used for the output of a Harpy run.
inputs:
  - id: command
    type: string
    doc: The specific component to view (config, environments, log, snakefile, 
      or snakeparams)
    inputBinding:
      position: 1
  - id: args
    type:
      - 'null'
      - type: array
        items: string
    doc: Additional arguments for the command
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/harpy:3.2--pyhdfd78af_0
stdout: harpy_view.out
s:url: https://github.com/pdimens/harpy/
$namespaces:
  s: https://schema.org/
