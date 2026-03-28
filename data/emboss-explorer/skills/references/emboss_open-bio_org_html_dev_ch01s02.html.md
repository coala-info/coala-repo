| 1.2. Installation of CVS (Developers) Release | | |
| --- | --- | --- |
| [Prev](ch01s01.html) | Chapter 1. Getting Started | [Next](ch01s03.html) |

---

## 1.2. Installation of CVS (Developers) Release

Only very basic information on EMBOSS installation is included here. For complete instructions see the *EMBOSS Administrators Guide*. The basic installation steps are:

1. Download the EMBOSS source code.
2. Configure EMBOSS ahead of compilation. The stable release contains a 'configure' script for this whereas the Developers (CVS) version contains the files necessary to create this script.
3. Compile EMBOSS. This will generate the executable files from the application source code.
4. Set a `PATH` to the executables.
5. Test the installation.
6. Database setup.

### Caution

To configure and compile EMBOSS the following GNU configuration tools must be installed on your system:

* **autoconf**
* **automake**
* **libtool**

Your OS will often provide these packages, if not then they can be downloaded as source code and installed (in the order shown above and making sure that each newly-installed package is being found, in preference to any older version, before installing the next) after visiting *ftp://ftp.gnu.org/gnu/*.

You may hit other software dependencies if, for example, you are developing graphics software: see the *EMBOSS Administrators Guide* for more information.

### 1.2.1. Downloading via CVS

