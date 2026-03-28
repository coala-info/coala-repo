[**Skip to main text**](#content)

[Free Software Supporter](//www.fsf.org/fss):

[JOIN THE FSF](https://www.fsf.org/associate/support_freedom?referrer=4052)

[![ [A GNU head] ](/graphics/heckert_gnu.transp.small.png)**GNU** Operating System](/)
Supported by the
[Free Software Foundation](#mission-statement)

[![ [Search www.gnu.org] ](/graphics/icons/search.png)](//www.gnu.org/cgi-bin/estseek.cgi)

[Site navigation](#navigation "More...")
[**Skip**](#content)

* [ABOUT GNU](/gnu/gnu.html)
* [PHILOSOPHY](/philosophy/philosophy.html)
* [LICENSES](/licenses/licenses.html)
* [EDUCATION](/education/education.html)
* =
  [SOFTWARE](/software/software.html)

  =
* [DISTROS](/distros/distros.html)
* [DOCS](/doc/doc.html)
* [MALWARE](/proprietary/proprietary.html)
* [HELP GNU](/help/help.html)
* [AUDIO & VIDEO](/audio-video/audio-video.html)
* [GNU ART](/graphics/graphics.html)
* [FUN](/fun/humor.html)
* [GNU'S WHO?](/people/people.html)
* [SOFTWARE DIRECTORY](//directory.fsf.org)
* [HARDWARE](https://h-node.org/)
* [SITEMAP](/server/sitemap.html)

## Coreutils - rejected feature requests

---

Some of the hardest work on coreutils is knowing what to reject and
providing appropriate justification to the contributors.

The contributions below while all good ideas, were not included for various reasons
detailed on the linked mailing list discussions.

[cat](#cat)
[chmod](#chmod)
[cp](#cp)
[cut](#cut)
[date](#date)
[dd](#dd)
[df](#df)
[du](#du)
[join](#join)
[ls](#ls)
[mv](#mv)
[rm](#rm)
[shred](#shred)
[sort](#sort)
[stat](#stat)
[\*sum](#checksum)
[touch](#touch)
[uniq](#uniq)
[wc](#wc)
[misc](#misc)
[New commands](#new)

### cat

* [cat --timestamp](https://lists.gnu.org/archive/html/coreutils/2011-03/msg00002.html). awk or perl is good enough for this
* [cat -n alternate formats](https://lists.gnu.org/archive/html/coreutils/2012-01/msg00002.html).
  Manipulation with existing tools supports this better
* [cat --show-ends](https://lists.gnu.org/archive/html/coreutils/2013-02/msg00055.html) to highlight trailing whitespace. grep --color was deemed better/sufficient
* [cat --header](https://lists.gnu.org/archive/html/coreutils/2013-05/msg00015.html) to output filenames for each file. tail -n+1 does this already
* [cat -S](https://lists.gnu.org/archive/html/coreutils/2013-09/msg00005.html) to squeeze lines just containing blank chars. Existing tools like `sed 's/^ \*$//' | cat -s` were thought sufficient
* [cat -d,--direct](https://lists.gnu.org/archive/html/bug-coreutils/2013-10/msg00011.html) to use direct I/O. dd has the 'nocache' or 'direct' options and there are general [nocache](https://github.com/Feh/nocache) wrappers

### chmod

* [chmod maintains ctime](https://lists.gnu.org/archive/html/bug-coreutils/2010-01/msg00303.html) when permissions unchanged. The
  proposed patch was deemed [inefficient](https://lists.gnu.org/archive/html/bug-coreutils/2010-02/msg00208.html)
* [chmod -d](https://lists.gnu.org/archive/html/bug-coreutils/2010-02/msg00201.html) to set perms on just directories.
  The 'X' mode, or `find` with `chmod` was deemed sufficient
* [chmod +S](https://lists.gnu.org/archive/html/bug-coreutils/2010-04/msg00008.html) to set setgid on just directories. `find` in combination with `chmod` was deemed sufficient
* [chmod -D](https://lists.gnu.org/archive/html/bug-coreutils/2011-05/msg00047.html) to set perms on just directories.
  The 'X' mode, or `find` with `chmod` was deemed sufficient
* [chmod --parents](https://debbugs.gnu.org/cgi/bugreport.cgi?bug=8736). Doing this with a simple script or with find was deemed sufficient
* [chmod --umask](https://lists.gnu.org/archive/html/bug-coreutils/2012-03/msg00080.html). The existing chmod options were deemed sufficient
* [chmod b10111](https://lists.gnu.org/archive/html/coreutils/2012-11/msg00076.html). Binary conversion can be done easily in bash or ksh
* [disallow chmod to create world writable files](https://lists.gnu.org/archive/html/coreutils/2013-06/msg00075.html). This couldn't be general, and even so could be easily bypassed

### cp

* [cp,mv --to](https://lists.gnu.org/archive/html/bug-coreutils/2009-08/msg00298.html).
  Though better than --target it wasn't warranted to have two ways to do it
* [unicode symbols for cp,mv --verbose](https://lists.gnu.org/archive/html/bug-coreutils/2009-09/msg00096.html).
  Rejected for same reasons as [UTF-8 arrows in ls output](https://lists.gnu.org/archive/html/bug-coreutils/2009-08/msg00023.html)
* [distinguished symbols for cp,mv --verbose](https://lists.gnu.org/archive/html/bug-coreutils/2009-12/msg00109.html).
  It was deemed there was enough info from the context
* [cp,mv --progress](https://lists.gnu.org/archive/html/coreutils/2013-05/msg00020.html). Existing tools cater for this already
* [cp --reflink-range=src\_offset,src\_length,dst\_offset](https://lists.gnu.org/archive/html/coreutils/2011-08/msg00006.html). The was not deemed warranted
* [cp --quiet](https://lists.gnu.org/archive/html/coreutils/2012-02/msg00090.html). Suppressing ENOENT errors can be done by filtering existing files first
* [cp --resume](https://lists.gnu.org/archive/html/coreutils/2012-04/msg00079.html). Use rsync
* [cp --parallel](https://lists.gnu.org/archive/html/coreutils/2012-04/msg00079.html). While this helps copy speed in some situations, the fix is probably best handled at a lower level
* cp --preserve=all should [copy ext2 extended attributes](https://lists.gnu.org/archive/html/coreutils/2013-08/msg00019.html). Would need file system agnostic interface (like copyfile())
* [cp,mv --bwlimit](https://lists.gnu.org/archive/html/coreutils/2014-02/msg00019.html) to throttle data transfer rates. This is better suited to higher level tools, and is available in rsync

### cut

* [cut -d '[:blank:]'](https://lists.gnu.org/archive/html/bug-coreutils/2009-09/msg00165.html), or cut -w.
  Preprocessing with tr -s '[:blank:]' '\t', or using [using join(1) or awk](https://github.com/coreutils/coreutils/commit/38cdb01a3) was thought sufficient
* [cut -d 'string'](https://lists.gnu.org/archive/html/bug-coreutils/2010-01/msg00020.html).
  sed 's/string/\x00/g' | cut -d '' was deemed sufficient
* cut --output-delimiter short option. One can already do cut --ou
* [cut --csv](https://lists.gnu.org/archive/html/bug-coreutils/2010-05/msg00122.html). A [separate](http://freshmeat.sourceforge.net/projects/csvutils) util was deemed best for this complicated task
* [cut -C](https://lists.gnu.org/archive/html/coreutils/2012-04/msg00027.html). There was no need for this alias for --complement (--co)
* [cut -f2,1](https://lists.gnu.org/archive/html/bug-coreutils/2012-12/msg00115.html) to reorder fields. [Using awk or join](https://git.sv.gnu.org/gitweb/?p=coreutils.git;a=commitdiff;h=38cdb01) is deemed sufficient
* [cut --separator](https://bugs.gnu.org/14224) to specify the “line” delimiter. Pre/Post-processing with tr was deemed sufficient

### date

* [date +%f](https://lists.gnu.org/archive/html/coreutils/2011-08/msg00008.html) to flush output. `stdbuf -oL date ...` was deemed sufficient
* [date should parse 'DAY MONTH, YEAR'](https://bugs.gnu.org/14613) format. The format was deemed [erroneous](https://www.grammar.com/dates-day-month-year/)
* [date +%J](https://lists.gnu.org/archive/html/coreutils/2013-10/msg00019.html) to support astronomical julian date. This was not thought common enough to support
* [date -v](https://lists.gnu.org/archive/html/coreutils/2013-10/msg00041.html) to provide BSD syntax relative date adjustments. The existing GNU relative date syntax was thought sufficient

### dd

* [I/O throughput limitation for dd](https://lists.gnu.org/archive/html/bug-coreutils/2009-12/msg00199.html).
  pv and rsync et. al. were deemed better for this
* [dd --limit-speed](https://lists.gnu.org/archive/html/coreutils/2012-09/msg00121.html). It was thought best to leave this to tools like pv or trickle
* [dd conv=noerror](https://lists.gnu.org/archive/html/coreutils/2012-12/msg00146.html) should apply to writes as well as reads. shred is best used for this use case
* [dd iflag=seekable oflag=seekable](https://bugs.gnu.org/13391) to verify lseek(2) support. The feature was not deemed useful/complete enough
* [dd conv=offload](https://lists.gnu.org/archive/html/coreutils/2014-03/msg00055.html) to offload copying to various backends. This was thought too specialized to support explicitly
* [dd conv=truncpost](https://lists.gnu.org/archive/html/coreutils/2014-06/msg00025.html). To support filtering files in place. Due to error handling this was not thought useful enough

### df

* [df,du -g](https://lists.gnu.org/archive/html/bug-coreutils/2009-12/msg00000.html).
  Specifying “Gigabyte” output format is neither standard or required
* [df autoscale](https://lists.gnu.org/archive/html/bug-coreutils/2010-09/msg00046.html). df -h was thought good enough
* [df -g](https://lists.gnu.org/archive/html/bug-coreutils/2012-07/msg00025.html). Separate options for various output units is best avoided
* [df --without-header](https://lists.gnu.org/archive/html/coreutils/2012-12/msg00067.html). --header options are only really useful for data consumers
* [df --dereference](https://lists.gnu.org/archive/html/coreutils/2013-11/msg00072.html) to process symlink targets. df was changed to reference symlink targets unconditionally

### du

* [du --format](https://lists.gnu.org/archive/html/coreutils/2011-02/msg00072.html) to allow sorting. sort -h handles this
* [accurate du results for OCFS2 reflinked files](https://lists.gnu.org/archive/html/coreutils/2012-10/msg00015.html). It was thought too complicated and specific to add to du
* [du --exclude-dirs](https://lists.gnu.org/archive/html/coreutils/2013-04/msg00043.html) to exclude directories themselves from the usage count. find .. | du was thought sufficient
* [du --sort](https://lists.gnu.org/archive/html/bug-coreutils/2014-05/msg00110.html) to sort by disk usage. This is already supported directly by du -h | sort -h

### join

* [Auto detect output format for join](https://lists.gnu.org/archive/html/bug-coreutils/2009-11/msg00083.html).
  We need to consider further whether this is useful
* [join more than two files](https://lists.gnu.org/archive/html/coreutils/2012-01/msg00104.html). It would add complexity while not being scalable
* [join more than one field](https://lists.gnu.org/archive/html/coreutils/2012-02/msg00066.html). There wasn't much interest in this
* [comm,join --parallel](https://lists.gnu.org/archive/html/bug-coreutils/2013-11/msg00185.html) to use multiple cores. It was thought best to split the data for multiple processes
* [join -t '\t'](https://lists.gnu.org/archive/html/coreutils/2013-11/msg00049.html) to use a TAB delimiter. Using the shell to specify the TAB char like join -t $'\t', was thought ubiquitous enough

### ls

* Change/revert the default quoting style - please see the [ls quotes](https://www.gnu.org/software/coreutils/quotes.html) page for details.
* [UTF-8 arrows in ls](https://lists.gnu.org/archive/html/bug-coreutils/2009-08/msg00023.html).
  See this [l script](https://www.pixelbeat.org/scripts/l) as an alternative
* [df/ls --blocksize={decimal,binary}](https://lists.gnu.org/archive/html/bug-coreutils/2010-10/msg00022.html). Though more correct, it was deemed overkill
* [ls --sort=class](https://lists.gnu.org/archive/html/coreutils/2012-05/msg00013.html). Sorting by type indicator was deemed of marginal benefit
* [ls --octal](https://lists.gnu.org/archive/html/coreutils/2013-03/msg00049.html) to output octal permissions. Using stat or find is deemed sufficient
* [ls --group-numbers=locale](https://lists.gnu.org/archive/html/coreutils/2013-06/msg00019.html) to output thousands separators. [BLOCK\_SIZE](https://lists.gnu.org/archive/html/coreutils/2013-06/msg00021.html) or [numfmt](https://lists.gnu.org/archive/html/coreutils/2013-06/msg00033.html) were deemed sufficient
* [Suppress trailing slash with ls -F /](https://lists.gnu.org/archive/html/coreutils/2013-02/msg00161.html). The result was deemed [too inconsistent](https://lists.gnu.org/archive/html/coreutils/2013-05/msg00024.html)
* [ls --just=$filetype](https://lists.gnu.org/archive/html/coreutils/2013-11/msg00093.html) to limit file type listed. Filtering classify tags like `ls --color -lF | sed -n 's#/$##p'` was thought sufficient
* [ls --sort=inode](https://lists.gnu.org/archive/html/bug-coreutils/2014-11/msg00062.html). It was though find ... | sort was more appropriate for this low level functionality

### mv

* [mv -p](https://debbugs.gnu.org/cgi/bugreport.cgi?bug=5926) (create target dir). It was thought more functional to just `mkdir -p` first
* [mv --symbolic-link](https://lists.gnu.org/archive/html/coreutils/2012-11/msg00031.html). It was thought that mv and ln --relative separately give more control
* [mv --safe](https://lists.gnu.org/archive/html/coreutils/2013-04/msg00019.html) to only remove source on completion. `cp ... && rm` was deemed sufficient
* [mv --parents](https://lists.gnu.org/archive/html/coreutils/2013-04/msg00076.html) to [recreate a hierarchy](https://lists.gnu.org/archive/html/bug-coreutils/2009-09/msg00003.html). [Using cp -l --parents](https://lists.gnu.org/archive/html/coreutils/2013-05/msg00013.html) is deemed sufficient

### rm

* [rm --parents](https://lists.gnu.org/archive/html/bug-coreutils/2009-07/msg00033.html).
  Deleting the opposite way up the tree was deemed too dangerous
* [rm -d](https://lists.gnu.org/archive/html/bug-coreutils/2010-06/msg00105.html). rmdir is equivalent and less confusing
* [rm --no-preserve-root](https://lists.gnu.org/archive/html/bug-coreutils/2012-01/msg00096.html). Adding protective prompts would not significantly improve security
* [rm -rf **.**](https://lists.gnu.org/archive/html/bug-coreutils/2012-09/msg00011.html) to delete current directory. It was thought existing support for rm -rf "$PWD" suffices
* [rm -rf **.**](https://bugs.gnu.org/12339#209) to delete all files inside current directory. `rm -rf \* .[!.] .??\*` and `find . -delete` were deemed sufficient
* [rm -s](https://lists.gnu.org/archive/html/coreutils/2013-04/msg00069.html) to behave in a “smarter” fashion. `rm -I` or `find | xargs rm` were deemed sufficient
* [rm --exclude](https://lists.gnu.org/archive/html/bug-coreutils/2013-09/msg00010.html) to exclude file names. Existing tools like find(1) were thought sufficient
* [rm should use remove()](https://lists.gnu.org/archive/html/bug-coreutils/2013-11/msg00054.html), leaving unlink() to the unlink command. We can't change such standardized functionality

### shred

* [shred --recursive](https://lists.gnu.org/archive/html/bug-coreutils/2009-06/msg00222.html).
  Deemed better to explicitly select (with "find" for example)
* [shred -r](https://lists.gnu.org/archive/html/coreutils/2011-12/msg00044.html). shred is of limited use with files anyway

### sort

* [sort --by-length](https://lists.gnu.org/archive/html/bug-coreutils/2009-07/msg00102.html).
  A 