cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - knock-knock
  - download-genome
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
  - id: project_dir
    type: Directory
    doc: The project directory with the files written by this command.
    outputBinding:
      glob: $(inputs.base_dir.basename)
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.base_dir)
        writable: true
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/knock-knock:0.8.0--pyhdfd78af_0
stdout: knock-knock_download-genome.out
