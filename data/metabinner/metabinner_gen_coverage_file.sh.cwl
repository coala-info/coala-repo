cwlVersion: v1.2
class: CommandLineTool
baseCommand: metabinner_gen_coverage_file.sh
label: metabinner_gen_coverage_file.sh
doc: "A script to generate coverage files for MetaBinner. (Note: The provided help
  text contains only system error messages and no usage information.)\n\nTool homepage:
  https://github.com/ziyewang/MetaBinner"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metabinner:1.4.4--hdfd78af_1
stdout: metabinner_gen_coverage_file.sh.out
