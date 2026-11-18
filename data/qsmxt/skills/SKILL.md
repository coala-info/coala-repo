---
name: qsmxt
description: QSMxT is an end-to-end Quantitative Susceptibility Mapping (QSM) pipeline for gradient-echo MRI. Use when user asks to reconstruct a susceptibility (QSM, chi) map from phase and magnitude images, unwrap MRI phase, estimate a B0 field map from multi-echo phase, remove the background field, run a dipole inversion, reduce streaking around strong sources, or compute SWI, R2* or T2* maps.
homepage: https://github.com/QSMxT/QSMxT
metadata:
  docker_image: "vnmd/qsmxt_12.0.0:20261115"
---

# qsmxt

## Overview

QSMxT turns multi-echo (or single-echo) gradient-echo phase and magnitude images into a susceptibility map in ppm. One command runs the whole chain: brain mask, phase offset removal, phase unwrapping, echo combination into a field map, background field removal, dipole inversion and referencing. It is one self-contained binary (`qsmxt`, on `PATH` in the image) and needs no network for the default pipeline.

Use it before you write a QSM chain by hand. Each of the five steps has a known failure mode (see the last section), and a hand-written chain usually gets at least one wrong without any error message.

## Input

A BIDS folder: `<bids>/sub-<id>/[ses-<id>/]anat/` with

- `sub-<id>[_echo-<n>]_part-phase_MEGRE.nii` and `..._part-mag_MEGRE.nii`, one pair per echo;
- a JSON sidecar per image with `EchoTime` (seconds) and `MagneticFieldStrength` (tesla). `B0_dir` is read when present.

Files that are not named this way must be copied or linked into this layout first. Check what the tool sees before you run it:

```bash
qsmxt validate <bids>
```

It lists each run with its echoes, echo times, matrix, voxel size, field strength and B0 direction. Fix the names or sidecars until these match the acquisition.

## Run

```bash
qsmxt run <bids> <out> --n-procs 8
```

- `<bids>` can be read-only. Everything is written under `<out>/derivatives/qsmxt/`.
- A 1 mm whole-head 4-echo volume takes under one minute on 8 threads and fits in 16 GB of memory.
- `--dry` prints the plan and the methods text and writes nothing.
- From a script: `subprocess.run(["qsmxt", "run", bids, out], check=True)`. `qsmxt` exists only in this tool's image, so pass `docker_image: vnmd/qsmxt_12.0.0:20261115` to the script call that runs it. The first call pulls the image (about a minute and a half).
- Run times for one 1 mm whole-head 4-echo volume on 8 threads:

| `--qsm-algorithm` | Time |
|---|---|
| `ilsqr` (default), `star`, `tkd`, `tv`, `ndi` | under 2 min |
| `medi` | about 6 min |
| `tgv` | about 11 min |
| `fansi-tgv` | about 19 min |
| `heidi` | about 31 min |

`--two-pass` roughly doubles background removal and inversion. `--bf-algorithm pdf` or `resharp` adds 2 to 3 minutes.

## Output

| File under `<out>/derivatives/qsmxt/` | Content |
|---|---|
| `sub-<id>/anat/sub-<id>_Chimap.nii` | susceptibility in ppm, float32, on the acquired grid (same matrix and voxel size as the input); nonzero exactly on `_desc-qsm_mask.nii`, with mean 0 there |
| `sub-<id>/anat/sub-<id>_mask.nii` | the brain mask background removal starts from |
| `sub-<id>/anat/sub-<id>_desc-qsm_mask.nii` | the reconstruction mask: the brain mask less the rim that background removal erodes. The map is defined here and is 0 elsewhere |
| `methods.md` | the steps that ran, with citations |
| `pipeline_config.toml` | every setting; pass it back with `--config` to repeat or change a run |
| `workflow/sub-<id>/unwrap/`, `bgremove/`, `invert/` | field map in ppm, local field, masks, unreferenced map |

If a task names its own output path, copy `*_Chimap.nii` there unchanged. Do not resample or rescale it: it is already in ppm on the input grid.

## What the default pipeline does

