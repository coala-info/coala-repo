cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - popt
label: viennarna_popt
doc: |-
  Apply a p-optimal filter to RNAsubopt output: reads the output of RNAsubopt -s from standard input and keeps the p-optimal structures.

  Tool homepage: https://www.tbi.univie.ac.at/RNA/
inputs:
  - id: subopt_output
    type: File
    doc: Output of RNAsubopt -s (sorted suboptimal structures).
outputs:
  - id: stdout
    type: stdout
    doc: Standard output of the program
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viennarna:2.7.2--py310pl5321haba5358_0
stdin: $(inputs.subopt_output.path)
stdout: popt.out
s:url: https://www.tbi.univie.ac.at/RNA/
$namespaces:
  s: https://schema.org/
