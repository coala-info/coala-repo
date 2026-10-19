cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - repic
  - run_ilp
label: repic_run_ilp
doc: "Run the ILP solver to find the optimal particle configuration.\n\nTool homepage:
  https://github.com/ccameron/REPIC"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.in_dir)
        writable: true
inputs:
  - id: in_dir
    type: Directory
    doc: path to input directory containing get_cliques.py output (staged
      writable, because run_ilp writes the consensus BOX files into it)
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
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
  - id: out_dir
    type: Directory
    doc: The input directory with the consensus BOX files added
    outputBinding:
      glob: $(inputs.in_dir.basename)
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/repic:1.0.0--pyhdfd78af_0
stdout: repic_run_ilp.out
