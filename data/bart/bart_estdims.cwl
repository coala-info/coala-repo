cwlVersion: v1.2
class: CommandLineTool
baseCommand: [bart, estdims]
requirements:
  - class: InlineJavascriptRequirement
label: bart_estdims
doc: "Estimate image dimension from non-Cartesian trajectory.\nAssume trajectory scaled
  to -DIM/2 to DIM/2 (ie dk=1/FOV=1)\n\nTool homepage: https://github.com/mrirecon/bart"
inputs:
  - id: traj
    type: File
    doc: Trajectory file
    secondaryFiles:
      - ^.hdr
    inputBinding:
      position: 10
      valueFrom: $(self.path.replace(/\.cfl$/, ''))
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1
stdout: bart_estdims.out
