cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pgscatalog-utils
  - pgsc_calc
label: pgscatalog-utils_pgsc_calc
doc: "A tool from the pgscatalog-utils suite, likely used for polygenic score calculations.
  Note: The provided text is an error log from a container build process and does
  not contain usage instructions or argument definitions.\n\nTool homepage: https://github.com/PGScatalog/pygscatalog"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pgscatalog-utils:2.0.2--pyhdfd78af_0
stdout: pgscatalog-utils_pgsc_calc.out
