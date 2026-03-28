---
name: imfusion
description: "Performs image fusion using Discrete Wavelet Transformation (DWT). Use when user asks to merge images, restore images, or morph faces."
homepage: https://github.com/iamsh4shank/Imfusion
---

# imfusion

imfusion/SKILL.md
---
name: imfusion
description: |
  Performs image fusion using Discrete Wavelet Transformation (DWT).
  Use when Claude needs to combine information from multiple images of the same scene to create a more detailed image, such as merging MRI and CT scans for enhanced medical diagnostics, or combining photos with different focal points.
---
## Overview
The imfusion tool leverages Discrete Wavelet Transformation (DWT) to combine information from multiple images of the same scene. This process generates a single, more detailed image that incorporates the best features from each input image. It is particularly useful in scenarios like medical imaging, where merging MRI and CT scans can provide a more comprehensive view, or in photography, where combining images with different focus points can result in a sharper overall picture.

## Usage Instructions

The imfusion tool is designed to be run from the command line. The primary executable is `imfusion_main.py`.

### Building and Running the Application

1.  **Install Dependencies**: Ensure you have all the required libraries installed. You can do this by running:
    ```bash
    pip3 install -r requirements.txt
    ```
2.  **Run the Application**: Execute the main script to launch the desktop application:
    ```bash
    python3 imfusion_main.py
    ```

### Application Features

Once the desktop application is running, you can select from various features:

*   **Image Restoration**: Useful for enhancing or correcting faulty images.
*   **Image Mixing**: Combines two input images.
*   **Face Morphing**: Blends two faces to create a morphed image.

For each feature, you will be prompted to insert the image(s) on which the operation will be performed.

### Technical Stack

*   **Programming Language**: Python 3
*   **GUI Framework**: PyQt5
*   **Image Processing Libraries**: Pywt (PyWavelets), Matplotlib, Cv2 (OpenCV), NumPy

## Expert Tips

*   **Input Image Quality**: The quality of the fused image is highly dependent on the quality of the input images. Ensure input images are clear and well-aligned for optimal results.
*   **Understanding DWT**: Discrete Wavelet Transformation decomposes images into different frequency sub-bands, allowing for targeted processing and reconstruction. This is key to preserving and enhancing important features during fusion.
*   **Troubleshooting**: If you encounter issues, first verify that all dependencies listed in `requirements.txt` are correctly installed. Check the console output for specific error messages.



## Subcommands

| Command | Description |
|---------|-------------|
| imfusion | imfusion |
| imfusion | imfusion |
| imfusion-ctg | imfusion-ctg: error: the following arguments are required: --insertions, --reference, --output |
| imfusion-expression | imfusion-expression: error: the following arguments are required: --sample_dir, --reference |
| imfusion-merge | Merges multiple samples into a single imfusion object. |

## Reference documentation
- [Imfusion README](./references/github_com_iamsh4shank_Imfusion.md)