# What’s new?[¶](#what-s-new "Link to this heading")

## Release 5.0[¶](#release-5-0 "Link to this heading")

**Blush regularisation**

Dari Kimanius has developed a new method to incorporate more prior knowledge into the cryo-EM refinement process than the one typically used (which merely assumes smoothness in real-space, or limited power in Fourier-space). This method is called Blush regularisation and it uses a denoising convolutional neural network inside the iterative refinement algorithm of Class3D, Refine3D or MultiBody jobs. The effects of this are largest when the signal is weak and standard refinement in RELION would overfit (as for example visible from streaky artefacts in the solvent region). Using Blush reglarisation, Dari successfully refined a data set of a 40 kDa protein:RNA complex to 2.5A. The same data set was intractable in standard RELION or CryoSPARC.

**DynaMight for modelling continuous structural heterogeneity**

Johannes Schwab developed a method called DynaMight that ‘explores protein **Dyna**-mics, and **Might** improve your map’. It is based on a variational auto-encoder that predicts 3D deformations of a Gaussian model for the consensus map, and a deformed backprojection algorithm that attempts to “un-do” these deformations to reconstruct an improved consensus map.

**ModelAngelo for automated atomic model building**

Kiarash Jamali developed a machine-learning approach for automated atomic model building and identification of unknown proteins in cryo-EM maps. ModelAngelo will build most of your automatically, provided the resolution extends beyond 3.5-4.0 Angstroms. Goodbye to months in the dark graphics room!

**Select subsets of filaments using dendrograms**

