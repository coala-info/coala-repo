cwlVersion: v1.2
class: CommandLineTool
baseCommand: poly
label: bart_poly
doc: "Evaluate polynomial p(x) = a_0 + a_1 x + a_2 x^2 ... a_N x^N at x = {0, 1, ...
  , L - 1} where a_i are floats.\n\nTool homepage: https://github.com/tomdstanton/bart"
inputs:
  - id: l
    type: int
    doc: Upper bound for x values (exclusive)
    inputBinding:
      position: 1
  - id: n
    type: int
    doc: Degree of the polynomial
    inputBinding:
      position: 2
  - id: a_coefficients
    type:
      type: array
      items: float
    doc: Coefficients of the polynomial (a_0 to a_N)
    inputBinding:
      position: 3
outputs:
  - id: output
    type: File
    doc: Output file to write the results
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1
