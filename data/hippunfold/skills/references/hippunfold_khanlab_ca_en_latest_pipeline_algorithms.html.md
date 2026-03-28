[HippUnfold Documentation](../index.html)

Getting started

* [Installation](../getting_started/installation.html)
* [Running HippUnfold with Docker on Windows](../getting_started/docker.html)
* [Running HippUnfold with Singularity](../getting_started/singularity.html)
* [Running HippUnfold with a Vagrant VM](../getting_started/vagrant.html)

Usage Notes

* [Command-line interface](../usage/cli.html)
* [Running HippUnfold on your data](../usage/useful_options.html)
* [Specialized scans](../usage/specializedScans.html)
* [Template-base segmentation](../usage/templates.html)
* [Frequently asked questions](../usage/faq.html)

Processing pipeline details

* [Pipeline Details](pipeline.html)
* Algorithmic details
  + [Hippocampal unfolding](#hippocampal-unfolding)
    - [Template-based shape injection](#template-based-shape-injection)
    - [Fast marching initialization](#fast-marching-initialization)
    - [Solving Laplace’s equation](#solving-laplace-s-equation)
    - [Equivolumetric laminar coordinates](#equivolumetric-laminar-coordinates)
    - [Warps for unfolding](#warps-for-unfolding)
      * [Forward warps](#forward-warps)
    - [Inverse warps](#inverse-warps)
    - [Standard surface meshes](#standard-surface-meshes)
    - [Subfield segmentation](#subfield-segmentation)
    - [Dentate gyrus unfolding](#dentate-gyrus-unfolding)

Outputs of HippUnfold

* [Output Files](../outputs/output_files.html)
* [Visualization](../outputs/visualization.html)
* [Quality Control](../outputs/QC.html)

Contributing

* [References](../contributing/references.html)
* [Contributing to Hippunfold](../contributing/contributing.html)

[HippUnfold Documentation](../index.html)

* Algorithmic details
* [View page source](../_sources/pipeline/algorithms.md.txt)

---

# Algorithmic details[](#algorithmic-details "Permalink to this heading")

## Hippocampal unfolding[](#hippocampal-unfolding "Permalink to this heading")

Our approach to unfolding the hippocampus involves constructing a coordinate system, defined using the solutions to partial differential equations to enforce smoothness, and to employ anatomically-derived boundary conditions. Each of the three coordinates (AP, PD, IO) are solved independently of each other, each using distinct boundary conditions defined by the hippocampus tissue segmentation. With the notation \(L\_{ROI}\) to represent the labelled set of voxels in the hippocampus of a specific ROI, the domain of the solution, along with boundary conditions as source and sink, are defined as follows:

\[
L\_{domain}= \begin{cases}
L\_{GM} \cup L\_{DG}, & \text{if coords}=AP \lor PD \lor IO
\end{cases}
\]

\[\begin{split}
L\_{source} =
\begin{cases}
L\_{HATA}, & \text{if coords}=AP\\
L\_{MTLC}, &\text{if coords}=PD\\
L\_{SRLM} \cup L\_{Pial} \cup L\_{Cyst} ,& \text{if coords}=IO\\
\end{cases}
\end{split}\]

\[\begin{split}
L\_{sink} =
\begin{cases}
L\_{IndGris}, & \text{if coords}=AP\\
L\_{DG}, &\text{if coords}=PD\\
L\_{background},& \text{if coords}=IO\\
\end{cases} \\
\end{split}\]

### Template-based shape injection[](#template-based-shape-injection "Permalink to this heading")

We make use of a fluid diffeomorphic image registration, between a template hippocampus tissue segmentation, and the U-net tissue segmentation, in order to 1) help enforce the template topology, and 2) provide an initialization to the Laplace solution. By performing a fluid registration, driven by the segmentations instead of the MRI images, the warp is able to bring the template shape into close correspondence with the subject, but the regularization helps ensure that the topology present in the template is not broken. The template we use was built from 22 *ex vivo* images from the [Penn Hippocampus Atlas](https://www.nitrc.org/projects/pennhippoatlas/).

The registration is performed using [greedy](https://sites.google.com/view/greedyreg/about), initialized using moment tensor matching (without reflections) to obtain an affine transformation, and a multi-channel sum of squared differences cost function for the fluid registration. The channels are made up of binary images, split from the multi-label tissue segmentations, which are then smoothed with a Gaussian kernel with standard deviation of 0.5*mm*. The Cyst label is replaced by the SRLM prior to this, since the locations of cysts are not readily mapped using a template shape. After warping the discrete template tissue labels to the subject, the subject’s Cyst label is then re-combined with the transformed template labels.

The pre-computed Laplace solutions on the template image (analogous to method described below), \(\psi\_{A \to P}^{template}\), \(\psi\_{P \to D}^{template}\), \(\psi\_{I \to O}^{template}\), are then warped to the subject using the diffeomorphic registration to provide an initialization for the subject.

### Fast marching initialization[](#fast-marching-initialization "Permalink to this heading")

As an alternative if template-based shape injection is not used, we employ a fast marching method to provide an initialization to the Laplace solution, to speed up convergence. We make use of the [scikit-fmm Python package](https://github.com/scikit-fmm/scikit-fmm), that finds approximate solutions to the boundary value problems of the Eikonal equation,

\[
F(\mathbf{x}) \left| \nabla \phi(\mathbf{x}) \right| = 1,
\]

which describes the evolution of a closed curve as a function of time, \(\phi\), with speed \(F(\mathbf{x})>0\) in the normal direction at a point \(\mathbf{x}\) on the curve. The fast marching implementation provides a function (image) representing travel time to the zero contour of an input, \(\phi\).

We first perform fast marching from the source (forward direction), by initializing the zero contour with:

\[\begin{split}
\phi\_0(\mathbf{x}) =
\begin{cases}
0, & \mathbf{x} \in L\_{source} \\
1, & \mathbf{x} \notin L\_{source} \\
\end{cases}
\end{split}\]

and we make use of the NumPy masked arrays to avoid computations in voxels outside of \(L\_{domain}\). We use a constant speed function of 1, and perform fast marching to produce a travel-time image, \(T\_{forward}(\mathbf{x})\), that is normalized by \(\max(T\_{forward}(\mathbf{x}))\) to obtain an image from 0 to 1 (0 at the *source*). We perform the same process for the *sink* region, by setting \(\phi\) based on \(L\_{sink}\), which produces a normalized \(T\_{backward}(\mathbf{x})\) image. We combine forward and backward images by averaging \(T\_{forward}\) and \(1-T\_{backward}\) to produce the combined fast marching image, \(T\_{fastmarch}\).

### Solving Laplace’s equation[](#solving-laplace-s-equation "Permalink to this heading")

Laplace’s equation is a second-order partial differential equation,

\[
\nabla^2 \psi(\mathbf{x}) = 0,
\]

where \(\psi\) is a scalar field enclosed between the source and sink boundaries. A simple approach to solve Laplace’s equation is with an iterative finite-differences approach (Jacobian method), where each voxel in the field is updated at each iteration as the average of the neighbouring grid points, e.g. for a 2-D field,

\[
\psi\_{i+1}(x,y) = \frac{1}{4} \left[ \psi\_i(x+\Delta x,y) + \psi\_i(x-\Delta x,y) + \psi\_i(x,y+\Delta y) + \psi\_i(x,y-\Delta y) \right].
\]

For our 3-D implementation, we use the nearest 18 neighbours, and perform the operation using convolution with a kernel size of \(3\times3\times3\), or 27 voxels. We initialize the \(\psi\) field as follows:

\[\begin{split}
\psi\_{i=0}(\mathbf{x}) =
\begin{cases}
0, & \mathbf{x} \in L\_{source} \\
1, & \mathbf{x} \in L\_{sink} \\
T\_{fastmarch}(\mathbf{x}), & \mathbf{x} \in L\_{domain} \\
NaN, & \text{otherwise}. \\
\end{cases}
\end{split}\]

We used the convolve method from the [AstroPy Python package](https://docs.astropy.org/en/stable/api/astropy.convolution.convolve.html) instead of NumPy’s convolve, because it avoids using NaN values (i.e. voxels outside the gray matter) in the convolution, replacing them with interpolated values using the convolution kernel. We iteratively update \(\psi\) until either the sum-of-squared-differences,
\( \sum \left[ \psi\_i(\mathbf{x}) - \psi\_{i-1}(\mathbf{x})\right]^2\), is less than \(1 \times 10^{-5}\),
or a maximum iterations of 10,000 are reached. Note that more efficient approaches to solving Laplace’s equation are possible (such as successive over-relaxation), however, we used this more conservative approach to avoid stability and convergence issues.

We use this approach to independently produce \(\psi\_{A \to P}\) and \(\psi\_{P \to D}\). Note that because we are solving these fields independent of one another, their gradient fields are not guaranteed to be perpendicular, however, we have not observed large deviations in practice. A solution for jointly solving \(\psi\_{A \to P}\) and \(\psi\_{P \to D}\) is left for future work.

### Equivolumetric laminar coordinates[](#equivolumetric-laminar-coordinates "Permalink to this heading")

For the laminar, or inner-outer coordinates, , \(\psi\_{I \to O}\), it has been shown that an equivolumetric approach, that preserves the volume of cortical segments by altering laminar thickness based on the curvature, is more anatomically-realistic for the cerebral cortex.
We implement this approach as the default for the IO coordinates, making use of the implementation in [NighRes](https://nighres.readthedocs.io/en/latest/laminar/volumetric_layering.html).
Here, we set the inner level-set to be \(L\_{source}\), effectively the SRLM, and the outer level-set as the entire hippocampus. The continuous depth image returned by the volumetric layering function is then used directly as \(\psi\_{I \to O}\).

### Warps for unfolding[](#warps-for-unfolding "Permalink to this heading")

We make use of the three coordinates, \(\psi\_{A \to P}\), \(\psi\_{P \to D}\), and \(\psi\_{I \to O}\), to create 3D warp fields that transform images and surfaces between the native domain \(D\_{native} \subset \mathbf{R}^3\), and the unfolded domain \(D\_{unfolded} \subset \mathbf{R}^3\).

Because solve Laplace’s equation in voxels restricted to the gray matter, the native domain, \(D\_{native}\) is made up of \(\mathbf{x}=(x,y,z)\), where \(\mathbf{x} \in L\_{GM}\).

The unfolded domain, \(D\_{unfolded}\), is a distinct 3D space, indexed by \(\mathbf{u}=(u,v,w)\), where \(u =\psi\_{A \to P}(x,y,z)\), \(v = \psi\_{P \to D}(x,y,z)\), and \(w = \psi\_{I \to O}(x,y,z)\). The \(\psi\) fields are initially normalized to \(0 \to 1\), which would produce a rectangular prism between \((0,0,0)\) and \((1,1,1)\). However, we have re-scaled the aspect ratio and discretization to better approximate the true size of the hippocampus along each dimension, producing a volume of size \(256x128x16\). To facilitate visualization, we set the origin to \((0,200,0)\) (in *mm*) so as not to overlap with our native space) and set a physical voxel spacing of \(0.15625\)*mm* in each direction.

#### Forward warps[](#forward-warps "Permalink to this heading")

The transformation, or displacement warp field, that takes points, \(\mathbf{x} \in \mathbf{R}^3\), (or surfaces) from native to unfolded space, is denoted as \(T\_{\mathbf{x} \to \mathbf{u}}^{surf}:(x,y,z) \to (u,v,w)\), and is simply defined as:

\[
T\_{\mathbf{x} \to \mathbf{u}}^{surf}(x,y,z) = \left( \psi\_{A \to P}(x,y,z) - x, \psi\_{P \to D}(x,y,z) - y, \psi\_{I \to O}(x,y,z) - z\right),
\]

and is valid for any point, or surface vertex, within the native domain, \(D\_{native}\). Note that construction of this displacement field also involves rescaling for the physical voxel dimensions of the unfolded domain as described above, which is left out of the above equations.

##### Warps for surfaces and images[](#warps-for-surfaces-and-images "Permalink to this heading")

The warp field that transforms points/surfaces from native to unfolded also transforms images from the unfolded to the native domain,

\[
T\_{\mathbf{x} \to \mathbf{u}}^{surf} = T\_{\mathbf{u} \to \mathbf{x}}^{img},
\]

since images on a rectilinear grid must be warped with the inverse of the transformation that is required for points or surfaces. This is not particular to HippUnfold, and is true for any transformations. This is because instead of pushing forward from the moving image grid (which leads to off-grid locations), we start at the fixed grid-point (e.g. in native space), and pull-back with the inverse transformation to determine an (off-grid location) in unfolded space, to interpolate image intensities from neighbouring grid locations (e.g. in the unfolded space).

### Inverse warps[](#inverse-warps "Permalink to this heading")

To obtain, \(T\_{\mathbf{u} \to \mathbf{x}}^{surf}:(u,v,w) \to (x,y,z)\), or equivalently, \(T\_{\mathbf{u} \to \mathbf{x}}^{img}: D\_{native} \to D\_{unfolded}\), requires determining the inverse of the transformation that is provided by the \(\psi\) fields. We achieve this by first applying the forward transformation on all grid locations in the native domain, obtaining

\[\begin{equation\*}
T\_{\mathbf{x} \to \mathbf{u}}^{surf}(x,y,z) = \left( Tx,Ty,Tz \right), \hspace{4em} \forall (x,y,z) \in D\_{native}.
\end{equation\*}\]

The source native grid location, \((x,y,z)\) for each the transformed points \((Tx,Ty,Tz)\) is used to define the inverse transformation:

\[\begin{equation\*}
T\_{\mathbf{u} \to \mathbf{x}}^{scattered}(Tx,Ty,Tz) = \left( x-Tx,y-Ty , z-Tz \right)
\end{equation\*}\]

However, these points are only defined at scattered locations in the unfolded space, thus we need to use interpolation between these points to obtain \(T\_{\mathbf{u} \to \mathbf{x}}^{surf}\) defined at all grid locations in \(D\_{unfolded}\). We perform this operation using the *griddata* function from *SciPy*, which interpolates unstructured multi-variate data onto a grid,
by triangulating the input data with [Qhull](https://www.qhull.org), then performing piecewise linear barycentric interpolation on each triangle. Due to discretization in the \(\psi\) fields that produced the forward transformation, there are voxels outside the convex hull of the points that are not able to be linearly interpolated. To fill these values in, we make use of the *griddata* function with nearest neighbour interpolation instead. Note that this produces singularities in the warp (since points outside the convex hull have the same destination as the nearest convex hull point, but this is strictly limited to the edges of the hippocampus, and have little practical implications in our experience.
After linear and nearest neighbour interpolation, the final warp field is produced:

\[
T\_{\mathbf{u} \to \mathbf{x}}^{surf} = T\_{\mathbf{x} \to \mathbf{u}}^{img}.
\]

Altogether, this provides transformations to warp either images or surfaces, in either direction (that is, native to unfolded, or unfolded to native). Image warps are defined using ITK format standards (Left-posterior-superior, or LPS coordinate system), and thus are compatible wi