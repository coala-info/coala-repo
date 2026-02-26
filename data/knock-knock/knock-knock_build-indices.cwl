cwlVersion: v1.2
class: CommandLineTool
baseCommand: knock-knock build-indices
label: knock-knock_build-indices
doc: "Build indices for a genome.\n\nTool homepage: https://github.com/jeffhussmann/knock-knock"
inputs:
  - id: base_dir
    type: Directory
    doc: the base directory to store input data, reference annotations, and 
      analysis output for a project
    inputBinding:
      position: 1
  - id: genome_name
    type: string
    doc: name of genome to build indices for
    inputBinding:
      position: 2
  - id: num_threads
    type:
      - 'null'
      - int
    doc: number of threads to use
    inputBinding:
      position: 103
      prefix: --num-threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/knock-knock:0.8.0--pyhdfd78af_0
stdout: knock-knock_build-indices.out
