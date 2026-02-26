cwlVersion: v1.2
class: CommandLineTool
baseCommand: EvaluateSegmentation
label: visceral-evaluatesegmentation_EvaluateSegmentation
doc: "Evaluate a segmentation against a ground truth.\n\nTool homepage: https://github.com/Visceral-Project/EvaluateSegmentation"
inputs:
  - id: groundtruth_path
    type: string
    doc: Path (or URL) to groundtruth image. URLs should be enclosed with 
      quotations
    inputBinding:
      position: 1
  - id: segment_path
    type: string
    doc: Path (or URL) to image being evaluated. URLs should be enclosed with 
      quotations
    inputBinding:
      position: 2
  - id: no_streaming
    type:
      - 'null'
      - boolean
    doc: Don't use streaming filter! Streaming filter is used to handle very 
      large images. Use this option with small images (up to 200X200X200 voxels)
      to avoid time efort related with streaming.
    inputBinding:
      position: 103
      prefix: -nostreaming
  - id: threshold
    type:
      - 'null'
      - float
    doc: Before evaluation convert fuzzy images to binary using threshold
    inputBinding:
      position: 103
      prefix: -thd
  - id: unit
    type:
      - 'null'
      - string
    doc: Specify whether millimeter or voxel to be used as a unit for distances 
      and volumes
    default: voxel
    inputBinding:
      position: 103
      prefix: -unit
  - id: use_metrics
    type:
      - 'null'
      - string
    doc: The metrics to be used. Note that additional options can be given 
      between two @ characters.
    default: all
    inputBinding:
      position: 103
      prefix: -use
outputs:
  - id: xml_path
    type:
      - 'null'
      - File
    doc: Path to xml file where result should be saved
    outputBinding:
      glob: $(inputs.xml_path)
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/visceral-evaluatesegmentation:2021.03.25--h287ed61_0
