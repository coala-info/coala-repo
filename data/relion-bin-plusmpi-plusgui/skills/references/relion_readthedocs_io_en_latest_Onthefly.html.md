# On-the-fly processing[¶](#on-the-fly-processing "Link to this heading")

As of relion-4.0, on-the-fly processing is based on the [Schemes](Reference/Schemes.html#sec-schemes) functionality.
This has been implemented together with a small Tkinter GUI that was written by Colin Palmer from CCPEM for the `relion_it.py` python script that was distributed with relion-3.0 and 3.1.
The new program still carries the same name, and can be launched from your Project directory from the command line:

```
relion_it.py &
```

This will launch the GUI, which contains several sections that need to be filled in by the user.

Note

This script depends on pre-configured `Schemes/prep` and `Schemes/proc` *Schemes* that are distributed inside the scripts directory on the relion source code. To find these, the environment variable `RELION_SCRIPT_DIRECTORY` needs to be set to point to this directory. You can also use this variable to point towards your own modified version of the *Schemes*.

## Computation settings[¶](#computation-settings "Link to this heading")

This section specifies what calculations will be performed.

Do MotionCorr & CTF?:
:   v

    (If selected, a *Scheme* called `Schemes/prep` will be lanuched that will loop over all movies (as defined in the section Preprocessing settings to run Import, Motion correction and CTF estimation.
    By default this will be done for a maximum of 50 movies at a time.)

micrographs\_ctf.star::
:   Schemes/prep/ctffind/micrographs\_ctf.star

    (This option is only used if Do MotionCorr & CTF? is not selected.
    In that case, the user can provide the output STAR file from a previous CTF estimation job to perform the rest of the processing on.

Do Autopick & Class2D?:
:   v

    (If selected, a second *Scheme* called `Schemes/proc` will be lanuched that will automatically pick particles, as specified on the Particle settings and Processing settings sections, and then perform 2D classification and automated class selection through the Subset selection job.
    This is repeated on a loop, while the number of particles extracted is still increasing.)

Do Refine3D?:
:   v

    (If selected, the iteration of the second *Scheme* will also comprise a 3D auto-refine job.)

3D reference::
:   None

    (If set to None, or anything else that does not exist as a file, then an 3D initial model job will be launched before the auto-refine job.
    Note that in the case of symmetry, as defined in the Particle settings section, the initial model calculation is still performed in C1, but this calculation is followed by an alignment of the symmetry axes and the application of the symmetry to the model.)

GPUs (comma-separated)::
:   0,1

    (This option is used to specify the IDs of the GPU devices you want to run on.
    Since the motion correction and CTF estimation are CPU-only, this option is only used by the second *Scheme*.)

## Preprocessing settings[¶](#preprocessing-settings "Link to this heading")

This section specifies information about where the movies are and how they were recorded.

Pattern for movies::
:   Movies/\*.tiff

    (This specifies where the movies are.
    If you have recorded movies in the `.eer` format, it is recommended that you convert them to `.tiff` format during the copying process from the microscope computer to your processing computer.)

Gain reference (optional)::
:   Movies/gain.mrc

    (Only use this option if your movies have not been gain-corrected yet, otherwise leave empty.)

Super-resolution?:
:   (Click this if your movies are in super-resolution.
    Note that we do not recommend recording movies in super-resolution, and that they will be binned during the Motion correction job.)

Voltage (kV)::
:   300

Cs (mm)::
:   2.7

Phase plate?:
:   v

    (Click this if you have collected your images with a phase plate.
    In that case, the CTF estimation job will also estimate the phase shift.)

(Super-res) pixel size (A)::
:   (Provide the pixel size in the movies.
    If they are in super-resolution, then provide the (smaller) super-resolution pixel size.)

Exposure rate (e-/A2/frame)::
:   1.2

    (This is the accumulated dose in a single movie frame.)

## Particle settings[¶](#particle-settings "Link to this heading")

Symmetry::
:   C1

Longest diameter (A)::
:   180

    (The longest diameter will be used to automatically determine the box size below, as well as for LoG and topaz picking.)

Shortest diameter (A)::
:   150

    (This will only be used for LoG picking.
    This value should be smaller or equal than the longest diameter above, and is useful to pick elongated particles.)

Mask diameter (A)::
:   198.0

    (This is used for Auto-picking jobs, as well as 2D classification, 3D initial model and 3D auto-refine

Box size (px)::
:   246

    (The box size in the original micrograph.)

Down-sample to (px):
:   64

    (To speed up all calculations in the `proc` *Scheme*, all particles will be downsampled to this box size.)

Calculate for me::
:   v

    (This will generate automated suggestions for the mask diameter, the box size and the down-sampled box size.
    We often use these.)

## Processing settings[¶](#processing-settings "Link to this heading")

Min resolution micrographs?:
:   6

    (Only micrographs with an estimated CTF resolution beyond this value will be selected.
    Set to 999 not to throw away any micrographs.)

Retrain topaz network?:
:   v

    (If this is selected, then the `proc` *Scheme* will first use the below specified number of particles for an initial 2D classification and automated class selection in Subset selection.
    The selected particles are then used to re-train the neural network in topaz for this data set.
    Once the re-training is finished, the entire data set will be picked using topaz.

Nr particles for Log picking::
:   10000

    (The number of particles used for LoG picking.)

LoG picking threshold::
:   0

    (The threshold to LoG pick particles.

LoG class2d score::
:   0.5

    (The threshold to automatically select 2D class averages from the LoG picked particles.
    A value of 0 means rubbish classes; a value of 1 means gorgeous classes.)

Topaz model::
:   Schemes/proc/train\_topaz/model\_epoch10.sav

    (If one does not retrain the topaz network, then this option can be used to provide a pre-trained network.
    If this option is left empty, then the default general network inside topaz is used.)

Nr particles per micrograph::
:   300

    (The expected number of particles per micrograph, which is used both for topaz training and picking.)

Topaz picking threshold::
:   0

    (The topaz threshold to select particle.
    Using negative values, e.g. -3, will pick more particles.)

Topaz class2d score::
:   0.5

    (The threshold to automatically select 2D class averages from the LoG picked particles.
    A value of 0 means rubbish classes; a value of 1 means gorgeous classes.)

Finally, the GUI has two action buttons:

The Save options button will save the currently selected options to a file called `relion_it_options.py`.
This (together with any other options files) can be read in when launching the GUI a next time from the command line:

```
relion_it.py relion_it_options.py [extra_options2.py ....] &
```

The Save &run button will also save the options, and it will actually launch the *Schemes* and open the normal relion GUI, from which the progress can be monitored, as explained on the [Schemes](Reference/Schemes.html#sec-execute-schemes) reference page.

## Intervening[¶](#intervening "Link to this heading")

Once the *Schemes* are running, you will see new jobs popping up in the normal relion GUI. As soon as you start seeing some results, you may find that you want to change some of the parameters. To make stopping and restarting a *Scheme* easier, there is another GUI: `relion_schemegui.py`. It needs to be launched for each running *Scheme* separately. The Save &run button above, will have launched one for both the `prec` and `proc` *Scheme*, but you can also launch it from the command line:

```
relion_schemegui.py proc &
```

This GUI will look for the hidden directory (`.relion_lock_scheme_proc`) that locks this *Scheme* to see whether it is running or not, and it will update the `Current` entry to indicate at what job or operator the *Scheme* currently is.

To stop a running *Scheme*, press the Abort button and wait for the underlying jobs and the schemer to receive the abort signal. Depending on what the *Scheme* is executing, this may take a bit of time. Once it has been aborted, you can then change options to specific jobs through the `Set Job option` section, or change variables in the *Scheme* through the `Set Scheme variable` section. (The GUI still needs some work here to make this easier and more error-resistant).

After changing variables to any job, it’s status will be reverted to `has not started`, meaning that a new relion job will be launched next time the *Scheme* comes across it. For any `continue` type of job (like Motion correction, CTF estimation, Auto-picking or Particle extraction), a new job will only be launched if that job’s options were changed, or if the options were changed for any job that came before that job. Otherwise, the job will just continue, and thereby already performed calculations will not be repeated.

To start the *Scheme* again, press the Restart button. The *Scheme* will be executed from the job or operator specified on the `Current` entry. If you want, you can change this from the point where it was aborted. If you want to restart the *Scheme* all the way from the beginning, then press the Reset button, before pressing Restart.

Sometimes, a *Scheme* dies because of an error, not because of it finishing or being aborted. In that case, the lock directory (`.relion_lock_scheme_proc`) needs to be deleted, before the *Scheme* can be used again. Press the Unlock button to print instructions on how to do that. (TODO: implement this through a popup window from the GUI…)

## Control more options[¶](#control-more-options "Link to this heading")

Not all options of all relion jobs, or all of the parameters of the *Schemes* themselves can be controlled from the `relion_it.py` GUI.
You can still control all of these through manually editing the `relion_it_options.py` file.
For this, use double underscores to separate `SCHEMENAME__JOBNAME__JOBOPTION` for any option.
Some options are already in the default file, but any other options can be added.

E.g. to change the number of 2D classes (`nr_classes`) in the `class2d_ini` job of the the `proc` Scheme, you can add the following line to the `relion_it_options.py` file:

```
'proc__class2d_ini__nr_classes', '200',
```

Likewise, use `SCHEMENAME__VARIABLENAME` for variables in the *Schemes* themselves, e.g. to set de `do_at_most` variable, which determines the maximum number of micrographs that are processed in one cycle of the `prep` *Scheme*, edit this line:

```
'prep__do_at_most', '100',
```

You can also save options for the relevant settings for your local setup in a second options file, e.g. `relion_it_options_LMB-Krios1.py`, and then call `relion_it.py` with those, e.g.:

```
relion_it.py relion_it_options_LMB-Krios1.py relion_it_options.py &
```

If the same option is specified in multiple options files, the value in the last file on the command line will be used.

One could even make a specific command for each microscopy setup by using an alias like:

```
alias relion_it_krios1.py 'relion_it.py relion_it_options_LMB-Krios1.py'
```

## Site-specific setup[¶](#site-specific-setup "Link to this heading")

At the very least, you will need to change the position of the executables for ctffind 4.1 or Gctf and topaz, but you may also want to tweak the default settings for number of threads or MPI processors for the different jobs. So, you local setup options file will likely include options like:

```
{
'prep__ctffind__fn_ctffind_exe' : '/wherever/ctffind/ctffind.exe',
'prep__ctffind__fn_gctf_exe' : '/wherever/Gctf/bin/Gctf',
'proc__inipicker__fn_topaz_exe' : '/wherever/topaz/topaz',
'proc__restpicker__fn_topaz_exe' : '/wherever/topaz/topaz',
'proc__train_topaz__fn_topaz_exe' : '/wherever/topaz/topaz',
'prep_motioncorr__nr_threads' : '16',
'proc_restpicker__nr_mpi' : '4',
'proc_extract_ini__nr_mpi' : '4',
'proc_extract_rest__nr_mpi' : '4',
'proc_class2d_ini__nr_threads' : '12',
'proc_class2d_rest__nr_threads' : '12',
'proc_inimodel3d__nr_threads' : '12',
'proc_refine3d__nr_threads' : '8',
'proc_refine3d__nr_mpi' : '3'
}
```

Remember it is also possible to edit the `job.star` and `scheme.star` files inside your own copy of the `Schemes/prep` and `Schemes/proc` directories, and use the environment variable `$RELION_SCRIPT_DIRECTORY` to point towards the modified scripts. That provides an alternative that would no longer rely on specifying an extra options file, and allows maximum flexibility in adopting the schemes to your specific needs.

[![Logo](_static/relion-logo.png)](index.html)

### Navigation

* [What’s new?](Whats-new.html)
* [The team](Team.html)
* [Installation](Installation.html)
* [Single particle tutorial](SPA_tutorial/index.html)
* [Subtomogram tutorial](STA_tutorial/index.html)
* On-the-fly processing
  + [Computation settings](#computation-settings)
  + [Preprocessing settings](#preprocessing-settings)
  + [Particle settings](#particle-settings)
  + [Processing settings](#processing-settings)
  + [Intervening](#intervening)
  + [Control more options](#control-more-options)
  + [Site-specific setup](#site-specific-setup)
* [Reference pages](Reference/index.html)

---

* [Source repository of this documentation](https://github.com/3dem/relion-documents)

### Related Topics

* [Documentation overview](index.html)
  + Previous: [Model building with ModelAngelo](STA_tutorial/ModelAngelo.html "previous chapter")
  + Next: [Reference pages](Reference/index.html "next chapter")

### Quick search

©RELION developer team, licensed under GPLv3.
|
Powered by [Sphinx 8.2.3](https://www.sphinx-doc.org/)
& [Alabaster 1.0.0](https://alabaster.readthedocs.io)
|
[Page source](_sources/Onthefly.rst.txt)