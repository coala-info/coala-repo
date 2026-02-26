cwlVersion: v1.2
class: CommandLineTool
baseCommand: knock-knock download-genome
label: knock-knock_download-genome
doc: "Download a genome and its associated annotations.\n\nTool homepage: https://github.com/jeffhussmann/knock-knock"
inputs:
  - id: base_dir
    type: Directory
    doc: the base directory to store input data, reference annotations, and 
      analysis output for a project
    inputBinding:
      position: 1
  - id: genome_name
    type: string
    doc: name of genome to download
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/knock-knock:0.8.0--pyhdfd78af_0
stdout: knock-knock_download-genome.out
