[Home](/)
[News](/news/)
[Install](/install)
[Features](/features)
[Documentation](/docs/2.11/)
[FAQ](/faq)
[Gallery](/gallery)
[Community](/community)
[Who is Using It?](/users)
[Cite Us](/cite-us)
[ProMod3](/promod3/3.5/)

|  |  |
| --- | --- |
| Frequently Asked QuestionsCan I use OpenStructure modules from python? That's definitely possible, provided you have set the proper environment variables. You need to set PYTHONPATH to the directory containing the python modules. For a 64 bit platform with Python 3.10, this would look like:  ``` export PYTHONPATH="/path/to/ost/stage/lib64/python3.10/site-packages/:$PYTHONPATH" ```  Adjust the python version to match the one you are using.  In python, you can now import the ost module:  ``` import ost ``` How do I load a crappy PDB file? The easiest way is to use the fault\_tolerant option of LoadPDB. If you set the value to true, it will load the structure and just skip erroneus records:  ``` ent=io.LoadPDB('pdb_with_errors.pdb', fault_tolerant=True) ``` How do I load all PDB files in a directory? The python glob module can be used to match files in a certain directory against a glob pattern. Then use LoadPDB as you normally would.  ``` import glob pdbs=[] for pdb_file in glob.glob(os.path.join(dir_path, '*.pdb')):   pdbs.append(io.LoadPDB(os.path.join(dir_path, pdb_file))) ``` Where Do I Get Help? First, search the documentation on the [website](http://www.openstructure.org/docs/). If you don't find the answer you were looking for, you may want to ask on the [users mailing list](http://www.openstructure.org/community/). Please make sure to read the [posting guidelines](http://openstructure.org/docs/users/) first. Which licensing does Openstructure come with? Openstructure is released under GNU-LGPL license Which software libraries does Openstructure depend on? Openstructure depends on the following software libraries to implement its functionality:   * [Qt](http://qt.nokia.com/) - Nokia Corp. * [PyQt](http://www.riverbankcomputing.co.uk/software/pyqt/intro) - Riverbank Computing Ltd. * [Boost C++ Libraries](http://www.boost.org) * [Eigen](http://eigen.tuxfamily.org/index.php?title=Main_Page) * [FFTW](http://www.fftw.org)  Why another molecular Viewer? Openstructure is not aiming to be a Viewer, but more a computational structural biology framework, a toolkit. It features nice graphics, though! | * [Can I use OpenStructure modules from python?](#can-i-use-openstructure-modules-python) * [How do I load a crappy PDB file?](#how-do-i-load-a-crappy-pdb) * [How do I load all PDB files in a directory?](#load-all-pdb-files-in-directory) * [Where Do I Get Help?](#where-do-i-get-help) * [Which licensing does Openstructure come with?](#which-licensing-does-openstructure-come-with) * [Which software libraries does Openstructure depend on?](#which-software-libraries-does-openstructure-depend) * [Why another molecular Viewer?](#why-another-molecular-viewer) |

Copyright 2008-2026 by the OpenStructure authors