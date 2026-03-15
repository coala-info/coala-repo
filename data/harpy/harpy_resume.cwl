cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - harpy
  - resume
label: harpy_resume
doc: Continue an incomplete Harpy workflow by bypassing preprocessing steps and 
  executing the Snakemake command present in the target directory.
inputs:
  - id: directory
    type: Directory
    doc: The Harpy output directory containing the workflow to resume
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
  - id: direct
    type:
      - 'null'
      - boolean
    doc: Call Snakemake directly without Harpy intervention
    inputBinding:
      position: 102
      prefix: --direct
  - id: threads
    type:
      - 'null'
      - int
    doc: Change the number of threads (>1)
    inputBinding:
      position: 102
      prefix: --threads
  - id: quiet
    type:
      - 'null'
      - int
    doc: 0 all output, 1 progress bar, 2 no output
    inputBinding:
      position: 102
      prefix: --quiet
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/harpy:3.2--pyhdfd78af_0
stdout: harpy_resume.out
s:url: https://github.com/pdimens/harpy/
$namespaces:
  s: https://schema.org/
