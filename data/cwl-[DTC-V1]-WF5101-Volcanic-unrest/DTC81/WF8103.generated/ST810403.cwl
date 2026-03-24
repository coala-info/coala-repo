cwlVersion: v1.2
class: Workflow
inputs:
    DT810401: Directory
    DT810402: Directory
    network_inventory: Directory
    velocity_model: Directory
    waveform_miniseed: Directory
outputs:
    DT810403:
        type: Directory
        outputSource:
            - ST810403/DT810403
steps:
    SS8101:
        run:
            class: Operation
            inputs: {}
            outputs: {}
        in: {}
        out: []
    SS8104:
        run:
            class: Operation
            inputs: {}
            outputs: {}
        in: {}
        out: []
    ST810403:
        run:
            class: Operation
            inputs:
                DT810401: Directory
                DT810402: Directory
                network_inventory: Directory
                velocity_model: Directory
                waveform_miniseed: Directory
            outputs:
                DT810403: Directory
        in:
            DT810401: DT810401
            DT810402: DT810402
            network_inventory: network_inventory
            velocity_model: velocity_model
            waveform_miniseed: waveform_miniseed
        out:
            - DT810403
