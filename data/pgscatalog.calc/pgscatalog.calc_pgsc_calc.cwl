cwlVersion: v1.2
class: CommandLineTool
baseCommand: pgscatalog.calc_pgsc_calc
label: pgscatalog.calc_pgsc_calc
doc: "A tool for calculating Polygenic Scores (PGS) using the PGS Catalog. (Note:
  The provided help text contains container build error logs rather than command usage
  instructions.)\n\nTool homepage: https://github.com/PGScatalog/pygscatalog/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pgscatalog.calc:0.3.1--pyhdfd78af_1
stdout: pgscatalog.calc_pgsc_calc.out
