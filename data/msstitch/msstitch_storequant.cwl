cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - msstitch
  - storequant
label: msstitch_storequant
doc: "Store quantitative data from various MS1 quantitation tools.\n\nTool homepage:
  https://github.com/lehtiolab/msstitch"
inputs:
  - id: apex
    type:
      - 'null'
      - boolean
    doc: Use MS1 peak envelope apex instead of peak sum when storing quant data.
    inputBinding:
      position: 101
      prefix: --apex
  - id: dbfile
    type: File
    doc: Database lookup file
    inputBinding:
      position: 101
      prefix: --dbfile
  - id: dinosaur
    type:
      - 'null'
      - type: array
        items: File
    doc: MS1 persisting peptide output files from Dinosaur in text 
      format.Multiple files can be specified, and matching order with spectra 
      files is important.
    inputBinding:
      position: 101
      prefix: --dinosaur
  - id: in_memory
    type:
      - 'null'
      - boolean
    doc: Load sqlite lookup in memory in case of not having access to a fast 
      file system
    inputBinding:
      position: 101
      prefix: --in-memory
  - id: isobaric
    type:
      - 'null'
      - type: array
        items: File
    doc: Isobaric quant output files from OpenMS in consensusXML format. 
      Multiple files can be specified, and matching order with spectra files is 
      important.
    inputBinding:
      position: 101
      prefix: --isobaric
  - id: kronik
    type:
      - 'null'
      - type: array
        items: File
    doc: MS1 persisting peptide quant output files from Kronik in text 
      format.Multiple files can be specified, and matching order with spectra 
      files is important.
    inputBinding:
      position: 101
      prefix: --kronik
  - id: mztol
    type:
      - 'null'
      - float
    doc: Specifies tolerance in mass-to-charge when mapping MS1 feature quant 
      info to identifications in the PSM table.
    inputBinding:
      position: 101
      prefix: --mztol
  - id: mztoltype
    type:
      - 'null'
      - string
    doc: Type of tolerance in mass-to-charge when mapping MS1 feature quant info
      to identifications in the PSM table. One of ppm, Da.
    inputBinding:
      position: 101
      prefix: --mztoltype
  - id: rttol
    type:
      - 'null'
      - float
    doc: Specifies tolerance in seconds for retention time when mapping MS1 
      feature quant info to identifications in the PSM table.
    inputBinding:
      position: 101
      prefix: --rttol
  - id: spectra
    type:
      type: array
      items: File
    doc: Spectra files in mzML format. Multiple files can be specified, if order
      is important, e.g. when matching them with quant data, the order will be 
      their input order at the command line.
    inputBinding:
      position: 101
      prefix: --spectra
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/msstitch:3.19--pyhdfd78af_0
stdout: msstitch_storequant.out
