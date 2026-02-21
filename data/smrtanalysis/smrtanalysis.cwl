cwlVersion: v1.2
class: CommandLineTool
baseCommand: smrtanalysis
label: smrtanalysis
doc: "SMRT Analysis software suite for processing Single Molecule, Real-Time (SMRT)
  sequencing data.\n\nTool homepage: https://github.com/mhsieh/SMRTAnalysis_2.3.0_install"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/smrtanalysis:v020161126-deb_cv1
stdout: smrtanalysis.out
