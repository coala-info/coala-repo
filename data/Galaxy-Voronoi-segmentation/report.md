# Voronoi segmentation CWL Workflow Report

### Metadata
- **Docker Image**: N/A
- **Homepage**: https://training.galaxyproject.org
- **Package**: https://workflowhub.eu/workflows/1522
- **Validation**: N/A

- **RO-Crate download**: https://workflowhub.eu/workflows/1522/ro_crate?version=1
- **Conda**: N/A
- **Total Downloads**: 278
- **Last updated**: 2025-06-02
- **GitHub**: N/A
- **Stars**: N/A
- **Version**: 1
- **License**: MIT
- **Workflow type**: Galaxy
- **Main workflow (WorkflowHub):** `voronoi-segmentation.ga` (Main Workflow)
- **Project**: Galaxy Training Network
- **Views**: 2252
- **Discussion / source**: https://matrix.to/#/%23galaxyproject_admin:gitter.im

## Description

Generic workflow to perform Voronoi segmentation.
Input requirements: 
* Image: 
-- Preferably lighter objects on a darker background for the mask to work well.
-- Format: .tiff, stored in planar RGB format, not interleaved (http://avitevet.com/uncategorized/when-to-use-it-interleaved-vs-planar-image-data-storage/). 
* Seeds: 
-- White seeds on a black background
-- Format: .tiff

## Associated Tutorial

This workflows is part of the tutorial [Voronoi segmentation](https://training.galaxyproject.org/training-material/topics/imaging/tutorials/voronoi-segmentation/tutorial.html), available in the [GTN](https://training.galaxyproject.org)

## Features

* Includes [Galaxy Workflow Tests](https://training.galaxyproject.org/training-material/faqs/gtn/workflow_run_test.html)
* Includes a [Galaxy Workflow Report](https://training.galaxyproject.org/training-material/faqs/galaxy/workflows_report_view.html)
* Uses [Galaxy Workflow Comments](https://training.galaxyproject.org/training-material/faqs/galaxy/workflows_comments.html)

## Thanks to...

**Workflow Author(s)**: Even Moa Myklebust, Riccardo Massei

**Tutorial Author(s)**: [Even Moa Myklebust](https://training.galaxyproject.org/training-material/hall-of-fame/evenmm/), [Riccardo Massei](https://training.galaxyproject.org/training-material/hall-of-fame/rmassei/), [Leonid Kostrykin](https://training.galaxyproject.org/training-material/hall-of-fame/kostrykin/), [Anne Fouilloux](https://training.galaxyproject.org/training-material/hall-of-fame/annefou/)

[![gtn star logo followed by the word workflows](https://training.galaxyproject.org/training-material/assets/branding/gtn-workflows.png)](https://training.galaxyproject.org/training-material/)
