cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - MotifRaptor
  - motifspecific
label: motifraptor_motifspecific
doc: "Motifs specific analysis\n\nTool homepage: https://github.com/pinellolab/MotifRaptor"
inputs:
  - id: workdir
    type:
      - 'null'
      - string
    doc: "Working directory"
    inputBinding:
      position: 1
      prefix: -wd
  - id: snp_motif_file
    type:
      - 'null'
      - File
    doc: "SNP motif pair-wise list File, usually from step2"
    inputBinding:
      position: 1
      prefix: -sm
  - id: motif_id
    type:
      - 'null'
      - string
    doc: "motif id with name, in the format of motifID__NAME"
    inputBinding:
      position: 1
      prefix: -md
  - id: bg_score_folder
    type:
      - 'null'
      - Directory
    doc: "background score folder, usually from step2"
    inputBinding:
      position: 1
      prefix: -bs
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: "Output directory (the working directory of the run)"
    outputBinding:
      glob: $(inputs.workdir)
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/motifraptor:0.3.0--py36h40b2fa4_5
stdout: motifraptor_motifspecific.out
