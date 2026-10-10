cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - MotifRaptor
  - celltype
label: motifraptor_celltype
doc: "Cell type or tissue type analysis\n\nTool homepage: https://github.com/pinellolab/MotifRaptor"
inputs:
  - id: snp_hit_vcf
    type:
      - 'null'
      - File
    doc: "need header and columns in this text file with sequence (CHR is only a number): ID CHR POS REF ALT"
    inputBinding:
      position: 1
      prefix: -vcf
  - id: snp_hit
    type:
      - 'null'
      - File
    doc: "need header and columns in this text file (CHR is only a number): ID CHR POS"
    inputBinding:
      position: 1
      prefix: -sh
  - id: snp_non_hit
    type:
      - 'null'
      - File
    doc: "need header and columns in this text file (CHR is only a number): ID CHR POS"
    inputBinding:
      position: 1
      prefix: -snh
  - id: workdir
    type:
      - 'null'
      - string
    doc: "Working directory"
    inputBinding:
      position: 1
      prefix: -wd
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
      glob: $(inputs.workdir)
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/motifraptor:0.3.0--py36h40b2fa4_5
stdout: motifraptor_celltype.out
