# mencal CWL Generation Report

## mencal

### Tool Description
Menstruation calendar 2.1

### Metadata
- **Docker Image**: biocontainers/mencal:v3.0-4-deb_cv1
- **Homepage**: https://github.com/felgari/mencal
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/mencal/overview
- **Total Downloads**: N/A
- **Last updated**: N/A
- **GitHub**: https://github.com/felgari/mencal
- **Stars**: N/A
### Original Help Text
```text
Menstruation calendar 2.1
Usage: mencal [options] [file1 file2 ... -c CONF1 -c CONF2 ...]
Display options (only one from 1,3,y can be set):
  -m, --monday        draw monday as first weekday (sunday is default)
  -1                  actual month (default)
  -3                  previous, current and next month
  -y [YYYY]           all-year calendar (default YYYY is current year)
  -q, --quiet         no top information will be printed
  -C, --color         colored output (default)
  -n, --nocolor       noncolored output
  -i, --icolor COLOR  intersection color (default red)
    available colors: red, green, blue, yellow, violet, cyan, shiny, bold

Menstruation configuration:
  -c, --config   s=[YYYY]MMDD,l=LL,d=DD,n=NAME,f=FILE,c=COLOR

  The second argument is a comma separated list of options. No spaces are
  allowed in this list. If no name is specified, 'Unknown' is used.
  Various -c options or filenames can be set.

    s,start=[YYYY]MMDD  start day of period (default current day)
    l,length=LL         length of period in days (default 28)
    d,duration=D        duration of menstruation in days (default 4)
    n,name=NAME         name of subject
    f,file=FILE         filename to save configuration to
      only menstruation related variables will be saved
    c,color=COLOR       color used for menstruation days of subject
      available colors: red, green, blue, yellow, violet, cyan, shiny, bold
      default color is red, with '-n' switch color settings are ignored

Info options:
  -h, --help     print this help
  -V, --version  print version information

(C) 2013 C. McCohy <mccohy@kyberdigi.cz>
http://kyberdigi.cz/projects/mencal/
```


## Metadata
- **Skill**: generated
