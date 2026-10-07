cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - dfpl
  - predict
label: deepfplearn_predict
doc: "Predict your data with existing models.\n\nTool homepage: https://github.com/yigbt/deepFPlearn"
inputs:
  - id: configFile
    type:
      - 'null'
      - File
    doc: Input JSON file that contains all information for training/predicting.
    inputBinding:
      position: 1
      prefix: --configFile
  - id: inputFile
    type:
      - 'null'
      - File
    doc: The file containing the data for the prediction in (unquoted) comma separated CSV
      format. The column named 'smiles' or 'fp'contains the field to be predicted. Please
      adjust the type that should be predicted (fp or smile) with -t option appropriately.An
      optional column 'id' is used to assign the outcomes to theoriginal identifiers. If this
      column is missing, the results arenumbered in the order of their appearance in the input
      file.A header is expected and respective column names are used.
    inputBinding:
      position: 1
      prefix: --inputFile
  - id: outputDir
    type:
      - 'null'
      - string
    doc: Prefix of output directory. It will contain a log file and the file specifiedwith
      --outputFile.
    default: dfpl_predict
    inputBinding:
      position: 1
      prefix: --outputDir
  - id: outputFile
    type:
      - 'null'
      - string
    doc: 'Output .CSV file name which will contain one prediction per input line. Default:
      prefix of input file name.'
    inputBinding:
      position: 1
      prefix: --outputFile
  - id: type
    type:
      - 'null'
      - string
    doc: 'Type of the chemical representation. Choices: ''fp'', ''smiles''.'
    inputBinding:
      position: 1
      prefix: --type
  - id: fpType
    type:
      - 'null'
      - string
    doc: The type of fingerprint to be generated/used in input file.
    inputBinding:
      position: 1
      prefix: --fpType
  - id: ecModelDir
    type:
      - 'null'
      - Directory
    doc: The directory where the full model of the encoder will be saved (if trainAE=True)
      or loaded from (if trainAE=False). Provide a full path here.
    inputBinding:
      position: 1
      prefix: --ecModelDir
  - id: fnnModelDir
    type:
      - 'null'
      - Directory
    doc: The directory where the full model of the fnn is loaded from. Provide a full path
      here.
    inputBinding:
      position: 1
      prefix: --fnnModelDir
  - id: compressFeatures
    type:
      - 'null'
      - boolean
    doc: --compressFeatures option (passed as True or an empty value, which the tool reads
      as false)
    inputBinding:
      position: 1
      prefix: --compressFeatures
      valueFrom: '$(self ? "True" : "")'
  - id: aeType
    type:
      - 'null'
      - string
    doc: --aeType option
    inputBinding:
      position: 1
      prefix: --aeType
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_dir
    type: Directory
    doc: Prediction CSV file and predict.log
    outputBinding:
      glob: $(inputs.outputDir)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deepfplearn:2.1--pyh42286b9_1
stdout: deepfplearn_predict.out
