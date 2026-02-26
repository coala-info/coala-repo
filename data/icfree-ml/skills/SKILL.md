---
name: icfree-ml
description: The icfree-ml tool automates experimental design, plate mapping, and liquid handling instructions while using active learning to iteratively optimize biochemical experiments. Use when user asks to generate sampling points, design plate layouts, create robot transfer instructions, or train models to predict new experimental candidates.
homepage: https://github.com/brsynth/icfree-ml
---


# icfree-ml

## Overview
The `icfree-ml` tool provides a specialized suite for the iCFree project to bridge the gap between experimental design and laboratory execution. It automates the generation of sampling points, translates those points into physical plate maps, and generates the necessary instructions for liquid handling robots. Additionally, it features an active learning module ("Learner") that uses experimental results to iteratively improve predictive models and suggest the next most informative experiments.

## Core CLI Workflows

### 1. Integrated Workflow
For a complete run from sampling to plate design, use the main module entry point. This is the most efficient way to chain the initial steps of the process.

```bash
python -m icfree \
  --sampler_input_filename components.csv \
  --sampler_nb_samples 100 \
  --sampler_output_filename samples.csv \
  --plate_designer_input_filename samples.csv \
  --plate_designer_sample_volume 10 \
  --plate_designer_num_replicates 3 \
  --plate_designer_output_folder ./results
```

### 2. Component-Specific Usage

#### Sampler (LHS Generation)
Generates discrete sampling points for biochemical components.
- **Best Practice**: Use the `--step` argument to match the precision of your liquid handling system (e.g., 2.5 for Echo acoustic dispensers).
- **Command**: `python icfree/sampler.py <input_csv> <output_csv> <num_samples> --step 2.5 --seed 42`

#### Plate Designer
Converts samples into source and destination plate layouts.
- **Key Tip**: Always specify `--well_capacity` and `--default_dead_volume` to prevent overfilling or aspiration errors.
- **Command**: `python icfree/plate_designer.py samples.csv 10 --num_replicates 3 --start_well_src_plt A1 --output_folder ./plates`

#### Instructor
Generates the transfer instructions between plates.
- **Expert Tip**: Use `--dispense_order` to control the sequence of component addition, which is critical for sensitive biochemical reactions.
- **Command**: `python icfree/instructor.py source.csv dest.csv instructions.csv --max_transfer_volume 1000 --dispense_order "Buffer,DNA,Extract"`

#### Learner (Active Learning)
Trains models on experimental data and predicts new candidates.
- **Validation**: Use the `--test` flag and `--nb_rep` to assess model performance via cross-validation before committing to new experimental runs.
- **Data Handling**: Use `--flatten` if you want to treat every replicate as an independent data point rather than using the average.
- **Command**: `python -m icfree.learner ./data_folder params.csv ./output --name_list "Yield1,Yield2" --nb_new_data 50 --plot`

## Expert Tips & Best Practices
- **Reproducibility**: Always provide a `--seed` value in the Sampler and Learner modules to ensure that stochastic processes (like LHS or data splitting) can be replicated.
- **Input Formatting**: Ensure your component input CSVs define clear maximum values for the Sampler to bound the search space effectively.
- **Active Learning Loops**: When using the Learner, the `nb_new_data_predict` (candidates to screen) should be significantly larger than `nb_new_data` (actual points to test) to allow the clustering algorithm to select a diverse and informative subset.
- **Dead Volume**: In the Plate Designer, account for the "dead volume" (liquid that cannot be aspirated) for every component to ensure the generated instructions don't attempt to draw from empty wells.

## Reference documentation
- [GitHub Repository Overview](./references/github_com_brsynth_icfree-ml.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_icfree-ml_overview.md)