cwlVersion: v1.2
class: CommandLineTool
baseCommand: frc_test_frcnn_kitti.py
label: frc_test_frcnn_kitti.py
doc: "A tool for testing Faster R-CNN on the KITTI dataset (Note: The provided help
  text contains only system error messages and no argument definitions).\n\nTool homepage:
  https://github.com/lucasjinreal/keras_frcnn"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/frc:5b3f53e--boost1.64_0
stdout: frc_test_frcnn_kitti.py.out
