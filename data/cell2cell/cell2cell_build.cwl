cwlVersion: v1.2
class: CommandLineTool
baseCommand: cell2cell_build
label: cell2cell_build
doc: "The provided text appears to be a log of a failed container build process (Singularity/Apptainer)
  rather than CLI help text for the tool 'cell2cell_build'. No command-line arguments,
  flags, or usage instructions were found in the input.\n\nTool homepage: https://github.com/earmingol/cell2cell"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cell2cell:0.8.4--pyhdfd78af_0
stdout: cell2cell_build.out
