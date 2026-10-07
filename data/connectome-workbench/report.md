# connectome-workbench CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| connectome-workbench_wb_command_file-information | PASS |  |
| connectome-workbench_wb_command_metric-stats | PASS |  |
| connectome-workbench_wb_command_volume-smoothing | PASS |  |
| connectome-workbench_wb_command_volume-stats | PASS |  |
| connectome-workbench_wb_view | Not completed | wb_view is an interactive graphical viewer that cannot run as a batch job. |

## connectome-workbench_wb_view

### Tool Description
Display usage text, set graphics region size, logging level, disable splash screens, load scenes, change window style, load spec files, set window size and position.

### Metadata
- **Docker Image**: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
- **Homepage**: https://www.humanconnectome.org/software/connectome-workbench
- **Package**: https://anaconda.org/channels/bioconda/packages/connectome-workbench/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: wb_view [options] [files]

    [files], if present, can be a single spec file, or multiple data files

Options:
    -help
        display this usage text

    -graphics-size  <X Y>
        Set the size of the graphics region.
        If this option is used you WILL NOT be able
        to change the size of the graphic region. It
        may be useful when image captures of a particular
        size are desired.

    -logging <level>
       Set the logging level.
       Valid Levels are:
           SEVERE
           WARNING
           INFO
           CONFIG
           FINE
           FINER
           FINEST
           ALL
           OFF

    -no-splash
        disable all splash screens

    -scene-load <scene-file-name> <scene-name-or-number>
        load the specified scene file and display the scene 
        in the file that matches by name or number.  Name
        takes precedence over number.  The scene numbers 
        start at one.
        

    -style <style-name>
        change the window style to the specified style
        the following styles are valid on this system:
           Windows
           Fusion
        The selected style is listed on the About wb_view dialog
        available from the File Menu (On Macs: wb_view Menu). 
        Press the "More" button to see the selected style.
        Other styles may be available on other systems.

    -spec-load-all
        load all files in the given spec file, don't show spec file dialog

    -window-size  <X Y>
        Set the size of the browser window

    -window-pos  <X Y>
        Set the position of the browser window
```


## connectome-workbench_wb_command_file-information

### Tool Description
List information about a file's content.

### Metadata
- **Docker Image**: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
- **Homepage**: https://www.humanconnectome.org/software/connectome-workbench
- **Package**: https://anaconda.org/channels/bioconda/packages/connectome-workbench/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/connectome-workbench/overview
- **Total Downloads**: 9.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/Washington-University/workbench
- **Stars**: N/A

### Original Help Text
```text
LIST INFORMATION ABOUT A FILE'S CONTENT
   wb_command -file-information
      <data-file> - data file

      [-no-map-info] - do not show map information for files that support maps

      [-only-step-interval] - suppress normal output, print the interval
         between maps

      [-only-number-of-maps] - suppress normal output, print the number of maps

      [-only-map-names] - suppress normal output, print the names of all maps

      [-only-metadata] - suppress normal output, print file metadata

         [-key] - only print the metadata for one key, with no formatting
            <key> - the metadata key

      [-only-cifti-xml] - suppress normal output, print the cifti xml if the
         file type has it

      List information about the content of a data file.  Only one -only option
      may be specified.  The information listed when no -only option is present
      is dependent upon the type of data file.
```

## connectome-workbench_wb_command_metric-stats

### Tool Description
Spatial statistics on a metric file.

### Metadata
- **Docker Image**: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
- **Homepage**: https://www.humanconnectome.org/software/connectome-workbench
- **Package**: https://anaconda.org/channels/bioconda/packages/connectome-workbench/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/connectome-workbench/overview
- **Total Downloads**: 9.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/Washington-University/workbench
- **Stars**: N/A

### Original Help Text
```text
SPATIAL STATISTICS ON A METRIC FILE
   wb_command -metric-stats
      <metric-in> - the input metric

      [-reduce] - use a reduction operation
         <operation> - the reduction operation

      [-percentile] - give the value at a percentile
         <percent> - the percentile to find

      [-column] - only display output for one column
         <column> - the column number or name

      [-roi] - only consider data inside an roi
         <roi-metric> - the roi, as a metric file

         [-match-maps] - each column of input uses the corresponding column
            from the roi file

      [-show-map-name] - print map index and name before each output

      For each column of the input, a single number is printed, resulting from
      the specified reduction or percentile operation.  Use -column to only
      give output for a single column.  Use -roi to consider only the data
      within a region.  Exactly one of -reduce or -percentile must be
      specified.

      The argument to the -reduce option must be one of the following:

      MAX: the maximum value
      MIN: the minimum value
      INDEXMAX: the 1-based index of the maximum value
      INDEXMIN: the 1-based index of the minimum value
      SUM: add all values
      PRODUCT: multiply all values
      MEAN: the mean of the data
      STDEV: the standard deviation (N denominator)
      SAMPSTDEV: the sample standard deviation (N-1 denominator)
      VARIANCE: the variance of the data
      TSNR: mean divided by sample standard deviation (N-1 denominator)
      COV: sample standard deviation (N-1 denominator) divided by mean
      MEDIAN: the median of the data
      MODE: the mode of the data
      COUNT_NONZERO: the number of nonzero elements in the data
