cwlVersion: v1.2
class: CommandLineTool
baseCommand: jmodeltest
label: jmodeltest_jModelTest.jar
doc: "jModelTest is a tool for the statistical selection of models of nucleotide substitution.
  (Note: The provided text contains container runtime error messages rather than CLI
  help documentation; therefore, no arguments could be extracted from the source.)\n
  \nTool homepage: https://github.com/ddarriba/jmodeltest2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/jmodeltest:v2.1.10dfsg-7-deb_cv1
stdout: jmodeltest_jModelTest.jar.out