David Li developed a useful utility to select subsets of filament particles that belong to the same structural class. It has been implemented on the Filaments tab of the Subset selection job type. See [FilamentTools](FilamentTools.html#sec-filamenttools) for more details.

**Support for AMD and Intel GPUs (HIP/ROCm and SYCL)**

Suyash Tandon from AMD and Jason Do from Intel, together with their colleagues, have contributed code for GPU acceleration of relion-5 in HIP/ROCm and SYCL, respectively. This means that the `relion_refine` program can now also be run efficiently on AMD and Intel GPUs. (The previously existing CUDA implementation and vectorised CPU-acceleration still work too.)

**A complete subtomo-gram averaging pipeline**

Alister Burt, Euan Pyle, Sjors Scheres and others have developed a new pipeline for sub-tomogram averaging that starts with serialEM mdoc files and raw movies, and potentially ends with automated model building by ModelAngelo. You can access it by launching `relion --tomo` from the command line. However, please do note that this part of the code is not yet well tested and we have not yet been able to write an explanatory tutorial for this, so please be patient. Until we have finished the documentation and testing, you can play with the code already, but we cannot yet provide any feedback…

## Release 4.0[¶](#release-4-0 "Link to this heading")

Watch Sjors giving a Structural Studies Colloquium at MRC-LMB about the new features in release 4.0 on [YouTube](https://www.youtube.com/watch?v=kZTX4K4KeOY). Note that since then, *Schedules* have been renamed to *Schemes* to prevent confusion with the existing functionality to schedule jobs in the GUI.

**A new approach to subtomogram averaging**

Jasenko Zivanov and Joaquin (Kino) Oton have implemented a new approach to averaging in cryo-electron tomography, which replaces standard sub-tomograms with the concept of pseudo-sub-tomograms. The new approach leads to better weighting of the individual 2D images that make up a tilt series in `relion_refine` and the single-particle concepts of Bayesian polishing and CTF refinement have now also been implemented for tomography data. A preprint/publication about this work is pending.

**The VDAM refinement algorithm**

Dari Kimanius has implemented a new, gradient-driven algorithm with implicit regularisation, called Variable-metric Gradient Descent with Adaptive Moments (VDAM). The VDAM algorithm replaces the previously implemented SAGD algorithm for initial model generation, and makes 2D and 3D classification faster, especially for large data sets. A preprint/publication about this work, together with the automated class selection and the execution of workflow, is pending.

**Automated 2D class selection**

Liyi Dong developed a new algorithm for automatic selection of 2D class average images that combines features that are extracted from RELION’s 2D classification metadata with a convolutional neural network that acts on the 2D class averages themselves. The corresponding program, `relion_class_ranker` can be called through the Subset selection job type.

**Automatic execution of workflows**

Sjors developed a framework for the automated execution of predefined workflows, which is explained in more detail in the section on [On-the-fly processing](Onthefly.html#sec-onthefly).

**Tighter integration of the pipeliner with CCP-EM software**

The [CCP-EM team](https://www.ccpem.ac.uk/), mainly Matt Iadanza, Colin Palmer and Tom Burnley, have implemented a [python-based pipeliner](https://ccpem-pipeliner.readthedocs.io/en/latest/) in the CCP-EM software that mimics the relion pipeliner, but will be extended to include other CCP-EM softwares too. The python interface is convenient for scripting, and can also be called from relion’s main GUI, by adding the additional argument `relion --ccpem &`.

## Release 3.1[¶](#release-3-1 "Link to this heading")

**Aberration corrections and optics groups**

One of the major new features in relion-3.1 is a correction for higher-order aberrations in the data, i.e. besides the beamtilt correction already present in relion-3.0, the current version can also estimate and correct for trefoil and tetrafoil, as well as deviations from the nominal spherical aberration (Cs).
The corresponding paper can be found on bioRxiv [[ZNS20](Reference/Bibliography.html#id8)].
The signal to estimate these aberrations is calculated by averaging over particles from multiple micrographs.
To allow for multiple subsets of a data set having different Zernike coefficients, relion-3.1 implements the new concept of *optics groups*.
Optics groups are defined in a separate table called `data_optics` at the top of a STAR file, which will also contain a table called `data_movies`, `data_micrographs` or `data_particles`, depending on what type of images it refers to.
The second table is similar to the content of STAR files in previous releases, but contains a new column called `rlnOpticsGroup`, which is also present in the `data_optics` table.
Common CTF-parameters, like `rlnVoltage` and `` _`rlnSphericalAberration ``, but also the new `rlnOddZernike` and `rlnEvenZernike`, can be stored once for each optics group in the `data_optics` table, without the need to store them for each particle/micrograph in the second table.

The same program that handles higher-order aberrations can also be used to refine differences in (anisotropic) magnification between the reference and (groups of) the particles.
Besides correcting for anisotropic magnification in the data, this is also useful when combining data from different scopes.
As of release 3.1, the program that does 2D/3D classification and 3D refinement (`relion_refine`) can combine particles with different box sizes and pixel sizes in a single refinement, and the magnification refinement can be used to correct small errors in the (calibrated) pixel sizes.
The box and pixel size of the input reference (or the first optics group in 2D classification) will be used for the reconstructions/class averages.
You may want to check they are on the desired scale before running classifications or refinements!

Upon reading STAR files that were generated in older releases of relion, relion-3.1 will attempt to convert these automatically into the relion-3.1-style STAR files.
Therefore, moving a project from an older release to relion-3.1 should be easy.

**The External job-type**

relion-3.1 allows execution of third-party software within the relion pipeline through the new External job-type.
See [this section](Reference/Using-RELION.html#sec-external-jobtype) for details on how to use this.

**\*Schedules\* for on-the-fly processing**

The python script `relion_it.py` in relion-3.0 has been replaced by a new framework of *Schedules*, which implement decision-based scheduling and execution of relion jobs.
This comes with its own GUI interface.
See Schedules for details on how to use this.

**General tweaks**

Several tweaks have been made to enhance user experience:

* The pipeliner no longer looks for output files to see whether a job has finished.
  Instead, upon successful exit, all programs that are launched from within the relion pipeline will write out a file called `RELION_EXIT_SUCCESS` in the job directory.
  This avoids problems with subsequent execution of scheduled jobs with slow disc I/O.
* Likewise, when encountering an error, all programs will write out a file called `RELION_EXIT_FAILURE`.
  The GUI will recognise these jobs and use a red font in the Finished jobs list.
  Note that incorrectly labeled jobs can be changed using the ‘Mask as finished’ or ‘Mark as failed’ options from the Job actions pull-down menu.
* There is an ‘Abort running’ option on the Job actions pull-down menu, which will trigger the currently selected job to abort.
  This works because all jobs that are executed from within the relion pipeline will be on the lookout for a file called `RELION_JOB_ABORT_NOW` in their output directory.
  When this file is detected, the job will exit prematurely and write out a `RELION_EXIT_ABORTED` file in the job directory.
  Thereby, users no longer need to kill undesired processes through the queuing or operating system.
  The GUI will display aborted jobs with a strike-through red font in the Finished jobs list.
* When a job execution has given an error, in previous releases the user would need to fix the error through the input parameters, and then launch a new job.
  They would then typically delete the old job. relion-3.1 allows to directly overwrite the old job.
  This is accessible on Linux systems through `ALT+o` or through the `Overwrite continue` option from the ‘File menu’.
  Note that the `run.out` and `run.err` files will be deleted upon a job overwrite.

\*\* Tweaks to helical processing \*\*

Several new functionalities were implemented for helical processing:

* The `relion_helix_inimodel2d` program can be used to generate initial 3D reference maps for helices, in particular for amyloids, from 2D classes that span an entire cross-over (see [this section](Reference/Helix.html#sec-helix-inimodel2d)).
* The translational offsets along the direction of the helical axis can now be restricted to a single rise in 2D-classification.
* The 3D refinement and 3D classification now can use a prior on the first Euler angle, (`rlnAngleRotPrior`), which was implemented by Kent Thurber from the Tycko lab at the NIH.

[![Logo](_static/relion-logo.png)](index.html)

### Navigation

* What’s new?
  + [Release 5.0](#release-5-0)
  + [Release 4.0](#release-4-0)
  + [Release 3.1](#release-3-1)
* [The team](Team.html)
* [Installation](Installation.html)
* [Single particle tutorial](SPA_tutorial/index.html)
* [Subtomogram tutorial](STA_tutorial/index.html)
* [On-the-fly processing](Onthefly.html)
* [Reference pages](Reference/index.html)

---

* [Source repository of this documentation](https://github.com/3dem/relion-documents)

### Related Topics

* [Documentation overview](index.html)
  + Previous: [RELION](index.html "previous chapter")
  + Next: [The team](Team.html "next chapter")

### Quick search

©RELION developer team, licensed under GPLv3.
|
Powered by [Sphinx 8.2.3](https://www.sphinx-doc.org/)
& [Alabaster 1.0.0](https://alabaster.readthedocs.io)
|
[Page source](_sources/Whats-new.rst.txt)