| 1.6. Post-installation of EMBOSS | | |
| --- | --- | --- |
| [Prev](ch01s05.html) | Chapter 1. Building EMBOSS | [Next](ch01s07.html) |

---

## 1.6. Post-installation of EMBOSS

The most important post-installation step is to set your operating system environment so that it knows where to find the EMBOSS applications. Assuming that you followed our suggestion and configured EMBOSS using **`--prefix=/usr/local/emboss`** then you need to add the directory `/usr/local/emboss/bin` to your `PATH`. How to do this will depend on your operating system and the command shell you use. You can find out which shell you are using by typing:

|  |
| --- |
| **`env | grep SHELL`** |

For users of the `sh` or `bash` shells (or derivatives) the `PATH` is altered using the following lines.

```
PATH="$PATH:/usr/local/emboss/bin"
export PATH
```

If you want to make these definitions available for all users then you would typically add the lines to the system `/etc/profile` file. If you just want to use EMBOSS yourself then you can add the lines to (e.g.) the `.bashrc` file in your home directory.

For users of `csh` or `tcsh` shells the `PATH` is altered using the following line.

```
set path=($path /usr/local/emboss/bin)
```

If you want to make these definitions available for all users then you would typically add the lines to the system `/etc/csh.cshrc` file. If you just want to use EMBOSS yourself then you can add the line to (e.g.) the `.cshrc` file in your home directory.

### Note

You may have to log out and log back in again for the changes to your `PATH` to take effect.

### 1.6.1. Testing the EMBOSS Installation

