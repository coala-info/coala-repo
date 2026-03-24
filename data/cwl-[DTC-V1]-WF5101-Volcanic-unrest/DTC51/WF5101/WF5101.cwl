cwlVersion: v1.2
class: Workflow
inputs:
    DT5102:
        type: Directory
    DT5104:
        type: Directory
    DT5109:
        type: Directory
outputs:
    DT5101:
        type: Directory
        outputSource:
            - ST510103/DT5101
    DT5103:
        type: Directory
        outputSource:
            - ST510107/DT5103
    DT5105:
        type: Directory
        outputSource:
            - ST510102/DT5105
    DT5110:
        type: Directory
        outputSource:
            - ST510110/DT5110
    DT5111:
        type: Directory
        outputSource:
            - ST510109/DT5111
requirements:
    SubworkflowFeatureRequirement: {}
steps:
    ST510101:
        run: ST510101.cwl
        in:
            DT5104: DT5104
        out: []
    ST510102:
        run: ST510102.cwl
        in: {}
        out:
            - DT5105
    ST510103:
        run: ST510103.cwl
        in: {}
        out:
            - DT5101
    ST510107:
        run: ST510107.cwl
        in:
            DT5101: ST510103/DT5101
            DT5102: DT5102
        out:
            - DT5103
    ST510109:
        run: ST510109.cwl
        in:
            DT5105: ST510102/DT5105
        out:
            - DT5111
    ST510110:
        run: ST510110.cwl
        in:
            DT5109: DT5109
        out:
            - DT5110
    ST510111:
        run: ST510111.cwl
        in:
            DT5111: ST510109/DT5111
        out: []
    ST510112:
        run: ST510112.cwl
        in:
            DT5111: ST510109/DT5111
        out: []