To download via CVS you must have **[cvs](http://www.cyclic.com/)** installed on your system. It is there if an application is listed after typing:

|  |
| --- |
| **`which cvs`** |

You must also use the secure shell `SSH` for the file transfer. Depending on your shell, type one of the following:

|  |
| --- |
| **`setenv CVS_RSH ssh`** |
| **`declare -x CVS_RSH=ssh`** |
| **`export CVS_RSH=ssh`** |

To checkout the EMBOSS source code tree, go to the directory where you want the top-level EMBOSS directory created. For example to create EMBOSS in `/home/auser/src/` you'd type:

|  |
| --- |
| **`cd /home/auser/src`** |

To checkout EMBOSS you must first logon to the `open-bio.org` CVS server by typing:

|  |
| --- |
| **`cvs -d :pserver:cvs@cvs.open-bio.org:/home/repository/emboss login`** |

You will be prompted for a password which is `cvs`. You are now logged on to the CVS server. Checkout (download) EMBOSS by typing:

|  |
| --- |
| **`cvs -d :pserver:cvs@cvs.open-bio.org:/home/repository/emboss checkout emboss`** |

This will take some time as it's downloading several megabytes of source code and data from the USA. Once the download is complete, terminate your CVS session with:

|  |
| --- |
| **`cvs -d :pserver:cvs@cvs.open-bio.org:/home/repository/emboss logout`** |

Here is a typical CVS session:

```
% declare -x CVS_RSH=ssh
% cvs -d :pserver:cvs@cvs.open-bio.org:/home/repository/emboss login
Logging in to :pserver:cvs@cvs.open-bio.org:2401/home/repository/emboss
CVS password:
% cvs -d :pserver:cvs@cvs.open-bio.org:/home/repository/emboss checkout emboss
cvs checkout: Updating emboss
cvs checkout: Updating emboss/emboss
U emboss/emboss/AUTHORS
U emboss/emboss/COMPAT
U emboss/emboss/COPYING
U emboss/emboss/ChangeLog
.
...  screen output truncated
.
%
% cvs -d :pserver:cvs@cvs.open-bio.org:/home/repository/emboss logout
Logging out of :pserver:cvs@cvs.open-bio.org:2401/home/repository/emboss
%
% ls
emboss
```

### 1.2.2. Keeping up-to-date with CVS

Once you've downloaded the CVS version of EMBOSS, you should keep up-to-date with the latest changes. To do this, move to the directory which you wish to update (or the root emboss directory to update everything) and type:

|  |
| --- |
| **`cvs -d :pserver:cvs@cvs.open-bio.org:/home/repository/emboss update`** |

Bear in mind that if you have edited any files then those edits will be merged with the version downloaded via CVS. Therefore if you wish to conserve your edits in their original form, you should copy the edited files to a safe place first.

### 1.2.3. Configuration

You must first build the script and other files used to configure the package. From the second-level EMBOSS directory (e.g. `/home/auser/emboss/emboss`) type:

|  |
| --- |
| **`aclocal -I m4`** |
| **`autoconf`** |
| **`automake -a`** |

**aclocal** is part of the **automake** package. These commands build the "configure" script from the file `configure.in` (in the EMBOSS distribution) and various other files needed for installation. Specifically:

* **`aclocal`** creates `aclocal.m4` containing m4 macros used by the **auto\*** tools.
* **`autoconf`** reads `configure.in` and creates the "configure" script.
* **`automake`** reads `Makefile.am` and creates `Makefile.in`

If you experience any errors at that stage it is possible that your GNU configuration tools are out of date, if so then update them. It is also possible that your version of **libtool** is more recent than that used in the current EMBOSS CVS; you can check that by looking at the version number in the `ltmain.sh` file at the top source level of the checked-out tree. If your installed version of **libtool** is newer then you may have to type **`autoreconf -fi`** and then retype the previous GNU configuration tool commands. **`autoreconf`** is part of the **autoconf** package.

Running the resulting **`./configure`** will

* Check whether your system has the necessary functionality and libraries to compile EMBOSS.
* Read `Makefile.in` and generate platform-specific Makefiles (used later).
* Configures your system. For example, the installation path and various system variables are set and files are flagged to compile (or not).

**`./configure`** is controlled by command line arguments and by environment variables. Command line arguments are generally used to switch on features **autoconf** was unable to detect. Environment variables are generally used to set build information such as compiler options.

If you intend to compile using **`make install`** (see below) you must specify an installation area for the executables and supporting files. It is good practice to specify these even if you intend to compile with a plain **`make`**. To do this, type:

**`./configure --prefix=/home/auser/emboss`**

Further, if you are using the **gcc** compiler it's a good idea to turn warnings on (most EMBOSS warnings are bad errors). You can do this while setting the installation areas:

|  |
| --- |
| **`./configure --prefix=/home/auser/emboss --enable-warnings`** |

You can also turn on more strict developer warnings by typing:

|  |
| --- |
| **`./configure --prefix=/home/auser/emboss --enable-warnings --enable-devwarnings`** |

There is a further configuration switch, **`--enable-devextrawarnings`**, which turns on some rather pedantic warnings which are nonetheless useful in some rare circumstances. As that switch can produce compilation noise it is not recommended to specify it in general use.

### Important

Note that the warnings switches, such as **`--enable-warnings`**, are for GCC compilers only.

### Caution

To support the Portable Network Graphics (PNG) format, EMBOSS requires the **libgd**, **libpng** and **libz** libraries. On many Linux systems, most support libraries are installed under the directories `/usr/` and `/lib`. For example, `/lib`, `/usr/lib`, `/usr/X11R6/lib` etc. Whereas Linux distributions include RPMs for these libraries, other operating systems do not.

If you are installing these libraries and include files in somewhere other than `/usr` then you must specify their location when configuring. Assuming you have installed them under `/usr/local` (e.g. `/usr/local/lib` and `/usr/local/include`) you would add the following switch to the configuration command line:

|  |
| --- |
| **`--with-pngdriver=/usr/local`** |

For more info on the configurability of the build type:

|  |
| --- |
| **`./configure --help`** |

### 1.2.4. Compilation

To compile EMBOSS, type:

|  |
| --- |
| **`make`** |

This will, by using the `Makefile`s, compile all the source files into executable binaries within your chosen checked-out location e.g.:

|  |
| --- |
| `/home/auser/emboss/emboss/emboss` |

Alternatively, compiling with:

|  |
| --- |
| **`make install`** |

will install the binaries and supporting files into `bin`, `lib` and `share` subdirectories of the directory you specified using **`--prefix`** on the configure line. In the example above, this is the top-level emboss directory level from the CVS checkout, e.g.:

|  |
| --- |
| `/home/auser/emboss` |

Had you not specified **`--prefix=/home/auser/emboss`** they'd be installed to `/usr/local` by default (that isn't recommended).

If you want EMBOSS installed in somewhere other than `/usr/local` then use the **`--prefix`** option of GNU configure to specify the EMBOSS installation directory. This is the recommended method of installation as EMBOSS has hundreds of files which might otherwise obscure other software, particularly under `/usr/local/bin`.

To compile and reinstall EMBOSS on subsequent occasions, use the following commands:

|  |
| --- |
| **`make clean`** |
| **`./configure`** |
| **`make`** |
| **`make install`** |

Though extremely rare, there are circumstances where you may have to type **`rm config.cache`** (on very old installations) or **`rm -rf autom4te.cache`** before doing the above. Those occasions generally happen when trying to update a rather old existing version of EMBOSS.

#### 1.2.4.1. Static and Dynamic Compilation

### Note

A static library (statically-linked library) is a library in which links to external functions and variables are resolved at compile-time by a linker. Static libraries are either merged together with object files during building/linking into a single executable, or are loaded at run-time and are accessible to the executable.

A dynamic library (dynamically-linked library) in contrast implements dynamic linking, where libraries remain in separate files on disk and are not copied into a new executable or library at compile time.

Executables created using static libraries are larger than executables linked to dynamic libraries, because static libraries include the code for the library function(s) within the executable. Static libraries, however, can be useful for debugging purposes and sometimes result in faster executables than when using dynamic libraries.

