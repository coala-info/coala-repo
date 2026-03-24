cwlVersion: v1.2
class: Workflow
inputs: {}
outputs:
    DT5401:
        type: Directory
        outputSource:
            - ST540101/DT5401
    DT5402:
        type: Directory
        outputSource:
            - ST540102/DT5402
    DT5403:
        type: Directory
        outputSource:
            - ST540103/DT5403
    DT5404:
        type: Directory
        outputSource:
            - ST540103/DT5404
    DT5405:
        type: Directory
        outputSource:
            - ST540104/DT5405
requirements:
    SubworkflowFeatureRequirement: {}
steps:
    ST540101:
        run: ST540101.cwl
        in: {}
        out:
            - DT5401
    ST540102:
        run: ST540102.cwl
        in:
            DT5401: ST540101/DT5401
        out:
            - DT5402
    ST540103:
        run: ST540103.cwl
        in:
            DT5403: ST540103/DT5403
        out:
            - DT5403
            - DT5404
    ST540104:
        run: ST540104.cwl
        in:
            DT5402: ST540102/DT5402
            DT5404: ST540103/DT5404
        out:
            - DT5405
    ST540205:
        run: ST540205.cwl
        in: {}
        out: []
