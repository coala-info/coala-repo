cwlVersion: v1.2
class: Workflow
inputs:
    DT5301:
        type: Directory
    DT5302:
        type: Directory
    DT5303:
        type: Directory
    DT5304:
        type: Directory
    DT5308:
        type: Directory
    DT5309:
        type: Directory
    DT5311:
        type: Directory
outputs:
    DT5305:
        type: Directory
        outputSource:
            - ST530102/DT5305
    DT5306:
        type: Directory
        outputSource:
            - ST530103/DT5306
    DT5307:
        type: Directory
        outputSource:
            - ST530105/DT5307
    DT5310:
        type: Directory
        outputSource:
            - ST530101/DT5310
requirements:
    SubworkflowFeatureRequirement: {}
steps:
    ST530101:
        run: ST530101.cwl
        in:
            DT5301: DT5301
            DT5302: DT5302
            DT5303: DT5303
            DT5304: DT5304
            DT5308: DT5308
            DT5309: DT5309
        out:
            - DT5310
    ST530102:
        run: ST530102.cwl
        in:
            DT5302: DT5302
            DT5304: DT5304
            DT5308: DT5308
            DT5309: DT5309
        out:
            - DT5305
    ST530103:
        run: ST530103.cwl
        in:
            DT5303: DT5303
            DT5305: ST530102/DT5305
        out:
            - DT5306
    ST530104:
        run: ST530104.cwl
        in:
            DT5306: ST530103/DT5306
            DT5308: DT5308
            DT5309: DT5309
        out: []
    ST530105:
        run: ST530105.cwl
        in:
            DT5306: ST530103/DT5306
            DT5308: DT5308
            DT5309: DT5309
            DT5311: DT5311
        out:
            - DT5307
