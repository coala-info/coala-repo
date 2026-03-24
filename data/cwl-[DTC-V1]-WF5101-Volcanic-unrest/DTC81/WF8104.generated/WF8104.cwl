cwlVersion: v1.2
class: Workflow
inputs:
    Mc:
        type: Directory
    Mmax:
        type: Directory
    P_phase_threshold:
        type: Directory
    S_phase_threshold:
        type: Directory
    acceleration_miniseed:
        type: Directory
    attribute_range:
        type: Directory
    blinding:
        type: Directory
    catalog:
        type: Directory
    damping_factor:
        type: Directory
    depth_max:
        type: Directory
    depth_min:
        type: Directory
    forecast_length:
        type: Directory
    frequency_range:
        type: Directory
    gmm:
        type: Directory
    grid_cell_size:
        type: Directory
    ground_motion_params:
        type: Directory
    injection_model:
        type: Directory
    injection_rate:
        type: Directory
    injection_rate_threshold:
        type: Directory
    inter_event_time_threshold:
        type: Directory
    kde_method:
        type: Directory
    lat_max:
        type: Directory
    lat_min:
        type: Directory
    lon_max:
        type: Directory
    lon_min:
        type: Directory
    map_selection:
        type: Directory
    model:
        type: Directory
    model_weights:
        type: Directory
    network_inventory:
        type: Directory
    output_uncertainty:
        type: Directory
    path_char:
        type: Directory
    site_char:
        type: Directory
    source_char_param:
        type: Directory
    source_rock_density:
        type: Directory
    source_wave_velocity:
        type: Directory
    time_window_duration:
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
    DT810405:
        type: Directory
        outputSource:
            - ST810405/DT810405
    DT810406:
        type: Directory
        outputSource:
            - ST810406/DT810406
    DT810407:
        type: Directory
        outputSource:
            - ST810407/DT810407
    DT810408:
        type: Directory
        outputSource:
            - ST810408/DT810408
    DT810409:
        type: Directory
        outputSource:
            - ST810409/DT810409
    DT810410:
        type: Directory
        outputSource:
            - ST810410/DT810410
    DT810411:
        type: Directory
        outputSource:
            - ST810411/DT810411
    DT810412:
        type: Directory
        outputSource:
            - ST810412/DT810412
    DT810413:
        type: Directory
        outputSource:
            - ST810413/DT810413
    DT810414:
        type: Directory
        outputSource:
            - ST810414/DT810414
    DT810415:
        type: Directory
        outputSource:
            - ST810415/DT810415
requirements:
    SubworkflowFeatureRequirement: {}
steps:
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
    ST810405:
        run: ST810405.cwl
        in:
            attribute_range: attribute_range
            catalog: catalog
            map_selection: map_selection
        out:
            - DT810405
    ST810406:
        run: ST810406.cwl
        in:
            DT810405: ST810405/DT810405
            grid_cell_size: grid_cell_size
        out:
            - DT810406
    ST810407:
        run: ST810407.cwl
        in:
            DT810405: ST810405/DT810405
            time_window_duration: time_window_duration
        out:
            - DT810407
    ST810408:
        run: ST810408.cwl
        in:
            DT810405: ST810405/DT810405
            Mc: Mc
            Mmax: Mmax
            kde_method: kde_method
        out:
            - DT810408
    ST810409:
        run: ST810409.cwl
        in:
            DT810405: ST810405/DT810405
            injection_rate: injection_rate
        out:
            - DT810409
    ST810410:
        run: ST810410.cwl
        in:
            DT810409: ST810409/DT810409
            injection_model: injection_model
            injection_rate_threshold: injection_rate_threshold
            inter_event_time_threshold: inter_event_time_threshold
            output_uncertainty: output_uncertainty
        out:
            - DT810410
    ST810411:
        run: ST810411.cwl
        in:
            acceleration_miniseed: acceleration_miniseed
            damping_factor: damping_factor
        out:
            - DT810411
    ST810412:
        run: ST810412.cwl
        in:
            ground_motion_params: ground_motion_params
            path_char: path_char
            site_char: site_char
            source_char_param: source_char_param
        out:
            - DT810412
    ST810413:
        run: ST810413.cwl
        in:
            DT810406: ST810406/DT810406
            DT810407: ST810407/DT810407
            DT810408: ST810408/DT810408
            forecast_length: forecast_length
            gmm: gmm
        out:
            - DT810413
    ST810414:
        run: ST810414.cwl
        in:
            DT810406: ST810406/DT810406
            DT810407: ST810407/DT810407
            DT810408: ST810408/DT810408
            forecast_length: forecast_length
            gmm: gmm
        out:
            - DT810414
    ST810415:
        run: ST810415.cwl
        in:
            DT810413: ST810413/DT810413
            DT810414: ST810414/DT810414
        out:
            - DT810415
