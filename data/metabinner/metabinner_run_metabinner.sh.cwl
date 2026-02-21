cwlVersion: v1.2
class: CommandLineTool
baseCommand: metabinner_run_metabinner.sh
label: metabinner_run_metabinner.sh
doc: "A tool for binning metagenomic sequences. (Note: The provided text contains
  container runtime error messages rather than command-line help documentation.)\n
  \nTool homepage: https://github.com/ziyewang/MetaBinner"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metabinner:1.4.4--hdfd78af_1
stdout: metabinner_run_metabinner.sh.out
