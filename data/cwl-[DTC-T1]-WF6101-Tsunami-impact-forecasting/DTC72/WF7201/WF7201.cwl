#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: Workflow

# Define global inputs.
inputs:
  WAVEFORMS:
    doc: "Seismic waveform data (EPOS/EIDA) or Alparray data as in DT7205"
    type: File 
  # optional inputs
  # DT7205:
  #   doc: "Alparray dataset"
  #   type: File

# Define global outputs
outputs:
  HIGH_RESOLUTION_CATALOG:
    doc: "Final high-resolution seismic event catalog"
    type: File
    outputSource: ST720105/HIGH_RES_CATALOG

# Define workflow steps.
# the whole workflow is using QuakeFlow: SS7205
steps:
  ST720101:
    doc: "Waveform ingestion from EPOS/EIDA"
    in:
      WAVEFORMS: WAVEFORMS
    run:
      class: Operation
      inputs:
        WAVEFORMS: File
      outputs:
        RAW_DATA: File
    out:
      - RAW_DATA

  ST720102:
    doc: "AI-based picking of seismic phases"
    in:
      RAW_DATA: ST720101/RAW_DATA
    run:
      class: Operation
      inputs:
        RAW_DATA: File
      outputs:
        PICKS: File
    out:
      - PICKS

  ST720103:
    doc: "Association of picks into seismic events"
    in:
      PICKS: ST720102/PICKS
    run:
      class: Operation
      inputs:
        PICKS: File
      outputs:
        ASSOCIATED_EVENTS: File
    out:
      - ASSOCIATED_EVENTS

  ST720104:
    doc: "Locate events, compute magnitudes and focal mechanisms"
    in:
      ASSOCIATED_EVENTS: ST720103/ASSOCIATED_EVENTS
    run:
      class: Operation
      inputs:
        ASSOCIATED_EVENTS: File
      outputs:
        LOC_MAG_MECH: File
    out:
      - LOC_MAG_MECH

  ST720105:
    doc: "Generate high-resolution event catalog"
    in:
      LOC_MAG_MECH: ST720104/LOC_MAG_MECH
    run:
      class: Operation
      inputs:
        LOC_MAG_MECH: File
      outputs:
        HIGH_RES_CATALOG: File
    out:
      - HIGH_RES_CATALOG