```

## connectome-workbench_wb_command_volume-stats

### Tool Description
Spatial statistics on a volume file.

### Metadata
- **Docker Image**: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
- **Homepage**: https://www.humanconnectome.org/software/connectome-workbench
- **Package**: https://anaconda.org/channels/bioconda/packages/connectome-workbench/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/connectome-workbench/overview
- **Total Downloads**: 9.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/Washington-University/workbench
- **Stars**: N/A

### Original Help Text
```text
SPATIAL STATISTICS ON A VOLUME FILE
   wb_command -volume-stats
      <volume-in> - the input volume

      [-reduce] - use a reduction operation
         <operation> - the reduction operation

      [-percentile] - give the value at a percentile
         <percent> - the percentile to find

      [-subvolume] - only display output for one subvolume
         <subvolume> - the subvolume number or name

      [-roi] - only consider data inside an roi
         <roi-volume> - the roi, as a volume file

         [-match-maps] - each subvolume of input uses the corresponding
            subvolume from the roi file

      [-show-map-name] - print map index and name before each output

      For each subvolume of the input, a single number is printed, resulting
      from the specified reduction or percentile operation.  Use -subvolume to
      only give output for a single subvolume.  Use -roi to consider only the
      data within a region.  Exactly one of -reduce or -percentile must be
      specified.

      The argument to the -reduce option must be one of the following:

      MAX: the maximum value
      MIN: the minimum value
      INDEXMAX: the 1-based index of the maximum value
      INDEXMIN: the 1-based index of the minimum value
      SUM: add all values
      PRODUCT: multiply all values
      MEAN: the mean of the data
      STDEV: the standard deviation (N denominator)
      SAMPSTDEV: the sample standard deviation (N-1 denominator)
      VARIANCE: the variance of the data
      TSNR: mean divided by sample standard deviation (N-1 denominator)
      COV: sample standard deviation (N-1 denominator) divided by mean
      MEDIAN: the median of the data
      MODE: the mode of the data
      COUNT_NONZERO: the number of nonzero elements in the data
```

## connectome-workbench_wb_command_volume-smoothing

### Tool Description
Smooth a volume file.

### Metadata
- **Docker Image**: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
- **Homepage**: https://www.humanconnectome.org/software/connectome-workbench
- **Package**: https://anaconda.org/channels/bioconda/packages/connectome-workbench/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/connectome-workbench/overview
- **Total Downloads**: 9.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/Washington-University/workbench
- **Stars**: N/A

### Original Help Text
```text
SMOOTH A VOLUME FILE
   wb_command -volume-smoothing
      <volume-in> - the volume to smooth
      <kernel> - the gaussian smoothing kernel sigma, in mm
      <volume-out> - output - the output volume

      [-roi] - smooth only from data within an ROI
         <roivol> - the volume to use as an ROI

      [-fix-zeros] - treat zero values as not being data

      [-subvolume] - select a single subvolume to smooth
         <subvol> - the subvolume number or name

      Gaussian smoothing for volumes.  By default, smooths all subvolumes with
      no ROI, if ROI is given, only positive voxels in the ROI volume have
      their values used, and all other voxels are set to zero.  Smoothing a
      non-orthogonal volume will be significantly slower, because the operation
      cannot be separated into 1-dimensional smoothings without distorting the
      kernel shape.

      The -fix-zeros option causes the smoothing to not use an input value if
      it is zero, but still write a smoothed value to the voxel.  This is
      useful for zeros that indicate lack of information, preventing them from
      pulling down the intensity of nearby voxels, while giving the zero an
      extrapolated value.
```

## Metadata
- **Skill**: not generated
