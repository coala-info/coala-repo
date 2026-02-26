cwlVersion: v1.2
class: CommandLineTool
baseCommand: repic_run_ilp
label: repic_run_ilp
doc: "Run the ILP solver to find the optimal particle configuration.\n\nTool homepage:
  https://github.com/ccameron/REPIC"
inputs:
  - id: in_dir
    type: Directory
    doc: path to input directory containing get_cliques.py output
    inputBinding:
      position: 1
  - id: box_size
    type: int
    doc: particle bounding box size (in int[pixels])
    inputBinding:
      position: 2
  - id: num_particles
    type:
      - 'null'
      - int
    doc: filter for the number of expected particles (int)
    inputBinding:
      position: 103
      prefix: --num_particles
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/repic:1.0.0--pyhdfd78af_0
stdout: repic_run_ilp.out
