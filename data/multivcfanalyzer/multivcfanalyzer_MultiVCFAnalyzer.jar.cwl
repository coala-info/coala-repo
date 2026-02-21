cwlVersion: v1.2
class: CommandLineTool
baseCommand: multivcfanalyzer
label: multivcfanalyzer_MultiVCFAnalyzer.jar
doc: "MultiVCFAnalyzer is a tool for processing and analyzing multiple VCF files.
  (Note: The provided text is a system error log and does not contain usage instructions
  or argument definitions.)\n\nTool homepage: https://github.com/alexherbig/MultiVCFAnalyzer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/multivcfanalyzer:0.85.2--hdfd78af_1
stdout: multivcfanalyzer_MultiVCFAnalyzer.jar.out
