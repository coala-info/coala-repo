cwlVersion: v1.2
class: CommandLineTool
baseCommand: frc_train_frcnn_kitti.py
label: frc_train_frcnn_kitti.py
doc: "Train a Faster R-CNN model on the KITTI dataset.\n\nTool homepage: https://github.com/lucasjinreal/keras_frcnn"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/frc:5b3f53e--boost1.64_0
stdout: frc_train_frcnn_kitti.py.out
