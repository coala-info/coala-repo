class: Workflow
cwlVersion: v1.2.0-dev2
doc: 'Abstract CWL Automatically generated from the Galaxy workflow file: YOLO - Tail
  analysis training workflow'
inputs:
  0_Input Dataset Collection:
    format: data
    type: File
  Class File:
    format: data
    type: File
outputs: {}
steps:
  2_Perform histogram equalization:
    in:
      input: 0_Input Dataset Collection
    out:
    - output
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_imgteam_2d_histogram_equalization_ip_histogram_equalization_0_18_1+galaxy0
      inputs:
        input:
          format: Any
          type: File
      outputs:
        output:
          doc: tiff
          type: File
  3_Convert image format:
    in:
      input: 2_Perform histogram equalization/output
    out:
    - output
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_bgruening_graphicsmagick_image_convert_graphicsmagick_image_convert_1_3_45+galaxy0
      inputs:
        input:
          format: Any
          type: File
      outputs:
        output:
          doc: png
          type: File
  4_AnyLabeling Interactive:
    in:
      input_images: 3_Convert image format/output
    out:
    - al_output
    - version
    run:
      class: Operation
      id: interactive_tool_anylabeling
      inputs:
        input_images:
          format: Any
          type: File
      outputs:
        al_output:
          doc: input
          type: File
        version:
          doc: txt
          type: File
  5_Convert AnyLabeling JSON to YOLO text:
    in:
      class_name: Class File
      in_json: 4_AnyLabeling Interactive/al_output
    out:
    - output_yolo
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_bgruening_json2yolosegment_json2yolosegment_8_3_0+galaxy2
      inputs:
        class_name:
          format: Any
          type: File
        in_json:
          format: Any
          type: File
      outputs:
        output_yolo:
          doc: input
          type: File
  6_Perform YOLO training:
    in:
      input_images: 3_Convert image format/output
      input_yolo: 5_Convert AnyLabeling JSON to YOLO text/output_yolo
    out:
    - best_model
    - last_model
    - metrics_csv
    - metrics_plot
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_bgruening_yolo_training_yolo_training_8_3_0+galaxy2
      inputs:
        input_images:
          format: Any
          type: File
        input_yolo:
          format: Any
          type: File
      outputs:
        best_model:
          doc: _sniff_
          type: File
        last_model:
          doc: _sniff_
          type: File
        metrics_csv:
          doc: csv
          type: File
        metrics_plot:
          doc: png
          type: File

