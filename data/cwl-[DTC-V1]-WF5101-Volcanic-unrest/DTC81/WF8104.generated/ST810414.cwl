cwlVersion: v1.2
class: Workflow
inputs:
    DT810406: Directory
    DT810407: Directory
    DT810408: Directory
    forecast_length: Directory
    gmm: Directory
outputs:
    DT810414:
        type: Directory
        outputSource:
            - ST810414/DT810414
steps:
    SS8107:
        run:
            class: Operation
            inputs: {}
            outputs: {}
        in: {}
        out: []
    ST810414:
        run:
            class: Operation
            inputs:
                DT810406: Directory
                DT810407: Directory
                DT810408: Directory
                forecast_length: Directory
                gmm: Directory
            outputs:
                DT810414: Directory
        in:
            DT810406: DT810406
            DT810407: DT810407
            DT810408: DT810408
            forecast_length: forecast_length
            gmm: gmm
        out:
            - DT810414
