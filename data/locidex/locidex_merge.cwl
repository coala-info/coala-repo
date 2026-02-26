cwlVersion: v1.2
class: CommandLineTool
baseCommand: locidex_merge
label: locidex_merge
doc: "Merge a set of gene profiles into a standard profile format\n\nTool homepage:
  https://pypi.org/project/locidex/"
inputs:
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite existing directory
    inputBinding:
      position: 101
      prefix: --force
  - id: input_files
    type:
      type: array
      items: File
    doc: Input file to report
    inputBinding:
      position: 101
      prefix: --input
  - id: loci
    type:
      - 'null'
      - string
    doc: Specifies a file (or command-separated list) of loci to keep from MLST 
      files
    inputBinding:
      position: 101
      prefix: --loci
  - id: profile_ref
    type:
      - 'null'
      - File
    doc: Provide a TSV file with profile references for overriding MLST 
      profiles. Columns [sample/sample_name,mlst_alleles]
    inputBinding:
      position: 101
      prefix: --profile_ref
  - id: strict
    type:
      - 'null'
      - boolean
    doc: Only merge data produces by the same db
    inputBinding:
      position: 101
      prefix: --strict
outputs:
  - id: outdir
    type: Directory
    doc: Output file to put results
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/locidex:0.4.0--pyhdfd78af_0
