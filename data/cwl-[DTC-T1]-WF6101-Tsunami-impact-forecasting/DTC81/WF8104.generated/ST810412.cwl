cwlVersion: v1.2
class: Workflow
inputs:
    ground_motion_params: Directory
    path_char: Directory
    site_char: Directory
    source_char_param: Directory
outputs:
    DT810412:
        type: Directory
        outputSource:
            - ST810412/DT810412
steps:
    ST810412:
        run:
            class: Operation
            inputs:
                ground_motion_params: Directory
                path_char: Directory
                site_char: Directory
                source_char_param: Directory
            outputs:
                DT810412: Directory
        in:
            ground_motion_params: ground_motion_params
            path_char: path_char
            site_char: site_char
            source_char_param: source_char_param
        out:
            - DT810412
