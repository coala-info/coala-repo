cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - MotifRaptor
  - snpmotif
label: motifraptor_snpmotif
doc: "SNP motif test\n\nTool homepage: https://github.com/pinellolab/MotifRaptor"
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
  - id: hit_snp_union_bed
    type:
      - 'null'
      - File
    doc: "hit snps on union bed file, usually from step1"
    inputBinding:
      position: 1
      prefix: -sb
  - id: hit_snp_union
    type:
      - 'null'
      - File
    doc: "hit snps with sequence information, usually from step1"
    inputBinding:
      position: 1
      prefix: -se
  - id: bg_snps
    type:
      - 'null'
      - string
    doc: "background snp list file or (genome)"
    inputBinding:
      position: 1
      prefix: -bg
  - id: motif_list
    type:
      - 'null'
      - string
    doc: "motif list file, no header, or (all)"
    inputBinding:
      position: 1
      prefix: -m
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
stdout: motifraptor_snpmotif.out
