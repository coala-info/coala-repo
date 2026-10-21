cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sadie
  - reference
  - make
label: sadie-antibody_sadie_reference_make
doc: "make the igblast reference files\n\nThis script will make the imgt reference files used by igblast or airr, including internal data, the blast the blast database, and the auxillary files. It uses the reference.yml to configure select genes and species. If you update the reference.yml file, run this again.\n\nTool homepage: https://sadie.jordanrwillis.com"
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
inputs:
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Vebosity level, ex. -vvvvv for debug level logging
    inputBinding:
      position: 1
      prefix: --verbose
  - id: outpath
    type: string
    doc: Output path to generate blast_db, internal_data and auxillary files
    inputBinding:
      position: 1
      prefix: --outpath
  - id: reference
    type:
      - 'null'
      - File
    doc: Path to reference.yml
    inputBinding:
      position: 1
      prefix: --reference
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_dir
    type: Directory
    doc: Generated reference files
    outputBinding:
      glob: $(inputs.outpath)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sadie-antibody:2.0.0--pyhdfd78af_0
stdout: sadie-antibody_sadie_reference_make.out
