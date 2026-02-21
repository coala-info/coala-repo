---
name: dextractor
description: UnityLive2DExtractor is a specialized tool designed to recover Live2D Cubism 3 assets from Unity-based game files.
homepage: https://github.com/Perfare/UnityLive2DExtractor
---

# dextractor

## Overview

UnityLive2DExtractor is a specialized tool designed to recover Live2D Cubism 3 assets from Unity-based game files. It processes AssetBundles to reconstruct the original model structure, which typically includes the model geometry, texture atlases, and animation data. This tool is essential when working with Unity games that utilize the Cubism 3 SDK, as it automates the identification and linking of disparate assets within a bundle.

## Command Line Usage

The tool operates primarily by targeting directories containing AssetBundles.

### Basic Extraction
To extract models from a specific directory:
```bash
UnityLive2DExtractor.exe <live2dfolder>
```

### Batch Processing
If you have multiple models, place each model's associated AssetBundles into their own subfolders within a single parent directory. Running the tool on the parent directory will attempt to process all contained assets.

## Best Practices and Workflow

- **Folder-Based Targeting**: Always point the tool at a folder rather than an individual file. The extractor needs to scan the directory to find all related components (textures, motions, physics) that belong to a single model.
- **Output Management**: The tool automatically creates a directory named `Live2DOutput` in the same location as your source folder. Ensure you have write permissions for that directory.
- **Asset Grouping**: For models where the `.moc3` and textures are split across different AssetBundles, ensure all relevant bundles are present in the target folder before execution.

## Expert Tips and Limitations

- **Audio Extraction**: This tool does not support the extraction of audio files (e.g., voice lines or SFX). It focuses strictly on the Live2D model and animation data.
- **Unity Version Support**: The tool is verified for Unity versions up to 2019.3. Assets from significantly newer versions of Unity may cause `System.ArgumentOutOfRangeException` or `OutOfMemoryException`.
- **Duplicate Models**: If an AssetBundle contains multiple Live2D models, the tool may occasionally only export the first one detected. In such cases, manual splitting of the AssetBundle may be required.
- **System Requirements**: Ensure the environment has **.NET Framework 4.7.2** or higher installed, as the executable will fail to launch without it.

## Reference documentation

- [Unity Live2D Cubism 3 Extractor README](./references/github_com_Perfare_UnityLive2DExtractor.md)
- [UnityLive2DExtractor Known Issues](./references/github_com_Perfare_UnityLive2DExtractor_issues.md)