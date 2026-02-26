cwlVersion: v1.2
class: CommandLineTool
baseCommand: parm_mutagenesis
label: parm_mutagenesis
doc: "Promoter Activity Regulatory Model\n\nTool homepage: https://github.com/vansteensellab/PARM"
inputs:
  - id: filter_size
    type:
      - 'null'
      - int
    doc: The model size that torch expects
    default: 125
    inputBinding:
      position: 101
      prefix: --filter_size
  - id: input
    type: File
    doc: Path to the input fasta file with the sequences to have to mutagenesis 
      for.
    inputBinding:
      position: 101
      prefix: --input
  - id: l_max
    type:
      - 'null'
      - int
    doc: The maximum length of the sequences allowed by the model. All 
      pre-trained models have `--L_max 600`. However, if you trained your own 
      PARM model with a different L_max value, you should specify it here.
    default: 600
    inputBinding:
      position: 101
      prefix: --L_max
  - id: model
    type: Directory
    doc: Path to the directory of the model. If you want to perform predictions 
      for the pre-trained K562 model, for instance, this should be 
      pre_trained_models/K562. If you have trained your own model, you should 
      pass the path to the directory where the .parm files are stored.
    inputBinding:
      position: 101
      prefix: --model
  - id: motif_database
    type:
      - 'null'
      - File
    doc: Path or url to the motif databae (JASPAR format).
    default: 'HOCOMOCOv11: https://hocomoco11.autosome.org/final_bundle/hocomoco11/core/HUMAN/mono/HOCOMOCO
      v11_core_HUMAN_mono_jaspar_format.txt'
    inputBinding:
      position: 101
      prefix: --motif_database
outputs:
  - id: output
    type: Directory
    doc: Path to the directory where the files will be stored. Will be created 
      if it does not exist.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/parm:0.1.44--pyh7e72e81_0
