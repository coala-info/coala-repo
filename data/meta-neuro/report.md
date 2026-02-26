# meta-neuro CWL Generation Report

## meta-neuro_density_map

### Tool Description
Convert streamlines of white matter bundle into a density map and binary mask.

### Metadata
- **Docker Image**: quay.io/biocontainers/meta-neuro:2.0.1--py313h47f2c4e_0
- **Homepage**: https://github.com/bagari/meta
- **Package**: https://anaconda.org/channels/bioconda/packages/meta-neuro/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/meta-neuro/overview
- **Total Downloads**: 6.7K
- **Last updated**: 2025-11-07
- **GitHub**: https://github.com/bagari/meta
- **Stars**: N/A
### Original Help Text
```text
usage: density_map [-h] --tractogram TRACTOGRAM --reference REFERENCE
                   --output OUTPUT

Convert streamlines of white matter bundle into a density map and binary mask.

options:
  -h, --help            show this help message and exit
  --tractogram TRACTOGRAM
                        Path to the bundle file containing streamlines
  --reference REFERENCE
                        Path to the reference image
  --output OUTPUT       Path to the output binary mask file
```


## meta-neuro_vtklevelset

### Tool Description
Generates a VTK mesh from a level set implicit surface defined by an input image.

### Metadata
- **Docker Image**: quay.io/biocontainers/meta-neuro:2.0.1--py313h47f2c4e_0
- **Homepage**: https://github.com/bagari/meta
- **Package**: https://anaconda.org/channels/bioconda/packages/meta-neuro/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: vtklevelset [options] input.img output.vtk threshold
Options: 
  -c clipimage.img   : clip output (keep part where clipimage > 0
  -v                 : export mesh in voxel coordinates (not physical)
  -k                 : apply clean filter to the mesh
  -d                 : perform Delaunay edge flipping
  -2                 : use 2D algorithm
  -pl                : preserve labels
  -r <factor|num>    : reduce the size of the final mesh via quadric edge collapse
                       algorithm from MeshLab by a factor (e.g., 0.1) or to given 
                       number of vertices 
  -f                 : make sure that normal vectors are facing outward
```


## meta-neuro_cmrep_vskel

### Tool Description
Skeletonize a boundary mesh

### Metadata
- **Docker Image**: quay.io/biocontainers/meta-neuro:2.0.1--py313h47f2c4e_0
- **Homepage**: https://github.com/bagari/meta
- **Package**: https://anaconda.org/channels/bioconda/packages/meta-neuro/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: 
    cmrep_vskel [options] boundary.vtk output_skeleton.vtk
Parameters: 
    boundary.vtk         Boundary mesh to skeletonize
    output.vtk           Where to output the skeleton
General Options:         
    -Q PATH              Path to the qvoronoi executable
    -z <level> <mode>    Subdivide input mesh prior to skeletonization
                         mode is either 'loop' or 'linear'
Pruning Options:
    -e N                 Minimal number of mesh edges separating two generator
                         points of a VD face for it to be considered (try 2, 3)
    -p X.XX              Prune the mesh using factor X.XX (try 2.0). The 
                         pruning algorithm deletes faces in the VD for 
                         which the ratio of the geodesic distance between 
                         the generating points and the euclidean distance 
                         between these points is less than X.XX
    -c N                 Take at most N connected components of the skeleton
    -g                   Compute full geodesic information. This is only useful for
                         debugging the pruning code.
    -t                   Tolerance for the inside/outside search algorithm (default 1e-6)
                         Use lower values if holes appear in the skeleton. Set to zero to
                         disable pruning of outside vertices
Output Options: 
    -s mesh.vtk          Load a skeleton from mesh.vtk and compare to the output skeleton
    -R N xyz.mat d.mat   Generate N random samples from the skeleton and save their coordiantes
                         to xyz.mat and geodesic distances to d.mat
    -T name.vtk          Generate thickness map on the boundary. The thickness is the distance
                         from each boundary point to the closest pruned skeleton point
    -I in.nii thickness.nii depth.nii 
                         Generate thickness map in an image. Input is a binary image. 
                         Output 1 is a thickness image; Output 2 is a depth map
    -q n_bins            Postprocess skeleton with VTK's quadric clustering filter
                         The effect is to reduce the number of vertices in the skeleton
                         Parameter n_bins is the number of bins in each dimension
                         A good value for n_bins is 20-50
    -d mesh.vtk          Generate a Delaunay tetrahedralization of the input point set, with
                         the pruned parts of the skeleton excluded. Use with tetfill to generate
                         a thickness map in image space (different from -I output, this is 
                         distance from the skeleton vertices to the boundary generator points
Other Options: 
    -S image array mode  Sample from image 'image' and store as array 'array'
                         mode is one of 'mean', 'max'. Must be used together with -T command
```


## meta-neuro_meta

### Tool Description
Medial Tractography Analysis (MeTA) for White Matter Bundle Parcellation

### Metadata
- **Docker Image**: quay.io/biocontainers/meta-neuro:2.0.1--py313h47f2c4e_0
- **Homepage**: https://github.com/bagari/meta
- **Package**: https://anaconda.org/channels/bioconda/packages/meta-neuro/overview
- **Validation**: PASS

### Original Help Text
```text
2026-02-26 02:10:34,865 [INFO] Note: NumExpr detected 20 cores but "NUMEXPR_MAX_THREADS" not set, so enforcing safe limit of 16.
2026-02-26 02:10:34,865 [INFO] NumExpr defaulting to 16 threads.
usage: meta [-h] [--subject SUBJECT] [--bundle BUNDLE]
            --medial_surface MEDIAL_SURFACE --volume VOLUME --sbundle SBUNDLE
            --mbundle MBUNDLE [--transform TRANSFORM] [--inverse] --mask MASK
            [--num_segments NUM_SEGMENTS] --output OUTPUT [--percent PERCENT]
            [--fill FILL] [--size SIZE] [--extract EXTRACT]

Medial Tractography Analysis (MeTA) for White Matter Bundle Parcellation

options:
  -h, --help            show this help message and exit
  --subject SUBJECT     Subject IDs
  --bundle BUNDLE       Name of white matter bundle
  --medial_surface MEDIAL_SURFACE
                        Medial surface of white matter bundle in vtk format
  --volume VOLUME       Volume of white matter bundle in vtk format (mesh)
  --sbundle SBUNDLE     Streamlines of subject bundle
  --mbundle MBUNDLE     Streamlines of model bundle
  --transform TRANSFORM
                        Transformation matrix: MNI → subject space
  --inverse             Inverse transformation matrix if direction subject →
                        MNI
  --mask MASK           Mask of white matter bundle
  --num_segments NUM_SEGMENTS
                        The required number of segments along the bundle
                        length
  --output OUTPUT       Output directory
  --percent PERCENT     Percent of distance to keep from each side of Medial
                        surface
  --fill FILL           Fill holes in bundle mesh
  --size SIZE           Maximum hole size to fill
  --extract EXTRACT     Extract largest connected set in bundle mesh
```


## meta-neuro_volumetric_profile

### Tool Description
Compute volumetric profile (average mean and voxel-wise) of a white matter bundle.

### Metadata
- **Docker Image**: quay.io/biocontainers/meta-neuro:2.0.1--py313h47f2c4e_0
- **Homepage**: https://github.com/bagari/meta
- **Package**: https://anaconda.org/channels/bioconda/packages/meta-neuro/overview
- **Validation**: PASS

### Original Help Text
```text
usage: volumetric_profile [-h] --subject SUBJECT --bundle BUNDLE --mask MASK
                          --map MAP --output OUTPUT [--voxelwise]

Compute volumetric profile (average mean and voxel-wise) of a white matter
bundle.

options:
  -h, --help         show this help message and exit
  --subject SUBJECT  Subject ID
  --bundle BUNDLE    White matter bundle name
  --mask MASK        Path to white matter bundle mask
  --map MAP          Brain microstructure map, e.g. FA, MD, etc.
  --output OUTPUT    Output directory to save extracted features
  --voxelwise        Save voxel-wise in HDF5 format
```


## meta-neuro_streamlines_profile

### Tool Description
Compute streamlines profile (average mean and point-wise) of a white matter bundle.

### Metadata
- **Docker Image**: quay.io/biocontainers/meta-neuro:2.0.1--py313h47f2c4e_0
- **Homepage**: https://github.com/bagari/meta
- **Package**: https://anaconda.org/channels/bioconda/packages/meta-neuro/overview
- **Validation**: PASS

### Original Help Text
```text
usage: streamlines_profile [-h] --subject SUBJECT --bundle BUNDLE
                           --tractogram TRACTOGRAM --mask MASK --map MAP
                           --output OUTPUT [--pointwise]

Compute streamlines profile (average mean and point-wise) of a white matter
bundle.

options:
  -h, --help            show this help message and exit
  --subject SUBJECT     Subject ID
  --bundle BUNDLE       White matter bundle name
  --tractogram TRACTOGRAM
                        Streamlines of subject bundle
  --mask MASK           Path to white matter bundle mask
  --map MAP             Brain microstructure map, e.g. FA, MD, etc.
  --output OUTPUT       Output directory to save extracted features
  --pointwise           Save point-wise in HDF5 format
```


## meta-neuro_shape_metrics

### Tool Description
Extract shape features from white matter bundle streamlines

### Metadata
- **Docker Image**: quay.io/biocontainers/meta-neuro:2.0.1--py313h47f2c4e_0
- **Homepage**: https://github.com/bagari/meta
- **Package**: https://anaconda.org/channels/bioconda/packages/meta-neuro/overview
- **Validation**: PASS

### Original Help Text
```text
usage: shape_metrics [-h] --subject SUBJECT --bundle BUNDLE --mask MASK
                     --tractogram TRACTOGRAM --output OUTPUT

Extract shape features from white matter bundle streamlines

options:
  -h, --help            show this help message and exit
  --subject SUBJECT     Subject ID
  --bundle BUNDLE       White matter bundle name
  --mask MASK           Binary image of white matter bundle
  --tractogram TRACTOGRAM
                        Streamline file of white matter bundle
  --output OUTPUT       Output directory to save features
```

