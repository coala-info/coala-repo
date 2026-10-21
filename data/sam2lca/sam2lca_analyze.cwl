cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sam2lca
label: sam2lca_analyze
doc: "Run the sam2lca analysis\n\nTool homepage: https://github.com/maxibor/sam2lca"
arguments:
  - position: 2
    valueFrom: analyze
inputs:
  - id: dbdir
    type: Directory
    doc: Directory with the taxonomy and acc2tax databases (global option --dbdir)
    inputBinding:
      position: 1
      prefix: --dbdir
      valueFrom: $(self.basename)
  - id: sam_file
    type: File
    secondaryFiles:
      - pattern: .bai
        required: false
      - pattern: .crai
        required: false
    doc: path to SAM/BAM/CRAM alignment file
    inputBinding:
      position: 200
  - id: acc2tax
    type:
      - 'null'
      - string
    doc: acc2tax database to use
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
      - string
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
    inputBinding:
      position: 102
      prefix: --length
  - id: process
    type:
      - 'null'
      - int
    doc: Number of process for parallelization
    inputBinding:
      position: 102
      prefix: --process
  - id: taxonomy
    type:
      - 'null'
      - string
    doc: Taxonomy database to use
    inputBinding:
      position: 102
      prefix: --taxonomy
  - id: output
    type: string
    default: sam2lca_result
    doc: 'sam2lca output file prefix. Default: [basename].sam2lca.*'
    inputBinding:
      position: 103
      prefix: --output
outputs:
  - id: output_files
    type:
      type: array
      items: File
    doc: 'sam2lca output files: [output].sam2lca.csv, .json and optional BAM files'
    outputBinding:
      glob: $(inputs.output)*
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.dbdir)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sam2lca:1.1.4--pyhdfd78af_0
