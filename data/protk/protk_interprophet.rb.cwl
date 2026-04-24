cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - interprophet.rb
label: protk_interprophet.rb
doc: "Run InterProphet on a set of pep.xml input files.\n\nTool homepage: https://github.com/iracooke/protk"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: Input pep.xml files
    inputBinding:
      position: 1
  - id: no_nrs
    type:
      - 'null'
      - boolean
    doc: Don't use NRS (Number of Replicate Spectra) in Model
    inputBinding:
      position: 102
      prefix: --no-nrs
  - id: no_nse
    type:
      - 'null'
      - boolean
    doc: Don't use NSE (Number of Sibling Experiments) in Model
    inputBinding:
      position: 102
      prefix: --no-nse
  - id: no_nsi
    type:
      - 'null'
      - boolean
    doc: Don't use NSE (Number of Sibling Ions) in Model
    inputBinding:
      position: 102
      prefix: --no-nsi
  - id: no_nsm
    type:
      - 'null'
      - boolean
    doc: Don't use NSE (Number of Sibling Modifications) in Model
    inputBinding:
      position: 102
      prefix: --no-nsm
  - id: no_nss
    type:
      - 'null'
      - boolean
    doc: Don't use NSS (Number of Sibling Searches) in Model
    inputBinding:
      position: 102
      prefix: --no-nss
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: A string to prepend to the name of output files
    inputBinding:
      position: 102
      prefix: --output-prefix
  - id: p_thresh
    type:
      - 'null'
      - float
    doc: Probability threshold below which PSMs are discarded
    inputBinding:
      position: 102
      prefix: --p-thresh
  - id: replace_output
    type:
      - 'null'
      - boolean
    doc: Dont skip analyses for which the output file already exists
    inputBinding:
      position: 102
      prefix: --replace-output
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of processing threads to use. Set to 0 to autodetect an 
      appropriate value
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: An explicitly named output file.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/protk:1.4.4a--hc9114bc_1
