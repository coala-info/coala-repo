cwlVersion: v1.2
class: Workflow
inputs:
    P_phase_threshold:
        type: Directory
    S_phase_threshold:
        type: Directory
    blinding:
        type: Directory
    depth_max:
        type: Directory
    depth_min:
        type: Directory
    frequency_range:
        type: Directory
    lat_max:
        type: Directory
    lat_min:
        type: Directory
    lon_max:
        type: Directory
    lon_min:
        type: Directory
    model:
        type: Directory
    model_weights:
        type: Directory
    network_inventory:
        type: Directory
    source_rock_density:
        type: Directory
    source_wave_velocity:
        type: Directory
    time_window_length:
        type: Directory
    velocity_model:
        type: Directory
    waveform_miniseed:
        type: Directory
outputs:
    DT810401:
        type: Directory
        outputSource:
            - ST810401/DT810401
    DT810402:
        type: Directory
        outputSource:
            - ST810402/DT810402
    DT810403:
        type: Directory
        outputSource:
            - ST810403/DT810403
    DT810404:
        type: Directory
        outputSource:
            - ST810404/DT810404
requirements:
    SubworkflowFeatureRequirement: {}
steps:
    ST810305:
        run: ST810305.cwl
        in: {}
        out: []
    ST810401:
        run: ST810401.cwl
        in:
            P_phase_threshold: P_phase_threshold
            S_phase_threshold: S_phase_threshold
            blinding: blinding
            model: model
            model_weights: model_weights
            waveform_miniseed: waveform_miniseed
        out:
            - DT810401
    ST810402:
        run: ST810402.cwl
        in:
            DT810401: ST810401/DT810401
            depth_max: depth_max
            depth_min: depth_min
            lat_max: lat_max
            lat_min: lat_min
            lon_max: lon_max
            lon_min: lon_min
            network_inventory: network_inventory
            velocity_model: velocity_model
        out:
            - DT810402
    ST810403:
        run: ST810403.cwl
        in:
            DT810401: ST810401/DT810401
            DT810402: ST810402/DT810402
            network_inventory: network_inventory
            velocity_model: velocity_model
            waveform_miniseed: waveform_miniseed
        out:
            - DT810403
    ST810404:
        run: ST810404.cwl
        in:
            DT810401: ST810401/DT810401
            DT810403: ST810403/DT810403
            frequency_range: frequency_range
            network_inventory: network_inventory
            source_rock_density: source_rock_density
            source_wave_velocity: source_wave_velocity
            time_window_length: time_window_length
            velocity_model: velocity_model
            waveform_miniseed: waveform_miniseed
        out:
            - DT810404
