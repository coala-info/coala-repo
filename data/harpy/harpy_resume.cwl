cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - harpy
  - resume
label: harpy_resume
doc: "Continue an incomplete Harpy workflow. Bypasses preprocessing steps and executes
  the Snakemake command present in the directory.\n\nTool homepage: https://github.com/pdimens/harpy/"
inputs:
  - id: directory
    type: Directory
    doc: Harpy output directory containing the workflow to resume
    inputBinding:
      position: 1
  - id: absolute
    type:
      - 'null'
      - boolean
    doc: Call Snakemake with absolute paths
    inputBinding:
      position: 102
      prefix: --absolute
  - id: conda
    type:
      - 'null'
      - boolean
    doc: Recreate the conda environments
    inputBinding:
      position: 102
      prefix: --conda
  - id: quiet
    type:
      - 'null'
      - int
    doc: 0 all output, 1 progress bar, 2 no output
    inputBinding:
      position: 102
      prefix: --quiet
  - id: threads
    type:
      - 'null'
      - int
    doc: Change the number of threads (>1)
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/harpy:3.1--pyhdfd78af_2
stdout: harpy_resume.out
