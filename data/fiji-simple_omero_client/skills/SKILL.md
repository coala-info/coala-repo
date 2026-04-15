---
name: fiji-simple_omero_client
description: This Java library provides a simplified API for interacting with OMERO servers within Fiji and ImageJ environments. Use when user asks to connect to an OMERO server, transfer images and metadata between ImageJ and OMERO, or manage ROIs and annotations programmatically.
homepage: https://github.com/GReD-Clermont/simple-omero-client
metadata:
  docker_image: "quay.io/biocontainers/fiji:20250206--h9ee0642_1"
---

# fiji-simple_omero_client

## Overview
The `simple-omero-client` is a Java library designed to wrap the complex OMERO Java Gateway into a more accessible API. It is primarily used within Fiji/ImageJ scripts (Groovy, Jython) or as a Maven dependency in Java projects to streamline the process of putting and getting objects on an OMERO server. It excels at bridging the gap between ImageJ data structures (like `ImagePlus`, `Roi`, and `ResultsTable`) and OMERO's remote data model.

## Connection and Navigation
The `GatewayWrapper` is the primary entry point for all operations.

```java
// Establish connection
Client client = new GatewayWrapper();
client.connect("host", 4064, "username", "password", groupId);

// Navigate hierarchy
List<Project> projects = client.getProjects();
for (Project project : projects) {
    List<Dataset> datasets = project.getDatasets(client);
    for (Dataset dataset : datasets) {
        List<Image> images = dataset.getImages(client);
    }
}
```

## Working with Annotations
The library simplifies adding metadata to Projects, Datasets, or Images.

### Tags and Key-Value Pairs
```java
// Add a Tag
TagAnnotation tag = new TagAnnotationWrapper(client, "Experiment_01", "Description");
dataset.link(client, tag);

// Add Key-Value pairs
dataset.addKeyValuePair(client, "Microscope", "Zeiss LSM 880");
List<String> values = dataset.getValues(client, "Microscope");
```

### Files and Tables
```java
// Attach a file
File file = new File("analysis_results.csv");
dataset.addFile(client, file);

// Create an OMERO Table from an ImageJ ResultsTable
TableBuilder builder = new TableBuilder(client, resultsTable, imageId, ijRois, "ROI");
Table table = builder.createTable();
dataset.addTable(client, table);
```

## Image and ROI Operations
The client provides direct conversion methods for ImageJ's native objects.

### Pixel Access
```java
// Convert OMERO image to ImageJ ImagePlus
ImagePlus imp = image.toImagePlus(client);

// Get raw pixel intensities as a 5D array [t][z][c][y][x]
double[][][][][] pixels = image.getPixels().getAllPixels(client);

// Retrieve a thumbnail
BufferedImage thumbnail = image.getThumbnail(client, 128);
```

### ROI Management
ROIs can be converted between ImageJ and OMERO formats while preserving metadata.

```java
// Convert ImageJ Rois to OMERO ROIs
List<Roi> ijRois = ...; // Your ImageJ ROI list
List<ROI> omeroRois = ROIWrapper.fromImageJ(ijRois);

// Save ROIs to an image on the server
ROI roi = new ROIWrapper();
roi.addShape(new RectangleWrapper(x, y, width, height));
roi.setImage(image);
image.saveROIs(client, roi);

// Convert OMERO ROI back to ImageJ
List<Roi> imagejRois = omeroRois.get(0).toImageJ();
```

## Expert Tips
- **ROI Properties**: When converting ROIs, the library uses properties to track IDs and names. Use `ROI.ijNameProperty("ROI")` and `ROI.ijIDProperty("ROI")` to access the specific ImageJ property keys used for mapping.
- **Table Linking**: For `TableBuilder` to successfully link rows to ROIs, ensure your `ResultsTable` contains a column matching the ROI ID or name, and that the ImageJ ROIs have their "ROI_ID" property set.
- **Memory Management**: When dealing with large datasets, prefer retrieving specific resolution levels if available, rather than loading full 5D pixel arrays into memory.

## Reference documentation
- [simple-omero-client GitHub README](./references/github_com_GReD-Clermont_simple-omero-client.md)
- [fiji-simple_omero_client Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_fiji-simple_omero_client_overview.md)