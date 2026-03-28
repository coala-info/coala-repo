[Skip to main content](#main-content)

[![NASA Logo, National Aeronautics and Space Administration](/docs/images/nasa-logo.svg)](https://www.nasa.gov)

###### [NASA |](https://www.nasa.gov/) [GSFC |](https://www.nasa.gov/goddard/) [Sciences and Exploration](https://science.gsfc.nasa.gov/)

###### [HEASARC](/)

###### [High Energy Astrophysics Science Archive Research Center](/)

Menu

![Close](/assets/uswds/img/usa-icons/close.svg)

* HEASARC
  + [About](/docs/HHP_heasarc_info.html)
  + [Help Desk](/cgi-bin/Feedback)
  + [Upcoming Meetings](/docs/heasarc/meetings.html)
  + [Archive Your Data](/docs/heasarc/heasarc_req.html)
  + [Archive Statistics](/docs/heasarc/stats/stats.html)
  + [LAMBDA Portal](https://lambda.gsfc.nasa.gov)
* Observatories
  + [Observatories](/docs/observatories.html)
  + [Active Missions](/docs/heasarc/missions/active.html)
  + [Past Missions](/docs/heasarc/missions/past.html)
  + [Upcoming Missions](/docs/heasarc/missions/upcoming.html)
  + [Comparison](/docs/heasarc/missions/comparison.html)
* Archive
  + [Archive](/docs/archive.html)
  + [Search Portal](/xamin/)
  + [Search APIs](/docs/archive/apis.html)
  + [Cloud](/docs/archive/cloud.html)
  + [SciServer](/docs/sciserver/)
  + [FTP Area](/FTP/)
* Calibration
  + [Calibration](/docs/heasarc/caldb/caldb_intro.html)
  + [Remote Access](/docs/heasarc/caldb/caldb_remote_access.html)
  + [Documentation](/docs/heasarc/caldb/caldb_doc.html)
  + [Keywords](/docs/heasarc/caldb/caldb_keywords.html)
  + [Cross Calibration](/docs/heasarc/caldb/caldb_xcal.html)
  + [Supported Missions](/docs/heasarc/caldb/caldb_supported_missions.html)
* Software
  + [Software](/docs/software/index.html)
  + [HEASoft](/docs/software/lheasoft/)
  + [FITSIO](/docs/software/fitsio/fitsio.html)
  + [Xspec](/docs/software/xspec/index.html)
  + [Xronos](/docs/software/xronos/xronos.html)
  + [Ximage](/docs/software/ximage/ximage.html)
  + [XSTAR](/docs/software/xstar/xstar.html)
* Web Tools
  + [Web Tools](/docs/tools.html)
  + [WebPIMMS](/cgi-bin/Tools/w3pimms/w3pimms.pl)
  + [WebSpec](/webspec/webspec.html)
  + [Viewing Tool](/cgi-bin/Tools/viewing/viewing.pl)
  + [nH Calculator](/cgi-bin/Tools/w3nh/w3nh.pl)
  + [Coordinates Converter](/cgi-bin/Tools/convcoord/convcoord.pl)
  + [Time Converter](/cgi-bin/Tools/xTime/xTime.pl)
  + [SkyView](https://skyview.gsfc.nasa.gov/)
* Help & Support
  + [Help Desk](/cgi-bin/Feedback)
  + [Proposal Submission](/RPS)
  + [Bibliography](/docs/heasarc/biblio/pubs/)
  + [Resources for Scientists](/docs/heasarc/resources.html)
  + [FAQ](/docs/faq.html)
  + [Outreach](/docs/outreach.html)

* [About](/docs/HHP_heasarc_info.html)
* [Sitemap](/docs/sitemap.html)
* [Help Desk](/cgi-bin/Feedback)
* [Archive Your Data](/docs/heasarc/heasarc_req.html)

Search

![Search](/assets/uswds/img/usa-icons-bg/search--white.svg)

[Come analyze HEASARC, IRSA, and MAST data in the cloud!](https://science.nasa.gov/astrophysics/programs/physics-of-the-cosmos/community/the-fornax-initiative/#beta-release)
The Fornax Initiative is now welcoming all interested beta users.

# HEASoft & Docker

## What Is Docker?

To learn all about Docker, please visit [the Docker website](https://www.docker.com), and to learn more about containers and images, please see [Docker's explanation](https://www.docker.com/resources/what-container/) or [one from AWS](https://aws.amazon.com/compare/the-difference-between-docker-images-and-containers/).

For our purposes, Docker enables packaging HEASoft as a standalone executable container that includes everything needed to run HEASoft: the code, the system tools and libraries, and the settings.

The primary benefit for HEASoft users is that it allows for an easier installation process and use of our software on any operating system supported by Docker.

## Installation

Currently, we provide two approaches for installing HEASoft with Docker, both of which require that you have installed the [Docker Engine](https://www.docker.com/products/docker-desktop) (i.e. the Docker application or executable) and have it running. Also note that older versions of Docker may not be compatible with some of the syntax used below, so it's a good idea to make sure your Docker application is up-to-date.

The *docker* commands below require that in addition to having the Docker application running, you should have the command-line *docker* executable available in your Unix PATH. It typically installs as /usr/local/bin/docker, so either add /usr/local/bin to your PATH (and run "rehash"), or in the commands below replace **docker** with **/usr/local/bin/docker**.

Our two approaches are the following:

1. A Dockerfile that retrieves a complete HEASoft source code tar file and then creates an Ubuntu Linux container into which all of HEASoft is installed. To use this approach, download [this tar file](/FTP/software/lheasoft/release/heasoft-6.36docker1.03.tar).

   Unpack it anywhere you choose, and then run **make**:

   ```
   $ tar xf heasoft-6.36docker1.03.tar
   $ make
   ```

   Or, if necessary:

   ```
   $ sudo make
   ```
2. For users who do not need all of HEASoft, [the standard "a la carte" tar files](download.html) now unpack with a Docker folder from which one can install a container that includes only the packages that were selected for inclusion.

   Once you have downloaded and unpacked your HEASoft source code, make sure that you have a GNU tar executable - for example **gtar**, **gnutar**, or perhaps just **tar** - in your **PATH** or else assigned to the **TAR** environment variable, and then run **make** inside the Docker folder:

   ```
   $ cd heasoft-6.36/Docker
   $ make
   ```

   Or, if necessary:

   ```
   $ sudo make
   ```

For either approach, note that you may need to run **sudo make** instead of just **make** if your docker executable requires root permission to run. In either case, **make** will launch the appropriate set of commands to create and set up a new Ubuntu Linux container, and then configure, build, and install HEASoft inside the container. This process may take a while depending on your hardware and which approach you selected.

At first you will see some screen output from the various build commands, and you may eventually see a message that a *log limit of 1MiB has been reached*, but this is normal and does not imply that an error has occurred.

## Using HEASoft in Docker

When **make** has finished, you may open the container in Docker, using for example:

```
$ docker run --rm -it heasoft:v6.36 tcsh
```

This command should provide you with an interactive docker prompt for the new container in a **T C-shell**, and place you in the **/home/heasoft** directory. Alternatively you may want to start up docker adding a volume from your host machine to the container, for example:

```
$ docker run --rm -it -v /Users/user1/data:/mydata heasoft:v6.36 tcsh
```

This should mount the host directory "/Users/user1/data" inside the container as "/mydata". More information about this and other Docker options can be found at [the Docker website](https://docs.docker.com).

At this point you might run **fversion** to confirm that the installation is working,

```
$ fversion
```

or **fhelp** to get more information about a particular task or package, for example:

```
$ fhelp heatools
```

Note that the HEASARC CALDB has been set up in your environment using the **remote** setting:

```
CALDB=https://heasarc.gsfc.nasa.gov/FTP/caldb
CALDBCONFIG=/opt/heasoft/caldb/caldb.config
CALDBALIAS=/opt/heasoft/caldb/alias_config.fits
```

Xspec users may add local models as desired in the standard way.

## Using GUI Tasks or Plotting

To use GUI tasks (FV, etc.) or display plot windows from e.g. Xspec, modifications can be made to your X server connections.

For example, on **Mac hosts** running XQuartz, open the XQuartz Preferences menu, and in the Security tab check the "Allow connections from network clients" box. Then, quit XQuartz and restart it. From a new X terminal run these commands to start up the container with an X connection:

```
$ /opt/X11/bin/xhost + 127.0.0.1
$ docker run --rm -it -e DISPLAY=host.docker.internal:0 heasoft:v6.36 tcsh
```

For **Linux hosts** with X11 installed, start the container with:

```
$ docker run --rm -it -e DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix:ro heasoft:v6.36 tcsh
```

Then, in a separate terminal:

```
$ docker ps -l -q
```

Use the output from this command in the next one:

```
$ xhost +local:<output from previous command>
```

The two steps above could alternatively be combined as:

```
$ xhost +local:`docker ps -l -q`
```

## Python, and editing the Dockerfiles

PyXspec and the HEASP Python interface are both available, accessible by running **python** (which is **python3** by default) and importing the relevant package.

In the future, other Python packages may be installed by default as part of our Dockerfiles, but for now users are of course free to edit these files to suit their purposes. For example, under the **HEASoft prerequisites** section, an Ubuntu 'apt-get' command installs a number of packages, and while you should not remove any of the existing prerequisites, the list may easily be added to, with (for example) some standard Python packages and a text editor (vim):

```
...
...
python3-astropy \
python3-astroquery \
python3-matplotlib \
python3-pandas \
python3-pip \
python3-pyvo \
python3-scipy \
ipython3 \
vim \
...
...
```

Caution should be taken to ensure that proper Dockerfile syntax is preserved, particularly with the trailing back slashes "\" in the context mentioned above.

An example Dockerfile that adds the extra packages listed above is available [here](/FTP/software/lheasoft/release/Dockerfile_example). (Note that this example is for the complete HEASoft approach only, and would need to be renamed as "Dockerfile" to actually be used.)

## Preserving Changes and Cleaning Up

If you wish to preserve changes made to an existing image (or files created in the image that aren't on a shared volume), use the "docker commit" option. For example:

Before exiting the container you want to commit a change to, run the following in a separate terminal on your host machine:

```
$ docker ps -a
CONTAINER ID   IMAGE             COMMAND   CREATED          STATUS          PORTS     NAMES
3faf5af4ac17   heasoft:v6.36     "tcsh"    8 days ago       Up 33 seconds             angry_bose
```

Using the CONTAINER\_ID, create a new image with a new name:

```
$ docker commit 3faf5af4ac17 heasoft_new
```

Now "docker images" shows the new image:

```
$ docker images
REPOSITORY   TAG       IMAGE ID       CREATED          SIZE
heasoft_new  latest    d98eeb6e562d   44 seconds ago   12.5GB
heasoft      v6.336    274fc5d180ea   8 days ago       12.5GB
```

To clean up, exit the running image and use the "IMAGE ID" to remove the older image:

```
$ docker rmi 274fc5d180ea
```

Similarly, if you find it necessary to re-make an image for any reason, the old image will remain in the system (untagged) until you clean it up:

```
$ docker images clean
```

To free up disk space, you may also find it useful to occasionally "prune" various levels of the Docker system. For reference, please see [this section about pruning at Docker.com](https://docs.docker.com/config/pruning).

As always, the best reference for any Docker command is the [documentation at Docker.com](https://docs.docker.com).

## Help

Please send any comments or questions to the [FTOOLS Help Desk](/cgi-bin/ftoolshelp).

Last modified Wednesday, 18-Feb-2026 19:44:34 EST

Return to top

* [HEASARC](/docs/)
* [Observatories](/docs/observatories.html)
* [Archive](/docs/archive.html)
* [Calibration](/docs/heasarc/caldb/caldb_intro.html)
* [Software](/docs/software.html)
* [Web Tools](/docs/tools.html)
* [Help & Support](/cgi-bin/Feedback)

![NASA logo](/docs/images/nasa-logo.svg)

* [About NASA](https://www.nasa.gov/about/)
* [Accessibility](https://www.nasa.gov/accessibility/)
* [FOIA](https://www.nasa.gov/foia/)

* [No FEAR Act](https://www.nasa.gov/odeo/no-fear-act/)
* [Privacy Policy](https://www.nasa.gov/privacy/)
* [Vulnerability Disclosure Policy](https://www.nasa.gov/vulnerability-disclosure-policy/)

* Responsible Official: Ryan Smallcomb
* Site Editor: Kristen Killingsworth
* Last Updated: 18-Feb-2026

A service of the
[Astrophysics Science Division](https://science.gsfc.nasa.gov/astrophysics)
at [NASA/GSFC](https://www.nasa.gov/goddard/)