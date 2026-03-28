![](./img/bamm_logo_sm.png)

---

# Get BamM

I use and love Linux and BamM has been developed to work on a Linux system. I'm not saying it won't work elsewhere, but I haven't tried. YMMV. People have successfully used BamM on many different flavours of Linux as well as on Mavericks 10.9 however OSX installs can be tricky and while we're actively working on making a version that seamlessly installs on OSX we're not there yet. At this stage we're saying that OSX is not supported. If you try it somewhere else and it works or you'd like to help me work out how to get the installer working for OSX then please let me know. I'd like to keep this list up to date.

The installation for BamM is a little more complicated than just using pip. Please see the [manual](manual/BamM_manual.pdf) for detailed installation instructions, including dependencies.

Source code for BamM is available [here](http://www.github.com/minillinim/BamM.git)

Dev docs for the BamM api are available [here](dev_docs/index.html)

---

# Licensing

BamM is licensed using the Lesser GNU General Public License version 3 as published by the Free Software Foundation.

This site and the BamM logo are copyright Mike Imelfort

This site was created using a template created by the wonderful people at [bootswatch](http://bootswatch.com).

---

# Use BamM

The primary motivation for building BamM was to replaace PySam in GroopM. Not saying PySam is bad, it's just that GroopM doesn't need all the PySam features and what it does need can be done way way faster in C-land.

From there, BamM was developed to be used as a command line tool and as a python library. Detailed information on the former can be found in our new, ever more detailed [manual](manual/BamM_manual.pdf). To use BamM as a library check out the [development api](dev_docs/index.html). If you're feeling rushed then read on:

BamM on the command line is run in three modes:

* **make** - Make a bunch of BAM files by mapping several read sets against a common reference sequence
* **parse** - Examine the BAMs to produce coverage profiles or linking information
* **extract** - Extract reads that map to some given collections of contigs

BamM was designed to be as parameter-free as possible. For more information on these steps type:

$ bamm OPTION -h

---

# Cite BamM

If you use this software then we'd love you to cite us. Unfortunately that's impossible right now, but there is a paper just around the corner. Please contact Tim Lamberton. t\_dot\_lamberton\_at\_uq\_dot\_edu\_dot\_au or Mike Imelfort. m\_dot\_imelfort\_at\_uq\_dot\_edu\_dot\_au for more information

---

# Talk to us

All BamM related suggestions, criticisms or abuse should be directed to the current maintainer Tim Lamberton. t\_dot\_lamberton\_at\_uq\_dot\_edu\_dot\_au or the original author Mike Imelfort. m\_dot\_imelfort\_at\_uq\_dot\_edu\_dot\_au

---