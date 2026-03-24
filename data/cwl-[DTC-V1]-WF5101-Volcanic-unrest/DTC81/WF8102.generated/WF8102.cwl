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
    DT810201:
        type: Directory
        outputSource:
            - ST810201/DT810201
    DT810202:
        type: Directory
        outputSource:
            - ST810202/DT810202
    DT810203:
        type: Directory
        outputSource:
            - ST810203/DT810203
    DT810204:
        type: Directory
        outputSource:
            - ST810204/DT810204
requirements:
    SubworkflowFeatureRequirement: {}
steps:
    ST810201:
        run: ST810201.cwl
        in:
            P_phase_threshold: P_phase_threshold
            S_phase_threshold: S_phase_threshold
            blinding: blinding
            model: model
            model_weights: model_weights
            waveform_miniseed: waveform_miniseed
        out:
            - DT810201
    ST810202:
        run: ST810202.cwl
        in:
            DT810201: ST810201/DT810201
            depth_max: depth_max
            depth_min: depth_min
            lat_max: lat_max
            lat_min: lat_min
            lon_max: lon_max
            lon_min: lon_min
            network_inventory: network_inventory
            velocity_model: velocity_model
        out:
            - DT810202
    ST810203:
        run: ST810203.cwl
        in:
            DT810201: ST810201/DT810201
            DT810202: ST810202/DT810202
            network_inventory: network_inventory
            velocity_model: velocity_model
            waveform_miniseed: waveform_miniseed
        out:
            - DT810203
    ST810204:
        run: ST810204.cwl
        in:
            DT810201: ST810201/DT810201
            DT810203: ST810203/DT810203
            frequency_range: frequency_range
            network_inventory: network_inventory
            source_rock_density: source_rock_density
            source_wave_velocity: source_wave_velocity
            time_window_length: time_window_length
            velocity_model: velocity_model
            waveform_miniseed: waveform_miniseed
        out:
            - DT810204
    ST810205:
        run: ST810205.cwl
        in: {}
        out: []
    ST810206:
        run: ST810206.cwl
        in: {}
        out: []
    ST810207:
        run: ST810207.cwl
        in: {}
        out: []
    ST810208:
        run: ST810208.cwl
        in: {}
        out: []
    ST810209:
        run: ST810209.cwl
        in: {}
        out: []
    ST810210:
        run: ST810210.cwl
        in: {}
        out: []
    ST810211:
        run: ST810211.cwl
        in: {}
        out: []
