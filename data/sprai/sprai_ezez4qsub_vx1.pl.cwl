cwlVersion: v1.2
class: CommandLineTool
baseCommand: sprai_ezez4qsub_vx1.pl
label: sprai_ezez4qsub_vx1.pl
doc: "Error correction and assembly pipeline\n\nTool homepage: http://zombie.cb.k.u-tokyo.ac.jp/sprai/"
inputs:
  - id: ec_spec
    type: string
    doc: Error correction specification file
    inputBinding:
      position: 1
  - id: asm_spec
    type:
      - 'null'
      - string
    doc: Assembly specification file
    inputBinding:
      position: 2
  - id: ec_only
    type:
      - 'null'
      - boolean
    doc: Does error correction and does NOT assemble
    inputBinding:
      position: 103
      prefix: -ec_only
  - id: no_qsub
    type:
      - 'null'
      - boolean
    doc: Outputs qsub scripts and does NOT qsub
    inputBinding:
      position: 103
      prefix: -n
  - id: restart_dir
    type:
      - 'null'
      - string
    doc: Use a XXX_yyyymmdd_hhmmss directories, detect unfinished jobs and 
      restart at the appropriate stage.
    inputBinding:
      position: 103
      prefix: -now
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sprai:0.9.9.23--py27pl5.22.0_0
stdout: sprai_ezez4qsub_vx1.pl.out
