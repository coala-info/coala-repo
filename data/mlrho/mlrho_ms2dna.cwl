cwlVersion: v1.2
class: CommandLineTool
baseCommand: mlrho_ms2dna
label: mlrho_ms2dna
doc: "mlrho_ms2dna (Note: The provided help text contains system error messages regarding
  container execution and does not list tool-specific usage or arguments.)\n\nTool
  homepage: http://guanine.evolbio.mpg.de/mlRho/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mlrho:2.9--h2d4b398_9
stdout: mlrho_ms2dna.out
