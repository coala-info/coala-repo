cwlVersion: v1.2
class: Workflow
inputs:
    DT810405: Directory
    Mc: Directory
    Mmax: Directory
    kde_method: Directory
outputs:
    DT810408:
        type: Directory
        outputSource:
            - ST810408/DT810408
steps:
    SS8105:
        run:
            class: Operation
            inputs: {}
            outputs: {}
        in: {}
        out: []
    ST810408:
        run:
            class: Operation
            inputs:
                DT810405: Directory
                Mc: Directory
                Mmax: Directory
                kde_method: Directory
            outputs:
                DT810408: Directory
        in:
            DT810405: DT810405
            Mc: Mc
            Mmax: Mmax
            kde_method: kde_method
        out:
            - DT810408
