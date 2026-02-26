cwlVersion: v1.2
class: CommandLineTool
baseCommand: msstitch storespectra
label: msstitch_storespectra
doc: "Stores spectra from mzML files into a database.\n\nTool homepage: https://github.com/lehtiolab/msstitch"
inputs:
  - id: dbfile
    type:
      - 'null'
      - File
    doc: Database lookup file
    inputBinding:
      position: 101
      prefix: --dbfile
  - id: in_memory
    type:
      - 'null'
      - boolean
    doc: Load sqlite lookup in memory in case of not having access to a fast 
      file system
    inputBinding:
      position: 101
      prefix: --in-memory
  - id: setnames
    type:
      - 'null'
      - type: array
        items: string
    doc: Names of biological sets. Can be specified with quotation marks if 
      spaces are used
    inputBinding:
      position: 101
      prefix: --setnames
  - id: spectra
    type:
      - 'null'
      - type: array
        items: File
    doc: Spectra files in mzML format. Multiple files can be specified, if order
      is important, e.g. when matching them with quant data, the order will be 
      their input order at the command line.
    inputBinding:
      position: 101
      prefix: --spectra
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: Output file
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/msstitch:3.19--pyhdfd78af_0
