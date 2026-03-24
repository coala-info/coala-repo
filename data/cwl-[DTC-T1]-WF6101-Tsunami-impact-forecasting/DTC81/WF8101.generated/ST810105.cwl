cwlVersion: v1.2
class: Workflow
inputs:
    raw_catalog: Directory
outputs:
    DT810105:
        type: Directory
        outputSource:
            - ST810105/DT810105
steps:
    ST810105:
        run:
            class: Operation
            inputs:
                raw_catalog: Directory
            outputs:
                DT810105: Directory
        in:
            raw_catalog: raw_catalog
        out:
            - DT810105
