cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hic2cool
  - update
label: hic2cool_update
doc: "update a cooler file produced by hic2cool\n\nTool homepage: https://github.com/4dn-dcic/hic2cool"
inputs:
  - id: infile
    type: File
    doc: cooler input file path (copied to the working directory; without outfile_path it is updated in place)
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
  - id: silent
    type:
      - 'null'
      - boolean
    default: true
    doc: if used, silence standard program output. Without it the tool asks an interactive y/n question, so it defaults to true here.
    inputBinding:
      position: 102
      prefix: --silent
  - id: warnings
    type:
      - 'null'
      - boolean
    doc: if used, print out non-critical WARNING messages, which are hidden by 
      default. Silent mode takes precedence over this
    inputBinding:
      position: 102
      prefix: --warnings
  - id: outfile_path
    type:
      - 'null'
      - string
    doc: optional new output file path
    inputBinding:
      position: 103
      prefix: --outfile
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: optional new output file path
    outputBinding:
      glob: $(inputs.outfile_path)
  - id: updated_infile
    type: File
    doc: the input cooler file (updated in place when outfile_path is not given)
    outputBinding:
      glob: $(inputs.infile.basename)
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.infile)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hic2cool:1.0.1--pyh7cba7a3_0
