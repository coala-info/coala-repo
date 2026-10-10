cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - MotifRaptor
  - snpscan
label: motifraptor_snpscan
doc: "Scan SNP database (already indexed)\n\nTool homepage: https://github.com/pinellolab/MotifRaptor"
inputs:
  - id: indexed_genome_db
    type:
      - 'null'
      - Directory
    doc: "indexed genome_database_folder"
    inputBinding:
      position: 1
      prefix: -gi
  - id: pfm_folder
    type:
      - 'null'
      - Directory
    doc: "motif pmf files folder"
    inputBinding:
      position: 1
      prefix: -pfm
  - id: motifscan_output
    type:
      - 'null'
      - string
    doc: "Motif Scan Output Folder. Default: ./motifscanfiles"
    inputBinding:
      position: 1
      prefix: -mo
  - id: thread_num
    type:
      - 'null'
      - int
    doc: "number of threads"
    inputBinding:
      position: 1
      prefix: -p
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: "Output directory (the working directory of the run)"
    outputBinding:
      glob: $(inputs.motifscan_output)
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/motifraptor:0.3.0--py36h40b2fa4_5
stdout: motifraptor_snpscan.out