The above commands would create a dynamically linked EMBOSS. To create a statically linked EMBOSS you would use:

|  |
| --- |
| **`./configure --disable-shared`** |

##### 1.2.4.1.1. Static Compilation via Script

There is a script available to compile EMBOSS if you require a statically linked EMBOSS, simply type:

|  |
| --- |
| **`source make-static-developers`** |

or

|  |
| --- |
| **`. make-static-developers`** |

depending on your shell.

This invokes the following commands:

|  |
| --- |
| **`aclocal -I m4`** |
| **`autoconf`** |
| **`automake -a`** |
| **`./configure --enable-warnings --disable-shared --enable-debug`** |
| **`make`** |

### 1.2.5. Setting your `PATH`

### Note

Your `PATH` is an environment variable that defines a list of directories that the operating system searches to find executable applications in response to a Unix command. For example, when you type a command such as **`cd`** or **`ls`** the invoked application is (typically) `/bin/cd` or `/bin/ls`. Most Unix installations will have put the directory `/bin` in your `PATH` automatically. For EMBOSS, you will likely have to manually set the `PATH` to point to the executables.

You must set the path to the executable applications. Assuming EMBOSS was installed in your home directory and you are using a `csh` style shell then type the following commands (replace the path as required):

|  |
| --- |
| **`set path=(/home/auser/emboss/emboss/emboss $path)`** |
| **`rehash`** |

Or if you are using an `sh` style shell then type the following commands:

|  |
| --- |
| **`export PATH=/home/auser/emboss/emboss/emboss:$PATH`** |

If, however, you installed using **`make install`** rather than just a **`make`** then the commands will be different (you must set the `PATH` to where you installed the executables). For a `csh` style shell:

|  |
| --- |
| **`set path=(/home/auser/emboss/bin $path)`** |
| **`rehash`** |

For a `sh` style shell:

|  |
| --- |
| **`export PATH=/home/auser/emboss/bin:$PATH`** |

### 1.2.6. Testing all is Well

To test all is well with your installation you can run:

|  |
| --- |
| **`embossversion`** |

and check that you get the EMBOSS version number reported.

You could also try using the **[seqret](http://emboss.open-bio.org/rel/dev/apps/seqret.html)** application to retrieve some sequences from the test databases that come bundled with the EMBOSS distribution. Before you can do this however you need to set up the databases for use with EMBOSS.

### 1.2.7. Database Setup

Database setup is covered in the *EMBOSS Administrators Guide*); only the bare essentials are covered below.

The EMBOSS distribution comes bundled with some test databases. They are, for example, located in:

|  |
| --- |
| `/home/auser/emboss/emboss/test` |

Any database you want to use must be defined in one of the files:

* `.embossrc` (in your home directory)
* `emboss.default` (in the top-level emboss directory, e.g. `/home/auser/emboss/emboss.default`)

These files are used to configure EMBOSS. `.embossrc` is for personal configuration whereas `emboss.default` is used for site-wide configuration. A template file is included in the CVS releases (`.../emboss/emboss/emboss.default.template`). For now, create a file called `.embossrc` in your home directory with the following contents (you'll need to change the paths to the test directories):

```
DB embl
[
type: N
method: direct
format: embl
dir: /home/auser/workspace/emboss/emboss/test/embl/
file: *.dat
comment: "EMBL sequences"
]

DB swissprot
[
type: P
method: direct
format: swiss
dir: /home/auser/workspace/emboss/emboss/test/swiss/
file: seq.dat
comment: "Swissprot sequences"
]
```

Having set up your databases, issue the following commands (and accept the default values at the prompts):

|  |
| --- |
| **`seqret embl:x65923`** |
| **`more x65923.fasta`** |
| **`seqret swissprot:UBR5_RAT`** |
| **`more UBR5_RAT`** |

If you get output similar to the following then you can rest assured that the installation went well.

```
% seqret embl:x65923
Reads and writes (returns) sequences
Output sequence [x65923.fasta]:

% more x65923.fasta
>X65923 X65923.1 H.sapiens fau mRNA
ttcctctttctcgactccatcttcgcggtagctgggaccgccgttcagtcgccaatatgc
agctctttgtccgcgcccaggagctacacaccttcgaggtgaccggccaggaaacggtcg
cccagatcaaggctcatgtagcctcactggagggcattgccccggaagatcaagtcgtgc
tcctggcaggcgcgcccctggaggatgaggccactctgggccagtgcggggtggaggccc
tgactaccctggaagtagcaggccgcatgcttggaggtaaagttcatggttccctggccc
gtgctggaaaagtgagaggtcagactcctaaggtggccaaacaggagaagaagaagaaga
agacaggtcgggctaagcggcggatgcagtacaaccggcgctttgtcaacgttgtgccca
cctttggcaagaagaagggccccaatgccaactcttaagtcttttgtaattctg