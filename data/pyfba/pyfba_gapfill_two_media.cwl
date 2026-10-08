cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pyfba
  - gapfill_two_media
label: pyfba_gapfill_two_media
doc: "Import a list of reactions and then iterate through our gapfilling steps to see when we get growth. You can specify a single --growth & --nogrowth media conditions\n\nTool homepage: https://linsalrob.github.io/PyFBA/"
inputs:
  - id: reactions
    type: File
    doc: "reactions file"
    inputBinding:
      position: 1
      prefix: --reactions
  - id: growth
    type: File
    doc: "media file on which the organism can grow"
    inputBinding:
      position: 1
      prefix: --growth
  - id: nogrowth
    type:
      - 'null'
      - File
    doc: "media file on which the organism can NOT grow"
    inputBinding:
      position: 1
      prefix: --nogrowth
  - id: close_genomes
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: --close_genomes
    doc: "close genomes reactions file. Multiple files are allowed"
    inputBinding:
      position: 1
  - id: output_path
    type: string
    doc: "file to save new reaction list to"
    inputBinding:
      position: 1
      prefix: --output
  - id: type
    type:
      - 'null'
      - string
    doc: "organism type for the model (currently allowed are ['gramnegative', 'grampositive', 'microbial', 'mycobacteria', 'plant']). Default=gramnegative"
    inputBinding:
      position: 1
      prefix: --type
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "verbose output"
    inputBinding:
      position: 1
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output
    type: File
    doc: "Gap-filled reaction list"
    outputBinding:
      glob: $(inputs.output_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyfba:2.62--py38h3df17bf_5
stdout: pyfba_gapfill_two_media.out
