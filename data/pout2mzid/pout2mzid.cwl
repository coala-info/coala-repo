cwlVersion: v1.2
class: CommandLineTool
baseCommand: pout2mzid
label: pout2mzid
doc: "Converts Percolator output XML to MzIdentML format.\n\nTool homepage: https://github.com/percolator/pout2mzid"
inputs:
  - id: changeoutput
    type:
      - 'null'
      - string
    doc: Change the outputfile to original filename+[Value]+.mzid.
    inputBinding:
      position: 101
      prefix: --changeoutput
  - id: decoy
    type:
      - 'null'
      - boolean
    doc: Only adds results to entries with decoy set to true.
    inputBinding:
      position: 101
      prefix: --decoy
  - id: filesmzid
    type:
      - 'null'
      - File
    doc: File containing a list of mzIdentML filenames
    inputBinding:
      position: 101
      prefix: --filesmzid
  - id: inputdir
    type:
      - 'null'
      - Directory
    doc: Sets the mzIdentML input directory. All mzIdentML inputfiles must be in
      that directory
    inputBinding:
      position: 101
      prefix: --inputdir
  - id: mzidfile
    type:
      - 'null'
      - File
    doc: MzIdentML input file
    inputBinding:
      position: 101
      prefix: --mzidfile
  - id: outputdir
    type:
      - 'null'
      - Directory
    doc: Sets the output directory if none exist, it will be created.
    inputBinding:
      position: 101
      prefix: --outputdir
  - id: percolatorfile
    type:
      - 'null'
      - File
    doc: Percolator Out XML result file
    inputBinding:
      position: 101
      prefix: --percolatorfile
  - id: validate
    type:
      - 'null'
      - boolean
    doc: Sets that validation of XML schema should not be performed. Faster 
      parsing.
    inputBinding:
      position: 101
      prefix: --validate
  - id: warning
    type:
      - 'null'
      - boolean
    doc: Sets that upon warning the software should terminate.
    inputBinding:
      position: 101
      prefix: --warning
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pout2mzid:0.3.03--boost1.62_2
stdout: pout2mzid.out
