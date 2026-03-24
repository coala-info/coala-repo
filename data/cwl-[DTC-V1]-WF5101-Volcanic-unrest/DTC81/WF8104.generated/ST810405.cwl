cwlVersion: v1.2
class: Workflow
inputs:
    attribute_range: Directory
    catalog: Directory
    map_selection: Directory
outputs:
    DT810405:
        type: Directory
        outputSource:
            - ST810405/DT810405
steps:
    SS8103:
        run:
            class: Operation
            inputs: {}
            outputs: {}
        in: {}
        out: []
    ST810405:
        run:
            class: Operation
            inputs:
                attribute_range: Directory
                catalog: Directory
                map_selection: Directory
            outputs:
                DT810405: Directory
        in:
            attribute_range: attribute_range
            catalog: catalog
            map_selection: map_selection
        out:
            - DT810405
