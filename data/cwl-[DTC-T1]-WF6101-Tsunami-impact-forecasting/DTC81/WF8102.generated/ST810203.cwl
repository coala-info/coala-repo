cwlVersion: v1.2
class: Workflow
inputs:
    DT810201: Directory
    DT810202: Directory
    network_inventory: Directory
    velocity_model: Directory
    waveform_miniseed: Directory
outputs:
    DT810203:
        type: Directory
        outputSource:
            - ST810203/DT810203
steps:
    ST810203:
        run:
            class: Operation
            inputs:
                DT810201: Directory
                DT810202: Directory
                network_inventory: Directory
                velocity_model: Directory
                waveform_miniseed: Directory
            outputs:
                DT810203: Directory
        in:
            DT810201: DT810201
            DT810202: DT810202
            network_inventory: network_inventory
            velocity_model: velocity_model
            waveform_miniseed: waveform_miniseed
        out:
            - DT810203
