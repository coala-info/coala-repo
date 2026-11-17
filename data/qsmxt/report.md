# qsmxt CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| qsmxt_run | PASS | simulated 4-echo 7 T whole-head data (164x205x205, 1 mm, TE 4/12/20/28 ms) in BIDS layout; default pipeline; writes `derivatives/qsmxt/sub-1/anat/sub-1_Chimap.nii` in ppm on the acquired grid in about 45 s |
| qsmxt_validate | PASS | same dataset; reports 1 run, 4 echoes, echo times, 7.0 T, B0 direction |

## qsmxt_run

### Tool Description
Run the full QSM pipeline on a BIDS dataset

### Metadata
- **Docker Image**: vnmd/qsmxt_12.0.0:20261115
- **Homepage**: https://github.com/QSMxT/QSMxT
- **Documentation**: https://qsmxt.github.io/QSMxT/
- **Version**: QSMxT v12.0.0, QSM.rs (qsm-core) v0.42.0

### Notes
- The image is from the project's own container line (`vnmd/qsmxt_<version>`); it is not a BioContainers image.
- `qsmxt run --help` lists 427 options; the CWL exposes the ones that choose the mask, the algorithms, the reference and the run control. Any other setting goes through `config` (a TOML file such as the `pipeline_config.toml` a run writes).
- v10, v11 and v12 each changed default results. The image tag is pinned for that reason.

## qsmxt_validate

### Tool Description
Validate BIDS dataset structure for QSM processing

### Metadata
- **Docker Image**: vnmd/qsmxt_12.0.0:20261115
- **Homepage**: https://github.com/QSMxT/QSMxT
