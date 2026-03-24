cwlVersion: v1.2
class: Workflow
inputs:
    DT810101: Directory
    DT810102: Directory
    network_inventory: Directory
    velocity_model: Directory
    waveform_miniseed: Directory
outputs:
    DT810103:
        type: Directory
        outputSource:
            - ST810103/DT810103
steps:
    ST810103:
        run:
            class: Operation
            inputs:
                DT810101: Directory
                DT810102: Directory
                network_inventory: Directory
                velocity_model: Directory
                waveform_miniseed: Directory
            outputs:
                DT810103: Directory
        in:
            DT810101: DT810101
            DT810102: DT810102
            network_inventory: network_inventory
            velocity_model: velocity_model
            waveform_miniseed: waveform_miniseed
        out:
            - DT810103
