cwlVersion: v1.2
class: CommandLineTool
baseCommand: RepEnrich_setup.py
label: repenrich_RepEnrich_setup.py
doc: "The provided text does not contain help information for the tool; it is a log
  of a container build failure (Singularity/Apptainer). RepEnrich_setup.py is typically
  used to prepare the genome and annotation files for RepEnrich analysis.\n\nTool
  homepage: https://github.com/nskvir/RepEnrich"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/repenrich:1.2--py27_1
stdout: repenrich_RepEnrich_setup.py.out
