---
name: bioconductor-flowcatchr
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/flowcatchR.html
---

# bioconductor-flowcatchr

name: bioconductor-flowcatchr
description: Tools for tracking and analyzing flowing blood cells in time-lapse microscopy images. Use this skill when you need to perform bioimage processing tasks including segmentation, particle tracking, and kinematic analysis of cell trajectories (e.g., rolling, flowing, or adherent cells) using the flowcatchR Bioconductor package.

# bioconductor-flowcatchr

## Overview
The `flowcatchR` package provides a comprehensive framework for analyzing in vivo microscopy imaging data. It is specifically designed to handle the challenges of tracking flowing blood cells, such as low signal-to-noise ratios and specimen movement. The package uses a structured S4 class system (`Frames`, `ParticleSet`, `LinkedParticleSet`, and `TrajectorySet`) to guide users from raw image import through segmentation to the calculation of kinematic features like velocity and trajectory linearity.

## Core Workflow

### 1. Image Import and Inspection
Load images into a `Frames` object, which extends `EBImage` functionality.

```r
library(flowcatchR)

# Load from a directory
fullData <- read.Frames(image.files = "/path/to/images/", nframes = 100)

# Inspect frames (display.method can be "browser" or "raster")
inspect.Frames(fullData, nframes = 9, display.method = "raster")

# Extract a specific channel (e.g., red for platelets)
platelets <- channel.Frames(fullData, mode = "red")
```

### 2. Preprocessing and Segmentation
Prepare images for tracking by binarizing and filtering noise.

```r
# High-level wrapper for denoising and thresholding
preprocessed <- preprocess.Frames(platelets,
                                  brush.size = 3, 
                                  at.offset = 0.15, 
                                  at.wwidth = 10, 
                                  at.wheight = 10)

# Identify particles
pts <- particles(platelets, preprocessed)

# Filter particles by area
selected_pts <- select.particles(pts, min.area = 3)
```

### 3. Particle Tracking
Link identified particles across frames to create trajectories.

```r
# L: max displacement in pixels; R: link range (frames to look ahead)
linked_pts <- link.particles(selected_pts, L = 26, R = 3)

# Generate trajectories
trajs <- trajectories(linked_pts)
```

### 4. Kinematic Analysis
Calculate movement statistics for the identified trajectories.

```r
# Calculate all features (requires frequency in ms and scale in micrometers/pixel)
stats <- kinematics(trajs, acquisitionFrequency = 30, scala = 50)

# Access specific features (e.g., Curvilinear Velocity)
velocities <- kinematics(trajs, feature = "curvilinearVelocity")
```

## Visualization and Quality Control
- **add.contours**: Overlay particle or trajectory boundaries on raw images.
- **plot**: View trajectories in a 3D (2D+time) representation.
- **plot2D.TrajectorySet**: View a 2D projection of all paths.
- **snap**: Interactive tool to identify particles and display instantaneous velocity via mouse clicks.
- **export.Frames**: Save processed frames as images or animated GIFs (requires ImageMagick).

## Key S4 Classes
- **Frames**: Multi-dimensional array of images.
- **ParticleSet**: List of data frames containing features of detected objects per frame.
- **LinkedParticleSet**: A ParticleSet with established links between objects.
- **TrajectorySet**: Organized list of trajectories with coordinate sequences and IDs.
- **KinematicsFeaturesSet**: Collection of calculated movement metrics.

## Reference documentation
- [flowcatchR: A framework for tracking and analyzing flowing blood cells in time lapse microscopy images](./references/flowcatchr_vignette.md)