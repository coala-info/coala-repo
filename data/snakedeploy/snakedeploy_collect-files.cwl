cwlVersion: v1.2
class: CommandLineTool
baseCommand: snakedeploy collect-files
label: snakedeploy_collect-files
doc: "Collect files into a tabular structure, given input from STDIN formats glob
  patterns defined in a config sheet.\n\nTool homepage: https://github.com/snakemake/snakedeploy"
inputs:
  - id: config
    type: File
    doc: "A TSV file containing two columns input_pattern and glob_pattern. The input
      pattern is a Python regular expression that selects lines from STDIN, and extracts
      values from it (as groups; example: 'S888_Nr(?P<nr>[0-9]+)'). If possible such
      extracted values are automatically converted to integers. The glob pattern is
      formatted (via the Python format minilanguage) with the values from the input
      pattern and used to glob files from the filesystem. The globbed files are printed
      as TSV next to the matching input value taken from STDIN. If the globbing does
      not return any files for one STDIN input, an error is thrown. If one STDIN input
      is not matched by any of the provided stdin patterns, an error is thrown. If
      one STDIN input is matched by multiple of the provided stdin patterns, an error
      is thrown."
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snakedeploy:0.16.0--pyhdfd78af_0
stdout: snakedeploy_collect-files.out