Mask from an Otsu threshold of the ROMEO phase-quality map (dilated, hole-filled, eroded); phase offset removal with MCPC-3D-S; ROMEO unwrapping; field map as a phase-SNR weighted average over echoes; V-SHARP background removal; iLSQR dipole inversion; zero pinned to the mean over the reconstruction mask.

## Checks after a run

1. Read the `Recommendations` lines at the end of the log and `methods.md`.
2. Load `*_mask.nii` over the magnitude. The default mask follows phase quality, so it can include reliable tissue outside the brain. If only brain is wanted, use `--mask-preset bet`, or mask the map afterwards.
3. Load the field map in `workflow/.../unwrap/`: it must be smooth, with no 2π steps.
4. Brain tissue lies within about ±0.2 ppm; veins, iron-rich nuclei and calcifications go beyond. A map that is all near zero, or far larger everywhere, points to a wrong echo time or field strength in the sidecars.
5. The zero of a QSM map is arbitrary. Compare two maps only after removing each one's mean over the same mask.

## Options that matter

- `--two-pass`: for strong sources (air cavities, haemorrhage, calcification, implants) whose streaks spread into nearby tissue. A second reconstruction leaves the unreliable voxels out. It is not free: it lowers streaking next to the source and can make values elsewhere worse (in a test with one calcification, deep grey matter). Run the default first; turn it on only when streaks visibly cross tissue, and compare both maps over the whole brain, not only around the source.
- `--mask-preset bet | bet-and-phase | robust-threshold`, or `--mask <input>,<generator>,<refinement>,...` (for example `magnitude,bet:0.5,erode:2`). `--two-pass-mask` takes the same format.
  - `<input>`: `magnitude`, `magnitude-first`, `magnitude-last` or `phase-quality`.
  - `<generator>`: `threshold:otsu`, `threshold:fixed:<value>`, `threshold:percentile:<0-100>`, `threshold:sti-gui`, or `bet:<fraction>`. A bare number such as `threshold:2.0` is an error.
  - `<refinement>`: `erode:<n>`, `dilate:<n>`, `close:<n>`, `fill-holes:0`, `majority`.
  - Check a mask spec with `--dry` before a full run: it prints how each section was read.
- `--qsm-algorithm ilsqr | rts | tv | tgv | tkd | medi | ...`, `--bf-algorithm vsharp | pdf | lbv | ...`, `--unwrapping-algorithm romeo | laplacian`.
- `--qsm-reference mean | none | <region>`.
- `--pipeline medi-toolbox | sti-suite-ilsqr | qsmart | ...` starts from another toolbox's settings.

Single steps are also commands: `qsmxt mask`, `unwrap`, `fieldmap`, `bgremove`, `invert`, `swi`, `r2star`, `t2star`. Each has `--help`.

## Choosing between runs

Keep the default map unless another run is better on a check that covers the whole brain. A measure taken only around one strong source (streaks next to a calcification, say) rewards the run that smooths most there, and that run can be worse elsewhere in the brain. When you compare runs, put the default first and give each run's numbers over the whole reconstruction mask beside the local ones. A run that changes the reconstruction mask (a different `--vsharp-min-radius`, `--bf-algorithm` or mask) changes which voxels are compared: compare on the voxels both maps share.

## If you write the chain yourself

These are the parts that fail silently:

- **Mask.** Background removal and inversion need a brain mask. A whole-head mask leaves skull, air and scalp in the problem and ruins the map.
- **Phase offsets.** Multi-echo phase is `offset + 2π·f·TE`. Dividing one echo's phase by its TE, or fitting a line through the origin, puts the offset into the field. Remove it first (MCPC-3D-S), or fit an intercept.
- **Unwrapping.** Unwrap in space with a path-based method (ROMEO) and keep echoes consistent in time. A Laplacian per echo loses accuracy near strong sources.
- **One field from all echoes.** Combine the echoes with weights that follow phase SNR. Averaging per-echo susceptibility maps is worse.
- **Background removal.** SHARP-type filters erode the mask rim. Know which voxels were lost; do not report them as zero-susceptibility tissue.
- **Units.** `ppm = field_Hz / (42.577 × B0_tesla)`.
