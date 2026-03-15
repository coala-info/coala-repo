[![HMMER](images/hmmer_title.png)

# HMMER](/)

* [Download](download.html)
* Documentation
* [Search](http://www.ebi.ac.uk/Tools/hmmer/)
* [Blog](http://cryptogenomicon.org/)

### Documentation:

* [HMMER User's Guide [PDF]](http://eddylab.org/software/hmmer/Userguide.pdf)

### Easiest way to install HMMER is with your favorite packager for your system:

```
  % brew install hmmer               # OS/X, HomeBrew
  % port install hmmer               # OS/X, MacPorts
  % apt install hmmer                # Linux (Ubuntu, Debian...)
  % dnf install hmmer                # Linux (Fedora)
  % yum install hmmer                # Linux (older Fedora)
  % conda install -c biocore hmmer   # Anaconda
```

Thanks to all the people who do the packaging! What with the ubiquity of these packages, I no longer distribute
precompiled executables.

### Alternatively, briefly, to obtain and compile from source:

```
  % wget http://eddylab.org/software/hmmer/hmmer.tar.gz
  % tar zxf hmmer.tar.gz
  % cd hmmer-3.4
  % ./configure --prefix /your/install/path
  % make
  % make check
  % make install
  % (cd easel; make install)
```

The 'make check' is optional. It runs a test suite that checks for errors in the software.

The 'make install' is optional too. It installs programs in '/your/install/path/bin/'
and manual pages in '/your/install/path/share/man/man1'. If you don't provide a
'--prefix' to './configure' to specify the installation path, the default
is '/usr/local'.

The 'make install' in Easel installs a set of other small tools and their man pages.
We don't make this part of the HMMER 'make install' because Easel is part of other packages
(Infernal, for example) and you might have already installed Easel tools.

We believe HMMER compiles and runs on any POSIX-compliant system
with an ANSI C99 compiler, including Mac OS/X, Linux, and any UNIX operating systems,
provided it supports SSE2, ARM NEON, or big-endian Altivec/VMX vector instructions.
This includes essentially all Intel/AMD compatible machines, Apple OS/X Intel or ARM machines, and some PowerPC machines.
For more installation and configuration options, see the **Installation**
chapter of the [User Guide](http://eddylab.org/software/hmmer/Userguide.pdf) (included in the package).

### Further Reading

#### Blog:

See the blog [Cryptogenomicon](http://cryptogenomicon.org/) for more information and discussion about HMMER3.

#### Papers:

* Eddy SR. Accelerated profile HMM searches. PLoS Comput Biol. 7:e1002195 (2011)
* Eddy SR. A probabilistic model of local sequence alignment that simplifies statistical significance estimation. PLoS Comput. Biol. 4:e1000069 (2008)
* Eddy SR. A new generation of homology search tools based on probabilistic inference. Genome Inform. 23:205-11 (2009).

#### Book:

The theory behind profile HMMs:
R. Durbin, S. Eddy, A. Krogh, and G. Mitchison,
[*Biological sequence analysis: probabilistic models of proteins
and nucleic acids*](http://eddylab.org/cupbook.html),
Cambridge University Press, 1998.

### Support

Because we're an academic research group, HMMER
comes with no promise of support. We are generally not able
to respond individually to requests for help with the package, beyond
the help already provided in HMMER's documentation. We do appreciate
suggestions for better documentation, improvements, and bug reports.

### Reporting bugs

Email sean@eddylab.org
and please provide me with enough information that I can recreate the problem.
Useful things to include are:

* Input data (or examples, a small test case sufficient to recreate the problem).
* Information about the operating system you are using (e.g.  `cat /proc/cpuinfo`  or  `uname -a`
* Which version of HMMER you're using, and whether you compiled from source or used a binary distro.

Without these pieces of information I have to make guesses and send mails back and forth with you to determine the cause
of the issue, and then I get all frustrated and snippy with you because I'm usually pretty busy, and then you think I'm a jerk, and then I feel guilty and bad and have to go away and go running. Nobody wants all that drama.

Also, many questions are already covered in the [HMMER documentation](http://eddylab.org/software/hmmer/Userguide.pdf),
so it may be worth browsing there first before sending an e-mail.