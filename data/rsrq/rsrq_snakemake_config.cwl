cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rsrq
  - snakemake
  - config
label: rsrq_snakemake_config
doc: "Write the Snakemake cluster profile to the target directory\n\nTool homepage: https://github.com/aaronmussig/rsrq"
inputs:
  - id: directory
    type: string
    doc: The target directory to write the profile to
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: stderr
    type: stderr
    doc: Log messages (rsrq writes its results to standard error)
  - id: profile_dir
    type: Directory
    doc: Snakemake cluster profile
    outputBinding:
      glob: $(inputs.directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rsrq:1.1.0--h4349ce8_0
stdout: rsrq_snakemake_config.out
stderr: rsrq_snakemake_config.err