An easy way to check that all is working is to use the EMBOSS application **[embossversion](http://emboss.open-bio.org/rel/dev/apps/embossversion.html)**.

```
% embossversion
Writes the current EMBOSS version number
6.1.0
```

If the version number of EMBOSS is not printed similarly to the above then all is not well; if it is printed then celebrate appropriately.

#### 1.6.1.1. Common Errors During Testing

The most common error is `Command not found` whenever you type in an EMBOSS application name. This is caused by incorrectly setting up the `PATH` (see above). Double-check that you set up the `PATH` correctly and, if necessary, take advice from someone familiar with the operating system you're using.

The second most common error is a report by the program that it cannot find the `libnucleus` library. This is one of the EMBOSS libraries and, if you followed our suggestion, it will be found in the `/usr/local/emboss/lib` directory after the installation phase. As long as you have set up your `PATH` correctly then EMBOSS should always be able to find its libraries. It has, however, been reported that some systems (notably SuSE Linux variants) have problems. In this case there are a few solutions.

1. With [Open]SuSE this error often happens if you have not specified a **`--prefix`** option or have otherwise installed EMBOSS at the root of the `/usr/local` directory tree such that the EMBOSS libraries are in the `/usr/local/lib` directory. [Open]SuSE maintains a cache of the contents of that directory which you will need to rebuild by typing as the superuser:

   |  |
   | --- |
   | **`ldconfig`** |

   Do this also for other operating systems that maintain such a cache. If the error happens on other operating systems or distributions then you could do one of the following:

   * Add the path to the EMBOSS libraries to the `LD_LIBRARY_PATH` environment variable. For example:

     |  |
     | --- |
     | **`LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/fu/bar/lib"`** |
     | **`export LD_LIBRARY_PATH`** |
   * Or, for `csh` shells:

     |  |
     | --- |
     | **`setenv LD_LIBRARY_PATH "$LD_LIBRARY_PATH:/fu/bar/lib"`** |
2. Add the path to the EMBOSS libraries system-wide. This is perhaps the preferable way. For example, under Linux you could add the following line to the `/etc/ld.so.conf` file:

   ```
   /fu/bar/lib
   ```

   and then type:

   |  |
   | --- |
   | **`ldconfig`** |

   For other operating systems, check the manual pages to see how to do the equivalent operations.

### 1.6.2. Post-installation of Data Files

If you wish to use the restriction mapping, domain recognition and amino acid index applications in EMBOSS then you will need to download the following databases from the Internet; all are relatively small. Download them all to a temporary directory.

#### 1.6.2.1. REBASE

This is available from *ftp://ftp.neb.com/pub/rebase/*

You need the `withrefm` and `proto` files from that directory. A common error is to download the `withref` file by mistake - it must be the `withrefm` file. The file extensions for these files change on the server every month to reflect the date.

Then type:

|  |
| --- |
| **`rebaseextract`** |

and follow the prompts.

#### 1.6.2.2. AAINDEX

This is available from *ftp://ftp.genome.ad.jp/pub/db/community/aaindex/*

You need the `aaindex1` file from that directory.

Then type:

|  |
| --- |
| **`aaindexextract`** |

and follow the prompts.

#### 1.6.2.3. PRINTS

This is available from *ftp://ftp.ebi.ac.uk/pub/databases/prints/*

You need the `prints.dat` file from that directory.

Then type:

|  |
| --- |
| **`printsextract`** |

and follow the prompts.

#### 1.6.2.4. PROSITE

This is available from *ftp://ftp.ebi.ac.uk/pub/databases/prosite/release/*

You need the `prosite.dat` and the `prosite.doc` files from that directory

Then type:

|  |
| --- |
| **`prosextract`** |

and follow the prompts.

You can now delete the data files you downloaded.

#### 1.6.2.5. JASPAR

This is available from *<http://jaspar.genereg.net/html/DOWNLOAD/>*

You need the `Archive.zip` file. Uncompress it and then run:

|  |
| --- |
| jaspextract |

and specify the `all_data/FlatFileDir` directory in response to the prompt. You can now delete the source directory contents.

### 1.6.3. Deleting the EMBOSS Package

If you followed our advice and gave a **`--prefix`** option to the **`configure`** command, thereby specifying a directory where EMBOSS alone would be installed, then there are two methods for deleting EMBOSS.

1. If you've kept the source code tree from which you'd done the **`make install`**.

   In this case, deleting the installation is easy. Just type:

   |  |
   | --- |
   | **`make uninstall`** |

   This has the advantage that it will delete EMBOSS but will not delete any configuration files you have spent ages developing for your system. This is useful if you wish to reinstall a new version of EMBOSS after the deletion.
2. If you didn't keep the source code tree.

   As long as you specified a suitable **`--prefix`** option to the **`configure`** command then you can use a UNIX **`rm -rf directoryname`** command to delete the EMBOSS installation tree.

   If you didn't specify a **`--prefix`** option to the **`configure`** command but did do a **`make install`** then you'll have to clean EMBOSS out of the `/usr/local` directory tree manually or, better, reinstall the same version of EMBOSS on top of itself and then use the **`make uninstall`** method.

### 1.6.4. Keeping EMBOSS Up To Date

From time to time, bugfixes or new functionalities are provided, which can be applied to the version of EMBOSS you have installed. At such times new source code files will appear on our FTP server in the directory:

*ftp://emboss.open-bio.org/pub/EMBOSS/fixes/*

Usually these source code files are replacements for files that came with the EMBOSS distribution. You should read the `README.fixes` file in the above directory to see what the file fixes and whereabouts in the EMBOSS source directory it lives.

To apply the fixes, copy the source code file to its correct location, return to the top level of your EMBOSS source code tree and type:

|  |
| --- |
| **`make clean`** |
| **`make install`** |

This is, of course, another very good reason for not deleting your EMBOSS source code tree.

A more convenient way of applying all the fixes from the above directory is to use the patch file in the subdirectory:

*ftp://emboss.open-bio.org/pub/EMBOSS/fixes/patches/*

The patch files are of the form `patch-1-n.gz` where *`n`* refers to the latest source code correction in the `README.fixes` file in the directory above. So, if there are ten corrections in the latter file then the patch file would be called `patch-1-10.gz`.

The patch files are applied using the UNIX **`patch`** command e.g.:

|  |
| --- |
| **`gunzip EMBOSS-6.1.0.tar.gz`** |
| **`tar xf EMBOSS-6.1.0.tar`** |
| **`cd EMBOSS-6.1.0`** |
| **`gunzip -c patch-1-10.gz | patch -p1`** |

Or, if the file has been uncompressed in transit:

|  |
| --- |
| **`patch -p1 < patch-1-10`** |

You should always start with freshly extracted EMBOSS source code, as above, before applying a patch. This allows you to see any errors more easily. On rare occasions the developers will provide a patch file that contains fixes to a binary file. Some operating systems (e.g. FreeBSD) cannot handle binary patches and will report that such a patch file is malformed. In those circumstances follow the instructions in the `nonbinary` directory.

### 1.6.5. Installing a New Version of EMBOSS

A new version of EMBOSS is released at least once per year, typically on St Swithun's Day (15th July). Before installing the new version you should either delete the existing EMBOSS version (if installing to the same directory) or install EMBOSS in a new location. Do not install a new version of EMBOSS on top of an existing installation as files from previous versions may cause compatibility problems.

### Note

If you changed any system library or execution paths when you first installed EMBOSS then make sure you update these as necessary. A new version of EMBOSS is unlikely to work if new executables are trying to access older versions of the EMBOSS libraries.

### 1.6.6. EMBOSS Configuration Files

EMBOSS includes two files that are used to configure the package, particularly for defining databases and for making global settings that influence the behaviour of all EMBOSS programs.

The file `emboss.default` is used for site-wide configuration. Template files are included:

|  |
| --- |
| Stable release (`.../share/EMBOSS/emboss.default.template`) |
| CVS releases (`.../emboss/emboss/emboss.default.template`) |

The file `.embossrc`, which you can create in your personal home directory, is used for user-specific customisation. Typically you might test, for example, database definitions in your own `~/.embossrc` file before adding them to `emboss.default`.

#### 1.6.6.1. Syntax of `emboss.default` and `.embossrc` Files

##### 1.6.6.1.1. Blank lines and comments

Blank lines are ignored. Comments start with a '`#`' character in the first position of a line. For example:

```
# this is a comment
```

##### 1.6.6.1.2. Includes

`INCLUDE` allows you to include a subsidiary file as part of the text of the main `emboss.default` or `.embossrc` file at the position of the `INCLUDE` command. This is useful for keeping the configuration files tidy. For example, to include the contents of the file `project_databases.def`:

```
INCLUDE "project_databases.def"
```

##### 1.6.6.1.3. Variable definitions

Variables may be set with the keyword `SETENV`, (usually shortened to `SET` or `ENV` - either is ok), followed by the variable name, then the value to which you wish it set. For example:

```
SET dbdir /data/sequencedbs
```

This variable may now be used in the rest of the file `emboss.default` by preceding it with a `$`. For example:

```
file: $dbdir/data.dat
```

The name of the variable is case-insensitive when used within `emboss.default` or `.embossrc`.

#### 1.6.6.2. Configuring EMBOSS for Different Groups of Users

When maintaining EMBOSS for multiple users, more than one configuration might be required, for example to provide access to different sets of databases or data directories. It can be time consuming and error prone to maintain a series of individual `.embossrc` files in each user directory, or to force users to work in the same directory.

An alternative is to maintain one central copy of each of the different configuration files (`.embossrc`) in its own directory. All the user then need do is set the environment variable `EMBOSSRC` in their `.cshrc` (`csh`) or `.profile` (`bash`) file to point to the appropriate directory.

### 1.6.7. EMBOSS Environment Variables

### Caution

It is possible to make EMBOSS unusable if you adjust the global variables. For example:

```
SET EMBOSS_HELP 1
```

will make all EMBOSS programs only display their help when they are run.

Table 1.1. Environment variables

| Environment Variable | Description | Type | Default value |
| `EMBOSS_ACDCOMMANDLINELOG` | Log file for full commandline, used to convert QA test definitions into memory leak test command lines | `string` | `""` |
| `EMBOSS_ACDFILENAME` | Use filename rather than sequence name as default for file naming | `boolean` | `N` |
| `EMBOSS_ACDLOG` | Log ACD processing to file program.acdlog to debug ACD processing | `boolean` | `N` |
| `EMBOSS_ACDPROMPTS` | Number of times to prompt for a value interactively | `integer` | `1` |
| `EMBOSS_ACDROOT` | EMBOSS root directory for finding files | `string` | `(install directory)` |
| `EMBOSS_ACDUTILROOT` | EMBOSS source directory for finding files | `string` | `(source directory)` |
| `EMBOSS_ACDWARNRANGE` | Warn if a number is out of range and fixed to be within limits | `boolean` | `N` |
| `EMBOSS_AUTO` | Run with all default values unless -noauto is on the command line | `boolean` | `N` |
| `EMBOSS_CACHESIZE` | Cache size to use for database indexing | `integer` | `2048` |
| `EMBOSS_DATA` | EMBOSS directory for finding data files | `string` | `(install directory)` |
| `EMBOSS_DEBUG` | Write debug output to program.dbg unless -nodebug is on the command line | `boolean` | `N` |
| `EMBOSS_DEBUGBUFFER` | Buffer debug output to save I/O time but risk losing output on a crash | `boolean` | `N` |
| `EMBOSS_DIE` | Print program abort messages to standard error | `boolean` | `Y` |
| `EMBOSS_DOCROOT` | EMBOSS directory for finding application documentation | `string` | `(install directory)` |
| `EMBOSS_EMBOSSRC` | Directory to search for an additional .embossrc file | `string` | `(current directory)` |
| `EMBOSS_FEATWARN` | Print warning messages when parsing feature table input | `boolean` | `Y` |
| `EMBOSS_FILTER` | By default read standard input and write to standard output unless -nofilter is on the command line | `boolean` | `Y` |
| `EMBOSS_FORMAT` | Input sequence format | `string` | `unknown` |
| `EMBOSS_GRAPHICS` | Default graphics output device | `string` | `x11` |
| `EMBOSS_HOMERC` | Read the .embossrc file in the user's home directory | `boolean` | `Y` |
| `EMBOSS_HTTPVERSION` | HTTP version | `string` | `1.1` |
| `EMBOSS_LANGUAGE` | (Obsolete) Language used for the codes.language file | `string` | `english` |
| `EMBOSS_LOGFILE` | S