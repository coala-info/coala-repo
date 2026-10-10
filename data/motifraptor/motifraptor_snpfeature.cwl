cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - MotifRaptor
  - snpfeature
label: motifraptor_snpfeature
doc: "SNP feature analysis\n\nTool homepage: https://github.com/pinellolab/MotifRaptor"
inputs:
  - id: workdir
    type:
      - 'null'
      - string
    doc: "Working directory"
    inputBinding:
      position: 1
      prefix: -wd
  - id: cell_type
    type:
      - 'null'
      - string
    doc: "Cell type or Tissue type ID"
    inputBinding:
      position: 1
      prefix: -c
  - id: snp_bed_files
    type:
      - 'null'
      - Directory
    doc: "SNP cell type bed file folder, usually from step1"
    inputBinding:
      position: 1
      prefix: -cb
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
stdout: motifraptor_snpfeature.out
