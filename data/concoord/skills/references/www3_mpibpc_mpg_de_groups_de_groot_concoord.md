![](concoord.gif)

|  |  |  |  |  |  |  |  |
| --- | --- | --- | --- | --- | --- | --- | --- |
| [Home](concoord.html) | [News](concoord.html#news) | [Download](concoord.html#download) | [Features](concoord.html#features) | [Documentation](concoord_usage.html) | [FAQ](concoord_usage.html#faq) | [Installation](concoord_usage.html#installation) | [Feedback](concoord.html#feedback) |

## News:

![](cnc.jpg)
[Concoord version 2.1.2](http://www.mpibpc.mpg.de/groups/de_groot/concoord/concoord.html#download) , a minor bugfix and performance increase release has been released.

[Concoord version 2.1](http://www.mpibpc.mpg.de/groups/de_groot/concoord/concoord.html#download)  is ready! Among the new features are:- parallel operation on SMP machines- more robust structure generation due to dynamical adaptation of tolerances
    (option -dyn in disco)- optional structure regularisation for generated structures (-reg disco option)- disco options -rc and -l for more flexible user control of de-bumping- improved user control over convergence checks (-con option of disco)- enhanced efficiency due to grid-based neighbour searching- enhanced diagnostics- disco option -on to write NMR-style PDB files- major efficiency enhancement due to reorganisation of inner loops- lots of minor features and cleanups- lots of small bug fixes (thanks to all who have reported bugs and
                      contributed fixes!)

                      ## Introduction

                      CONCOORD is a method
                      to generate protein conformations around a known structure based on
                      geometric restrictions. Principal component analyses of Molecular
                      Dynamics (MD) simulations of proteins have indicated that collective
                      degrees of freedom dominate protein conformational fluctuations. These
                      large-scale collective motions have been shown essential to protein
                      function in a number of cases. The notion that internal constraints
                      and other configurational barriers restrict protein dynamics to a
                      limited number of collective degrees of freedom has led to the design
                      of the CONCOORD method to predict these modes without doing explicit,
                      more CPU intensive, MD simulations.

                      ## Methodology

                      The CONCOORD method consists of two stages. The first stage is the
                      identification of all interatomic interactions in the starting
                      structure. These interactions are divided among different categories,
                      depending on the strength of the interaction. Covalent bonds form the
                      tightest interactions and long-range non-bonded interactions are among
                      the weakest interactions. Based on the strength of the interaction, a
                      specific geometric freedom is given to each interacting pair. In this
                      way, a set of upper and lower geometric bounds is obtained for all
                      interacting pairs of atoms. The second stage consists of generating
                      structures other than the starting structure that fulfill all geometric
                      bounds. This is achieved by iteratively applying corrections to
                      randomly generated coordinates untill all bounds are
                      fulfilled.

                      ## Software

                      The CONCOORD software consists of two programs, one for each
                      stage. The program **dist** generates the geometric bounds and
                      **disco** is the program that generates structures from these
                      bounds. Use the -h option of both programs for detailed usage
                      information. These two programs will be put in the **PATH** environment
                      variable by sourcing the **CONCOORDRC** file in the CONCOORD root
                      directory. Additionally, the location of a number of library files
                      will from then on also be known to the programs. An interface to
                      CONCOORD can be found in the [WHAT IF](http://www.cmbi.kun.nl/whatif/)
                      and [YASARA](http://www.yasara.com) packages. Additionally, [Dynamite](http://s12-ap550.biop.ox.ac.uk:8078/dynamite_html/dynamite_splash.html) is based on CONCOORD.

                      ## [Documentation](concoord_usage.html)

                      Click [here](concoord_usage.html) for additional
                      information on concoord usage including HOWTO's, FAQ's, caveats and add-ons.

                      ## Licensing, usage requirements

                      Concoord is free to use for everyone. However, if you use concoord
                      for publications or presentations you must cite the original concoord
                      publication:

                      B.L. de Groot, D.M.F. van Aalten, R.M. Scheek, A. Amadei, G. Vriend
                      and H.J.C. Berendsen; ["Prediction of protein conformational freedom from distance
                      constraints"](http://md.chem.rug.nl/abstracts/degroot_5a.html), Proteins 29: 240-251 (1997)
                      [[pdf]](../pdf/concoord.pdf)

                      ## Download CONCOORD

                      - [CONCOORD 2.1.2 binary distribution for
                        Linux/x86\_64](concoord_2.1.2_linux64.tgz) - [CONCOORD 2.1.2 binary distribution for
                          Linux/i386](concoord_2.1.2_linux32.tgz) - [CONCOORD 2.1.2 binary distribution for
                            Mac/OSX](concoord_2.1.2_OSX.tgz)

                            - [CONCOORD 2.1.1 binary distribution for
                              Linux/x86\_64](concoord2.1.1_linux_x86_64.tgz) - [CONCOORD 2.1 binary distribution for
                                Linux/x86\_64](concoord2.1_linux_x86_64.tgz) - [CONCOORD 2.1 binary distribution for
                                  Linux/i386](concoord2.1_linux_i386.tgz)

                                  The previous distributions are also still available:- [CONCOORD 2.0 binary distribution for
                                    Linux/i386](concoord_2.0_lnx.tar.gz) - [CONCOORD 2.0 binary distribution for
                                      SGI](concoord_2.0_sgi.tar.gz) - [CONCOORD 2.0 binary distribution for
                                        DEC/alpha](concoord_2.0_dec.tar.gz) - [CONCOORD 2.0 binary distribution for
                                          OSX](concoord_2.0_osx.tar.gz) (thanks to Kay Gottschalk)

                                          - [CONCOORD 1.2 Source](concoord_1.2.tgz)- [CONCOORD 1.2 binary distrubution for
                                              SGI](concoord_sgi.tgz)- [CONCOORD 1.2 binary distrubution for
                                                Linux/i386](concoord_lnx.tgz)- [CONCOORD 1.2 binary distrubution for
                                                  DEC/alpha](concoord_dec.tgz)

                                                  (C) Bert de Groot, 1996-2010

                                                  Please note that the software is distributed with NO WARRANTY OF ANY KIND. The author is not responsible for any losses or damages suffered directly or indirectly from the use of the software. Use it at your own risk.

                                                  Please send your bug reports, comments and suggestions to:
                                                  bgroot@gwdg.de.

                                                  Enjoy!