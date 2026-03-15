cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - harpy
  - simulate
label: harpy_simulate
doc: Simulate genomic variants. To simulate genomic variants, provide an 
  additional subcommand {snpindel,inversion,cnv,translocation} to get more 
  information about that workflow. The variant simulator (simuG) can only 
  simulate one type of variant at a time, so you may need to run it a few times 
  if you want multiple variant types.
inputs:
  - id: command
    type: string
    doc: 'The subcommand to execute: linkedreads, cnv, inversion, snpindel, or translocation'
    inputBinding:
      position: 1
  - id: args
    type:
      - 'null'
      - type: array
        items: string
    doc: Additional arguments for the specified subcommand
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/harpy:3.2--pyhdfd78af_0
stdout: harpy_simulate.out
s:url: https://github.com/pdimens/harpy/
$namespaces:
  s: https://schema.org/
