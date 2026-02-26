cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sam2lca
  - analyze
label: sam2lca_analyze
doc: "Run the sam2lca analysis\n\nTool homepage: https://github.com/maxibor/sam2lca"
inputs:
  - id: sam_file
    type: File
    doc: path to SAM/BAM/CRAM alignment file
    inputBinding:
      position: 1
  - id: acc2tax
    type:
      - 'null'
      - string
    doc: acc2tax database to use
    default: nucl
    inputBinding:
      position: 102
      prefix: --acc2tax
  - id: bam_out
    type:
      - 'null'
      - boolean
    doc: Write BAM output file with XT tag for TAXID
    inputBinding:
      position: 102
      prefix: --bam_out
  - id: bam_split_rank
    type:
      - 'null'
      - type: array
        items: string
    doc: Write BAM output file split by TAXID at rank -r. To use in combination 
      with -b/--bam_out
    inputBinding:
      position: 102
      prefix: --bam_split_rank
  - id: bam_split_read
    type:
      - 'null'
      - int
    doc: Minimum numbers of reads to write BAM split by TAXID. To use in 
      combination with -b/--bam_out
    default: 50
    inputBinding:
      position: 102
      prefix: --bam_split_read
  - id: conserved
    type:
      - 'null'
      - boolean
    doc: Ignore reads mapping in ultraconserved regions
    inputBinding:
      position: 102
      prefix: --conserved
  - id: distance
    type:
      - 'null'
      - int
    doc: 'Edit distance threshold NOTE: This argument is mutually exclusive with arguments:
      [identity].'
    inputBinding:
      position: 102
      prefix: --distance
  - id: identity
    type:
      - 'null'
      - float
    doc: 'Minimum identity threshold NOTE: This argument is mutually exclusive with
      arguments: [distance].'
    inputBinding:
      position: 102
      prefix: --identity
  - id: length
    type:
      - 'null'
      - int
    doc: Minimum alignment length
    default: 30
    inputBinding:
      position: 102
      prefix: --length
  - id: process
    type:
      - 'null'
      - int
    doc: Number of process for parallelization
    default: 2
    inputBinding:
      position: 102
      prefix: --process
  - id: taxonomy
    type:
      - 'null'
      - string
    doc: Taxonomy database to use
    default: ncbi
    inputBinding:
      position: 102
      prefix: --taxonomy
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: 'sam2lca output file. Default: [basename].sam2lca.*'
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sam2lca:1.1.4--pyhdfd78af_0
