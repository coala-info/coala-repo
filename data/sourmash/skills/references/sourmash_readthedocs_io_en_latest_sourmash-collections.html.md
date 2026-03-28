# sourmash: working with private collections of signatures[¶](#sourmash:-working-with-private-collections-of-signatures "Link to this heading")

## Running this notebook.[¶](#Running-this-notebook. "Link to this heading")

You can run this notebook interactively via mybinder; click on this button: [![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/dib-lab/sourmash/latest?labpath=doc%2Fsourmash-collections.ipynb)

A rendered version of this notebook is available at [sourmash.readthedocs.io](https://sourmash.readthedocs.io) under “Tutorials and notebooks”.

You can also get this notebook from the [doc/ subdirectory of the sourmash github repository](https://github.com/dib-lab/sourmash/tree/latest/doc). See [binder/environment.yaml](https://github.com/dib-lab/sourmash/blob/latest/binder/environment.yml) for installation dependencies.

## What is this?[¶](#What-is-this? "Link to this heading")

This is a Jupyter Notebook using Python 3. If you are running this via [binder](https://mybinder.org), you can use Shift-ENTER to run cells, and double click on code cells to edit them.

Contact: C. Titus Brown, ctbrown@ucdavis.edu. Please [file issues on GitHub](https://github.com/dib-lab/sourmash/issues/) if you have any questions or comments!

### download a bunch of genomes[¶](#download-a-bunch-of-genomes "Link to this heading")

```
[1]:
```

```
!mkdir -p big_genomes
!curl -L https://osf.io/8uxj9/?action=download | (cd big_genomes && tar xzf -)
```

```
/Users/t/dev/sourmash/doc/big_genomes
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   459  100   459    0     0   1017      0 --:--:-- --:--:-- --:--:--  1017
100 61.1M  100 61.1M    0     0  2932k      0  0:00:21  0:00:21 --:--:-- 3468k
```

### compute signatures for each file[¶](#compute-signatures-for-each-file "Link to this heading")

```
[2]:
```

```
!cd big_genomes/ && sourmash sketch dna -p k=31,scaled=1000 --name-from-first *.fa
```

```
/Users/t/dev/sourmash/doc/big_genomes

== This is sourmash version 4.0.0a4.dev12+g31c5eda2. ==
== Please cite Brown and Irber (2016), doi:10.21105/joss.00027. ==

computing signatures for files: 0.fa, 1.fa, 10.fa, 11.fa, 12.fa, 13.fa, 14.fa, 15.fa, 16.fa, 17.fa, 18.fa, 19.fa, 2.fa, 20.fa, 21.fa, 22.fa, 23.fa, 24.fa, 25.fa, 26.fa, 27.fa, 28.fa, 29.fa, 3.fa, 30.fa, 31.fa, 32.fa, 33.fa, 34.fa, 35.fa, 36.fa, 37.fa, 38.fa, 39.fa, 4.fa, 40.fa, 41.fa, 42.fa, 43.fa, 44.fa, 45.fa, 46.fa, 47.fa, 48.fa, 49.fa, 5.fa, 50.fa, 51.fa, 52.fa, 53.fa, 54.fa, 55.fa, 56.fa, 57.fa, 58.fa, 59.fa, 6.fa, 60.fa, 61.fa, 62.fa, 63.fa, 7.fa, 8.fa, 9.fa
Computing a total of 1 signature(s).
... reading sequences from 0.fa
calculated 1 signatures for 1 sequences in 0.fa
saved signature(s) to 0.fa.sig. Note: signature license is CC0.
... reading sequences from 1.fa
calculated 1 signatures for 1 sequences in 1.fa
saved signature(s) to 1.fa.sig. Note: signature license is CC0.
... reading sequences from 10.fa
calculated 1 signatures for 1 sequences in 10.fa
saved signature(s) to 10.fa.sig. Note: signature license is CC0.
... reading sequences from 11.fa
calculated 1 signatures for 1 sequences in 11.fa
saved signature(s) to 11.fa.sig. Note: signature license is CC0.
... reading sequences from 12.fa
calculated 1 signatures for 1 sequences in 12.fa
saved signature(s) to 12.fa.sig. Note: signature license is CC0.
... reading sequences from 13.fa
calculated 1 signatures for 1 sequences in 13.fa
saved signature(s) to 13.fa.sig. Note: signature license is CC0.
... reading sequences from 14.fa
calculated 1 signatures for 1 sequences in 14.fa
saved signature(s) to 14.fa.sig. Note: signature license is CC0.
... reading sequences from 15.fa
calculated 1 signatures for 1 sequences in 15.fa
saved signature(s) to 15.fa.sig. Note: signature license is CC0.
... reading sequences from 16.fa
calculated 1 signatures for 4 sequences in 16.fa
saved signature(s) to 16.fa.sig. Note: signature license is CC0.
... reading sequences from 17.fa
calculated 1 signatures for 2 sequences in 17.fa
saved signature(s) to 17.fa.sig. Note: signature license is CC0.
... reading sequences from 18.fa
calculated 1 signatures for 1 sequences in 18.fa
saved signature(s) to 18.fa.sig. Note: signature license is CC0.
... reading sequences from 19.fa
calculated 1 signatures for 9 sequences in 19.fa
saved signature(s) to 19.fa.sig. Note: signature license is CC0.
... reading sequences from 2.fa
calculated 1 signatures for 1 sequences in 2.fa
saved signature(s) to 2.fa.sig. Note: signature license is CC0.
... reading sequences from 20.fa
calculated 1 signatures for 1 sequences in 20.fa
saved signature(s) to 20.fa.sig. Note: signature license is CC0.
... reading sequences from 21.fa
calculated 1 signatures for 1 sequences in 21.fa
saved signature(s) to 21.fa.sig. Note: signature license is CC0.
... reading sequences from 22.fa
calculated 1 signatures for 1 sequences in 22.fa
saved signature(s) to 22.fa.sig. Note: signature license is CC0.
... reading sequences from 23.fa
calculated 1 signatures for 5 sequences in 23.fa
saved signature(s) to 23.fa.sig. Note: signature license is CC0.
... reading sequences from 24.fa
calculated 1 signatures for 3 sequences in 24.fa
saved signature(s) to 24.fa.sig. Note: signature license is CC0.
... reading sequences from 25.fa
calculated 1 signatures for 1 sequences in 25.fa
saved signature(s) to 25.fa.sig. Note: signature license is CC0.
... reading sequences from 26.fa
calculated 1 signatures for 1 sequences in 26.fa
saved signature(s) to 26.fa.sig. Note: signature license is CC0.
... reading sequences from 27.fa
calculated 1 signatures for 1 sequences in 27.fa
saved signature(s) to 27.fa.sig. Note: signature license is CC0.
... reading sequences from 28.fa
calculated 1 signatures for 3 sequences in 28.fa
saved signature(s) to 28.fa.sig. Note: signature license is CC0.
... reading sequences from 29.fa
calculated 1 signatures for 1 sequences in 29.fa
saved signature(s) to 29.fa.sig. Note: signature license is CC0.
... reading sequences from 3.fa
calculated 1 signatures for 1 sequences in 3.fa
saved signature(s) to 3.fa.sig. Note: signature license is CC0.
... reading sequences from 30.fa
calculated 1 signatures for 1 sequences in 30.fa
saved signature(s) to 30.fa.sig. Note: signature license is CC0.
... reading sequences from 31.fa
calculated 1 signatures for 1 sequences in 31.fa
saved signature(s) to 31.fa.sig. Note: signature license is CC0.
... reading sequences from 32.fa
calculated 1 signatures for 1 sequences in 32.fa
saved signature(s) to 32.fa.sig. Note: signature license is CC0.
... reading sequences from 33.fa
calculated 1 signatures for 1 sequences in 33.fa
saved signature(s) to 33.fa.sig. Note: signature license is CC0.
... reading sequences from 34.fa
calculated 1 signatures for 1 sequences in 34.fa
saved signature(s) to 34.fa.sig. Note: signature license is CC0.
... reading sequences from 35.fa
calculated 1 signatures for 7 sequences in 35.fa
saved signature(s) to 35.fa.sig. Note: signature license is CC0.
... reading sequences from 36.fa
calculated 1 signatures for 1 sequences in 36.fa
saved signature(s) to 36.fa.sig. Note: signature license is CC0.
... reading sequences from 37.fa
calculated 1 signatures for 1 sequences in 37.fa
saved signature(s) to 37.fa.sig. Note: signature license is CC0.
... reading sequences from 38.fa
calculated 1 signatures for 1 sequences in 38.fa
saved signature(s) to 38.fa.sig. Note: signature license is CC0.
... reading sequences from 39.fa
calculated 1 signatures for 1 sequences in 39.fa
saved signature(s) to 39.fa.sig. Note: signature license is CC0.
... reading sequences from 4.fa
calculated 1 signatures for 1 sequences in 4.fa
saved signature(s) to 4.fa.sig. Note: signature license is CC0.
... reading sequences from 40.fa
calculated 1 signatures for 1 sequences in 40.fa
saved signature(s) to 40.fa.sig. Note: signature license is CC0.
... reading sequences from 41.fa
calculated 1 signatures for 1 sequences in 41.fa
saved signature(s) to 41.fa.sig. Note: signature license is CC0.
... reading sequences from 42.fa
calculated 1 signatures for 1 sequences in 42.fa
saved signature(s) to 42.fa.sig. Note: signature license is CC0.
... reading sequences from 43.fa
calculated 1 signatures for 1 sequences in 43.fa
saved signature(s) to 43.fa.sig. Note: signature license is CC0.
... reading sequences from 44.fa
calculated 1 signatures for 2 sequences in 44.fa
saved signature(s) to 44.fa.sig. Note: signature license is CC0.
... reading sequences from 45.fa
calculated 1 signatures for 1 sequences in 45.fa
saved signature(s) to 45.fa.sig. Note: signature license is CC0.
... reading sequences from 46.fa
calculated 1 signatures for 1 sequences in 46.fa
saved signature(s) to 46.fa.sig. Note: signature license is CC0.
... reading sequences from 47.fa
calculated 1 signatures for 2 sequences in 47.fa
saved signature(s) to 47.fa.sig. Note: signature license is CC0.
... reading sequences from 48.fa
calculated 1 signatures for 1 sequences in 48.fa
saved signature(s) to 48.fa.sig. Note: signature license is CC0.
... reading sequences from 49.fa
calculated 1 signatures for 228 sequences in 49.fa
saved signature(s) to 49.fa.sig. Note: signature license is CC0.
... reading sequences from 5.fa
calculated 1 signatures for 1 sequences in 5.fa
saved signature(s) to 5.fa.sig. Note: signature license is CC0.
... reading sequences from 50.fa
calculated 1 signatures for 1 sequences in 50.fa
saved signature(s) to 50.fa.sig. Note: signature license is CC0.
... reading sequences from 51.fa
calculated 1 signatures for 1 sequences in 51.fa
saved signature(s) to 51.fa.sig. Note: signature license is CC0.
... reading sequences from 52.fa
calculated 1 signatures for 1 sequences in 52.fa
saved signature(s) to 52.fa.sig. Note: signature license is CC0.
... reading sequences from 53.fa
calculated 1 signatures for 1 sequences in 53.fa
saved signature(s) to 53.fa.sig. Note: signature license is CC0.
... reading sequences from 54.fa
calculated 1 signatures for 1 sequences in 54.fa
saved signature(s) to 54.fa.sig. Note: signature license is CC0.
... reading sequences from 55.fa
calculated 1 signatures for 1 sequences in 55.fa
saved signature(s) to 55.fa.sig. Note: signature license is CC0.
... reading sequences from 56.fa
calculated 1 signatures for 1 sequences in 56.fa
saved signature(s) to 56.fa.sig. Note: signature license is CC0.
... reading sequences from 57.fa
calculated 1 signatures for 1 sequences in 57.fa
saved signature(s) to 57.fa.sig. Note: signature license is CC0.
... reading sequences from 58.fa
calculated 1 signatures for 30 sequences in 58.fa
saved signature(s) to 58.fa.sig. Note: signature license is CC0.
... reading sequences from 59.fa
calculated 1 signatures for 5 sequences in 59.fa
saved signature(s) to 59.fa.sig. Note: signature license is CC0.
... reading sequences from 6.fa
calculated 1 signatures for 76 sequences in 6.fa
saved signature(s) to 6.fa.sig. Note: signature license is CC0.
... reading sequences from 60.fa
calculated 1 signatures for 11 sequences in 60.fa
saved signature(s) to 60.fa.sig. Note: signature license is CC0.
... reading sequences from 61.fa
calculated 1 signatures for 47 sequences in 61.fa
saved signature(s) to 61.fa.sig. Note: signature license is CC0.
... reading sequences from 62.fa
calculated 1 signatures for 1 sequences in 62.fa
saved signature(s) to 62.fa.sig. Note: signature license is CC0.
... reading sequences from 63.fa
calculated 1 signatures for 4 sequences in 63.fa
saved signature(s) to 63.fa.sig. Note: signature license is CC0.
... reading sequences from 7.fa
calculated 1 signatures for 3 sequences in 7.fa
saved signature(s) to 7.fa.sig. Note: signature license is CC0.
... reading sequences from 8.fa
calculated 1 signatures for 1 sequences in 8.fa
saved signature(s) to 8.fa.sig. Note: signature license is CC0.
... reading sequences from 9.fa
calculated 1 signatures for 3 sequences in 9.fa
saved signature(s) to 9.fa.sig. Note: signature license is CC0.
```

### Compare them all[¶](#Compare-them-all "Link to this heading")

```
[3]:
```

```
!sourmash compare big_genomes/*.sig -o compare_all.mat
!sourmash plot compare_all.mat
```

```
== This is sourmash version 4.0.0a4.dev12+g31c5eda2. ==
== Please cite Brown and Irber (2016), doi:10.21105/joss.00027. ==

loaded 1 sigs from 'big_genomes/0.fa.sig'g'
loaded 1 sigs from 'big_genomes/1.fa.sig'g'
loaded 1 sigs from 'big_genomes/10.fa.sig'g'
loaded 1 sigs from 'big_genomes/11.fa.sig'g'
loaded 1 sigs from 'big_genomes/12.fa.sig'g'
loaded 1 sigs from 'big_genomes/13.fa.sig'g'
loaded 1 sigs from 'big_genomes/14.fa.sig'g'
loaded 1 sigs from 'big_genomes/15.fa.sig'g'
loaded 1 sigs from 'big_genomes/16.fa.sig'g'
loaded 1 sigs from 'big_genomes/17.fa.sig'10 sigs total
loaded 1 sigs from 'big_genomes/18.fa.sig'g'
loaded 1 sigs from 'big_genomes/19.fa.sig'g'
loaded 1 sigs from 'big_genomes/2.fa.sig'g'
loaded 1 sigs from 'big_genomes/20.fa.sig'g'
loaded 1 sigs from 'big_genomes/21.fa.sig'g'
loaded 1 sigs from 'big_genomes/22.fa.sig'g'
loaded 1 sigs from 'big_genomes/23.fa.sig'g'
loaded 1 sigs from 'big_genomes/24.fa.sig'g'
loaded 1 sigs from 'big_genomes/25.fa.sig'g'
loaded 1 sigs from 'big_genomes/26.fa.sig'20 sigs total
loaded 1 sigs from 'big_genomes/27.fa.sig'g'
loaded 1 sigs from 'big_genomes/28.fa.sig'g'
loaded 1 sigs from 'big_genomes/29.fa.sig'g'
loaded 1 sigs from 'big_genomes/3.fa.sig'g'
loaded 1 sigs from 'big_genomes/30.fa.sig'g'
loaded 1 sigs from 'big_genomes/31.fa.sig'g'
loaded 1 sigs from 'big_genomes/32.fa.sig'g'
loaded 1 sigs from 'big_genomes/33.fa.sig'g'
loaded 1 sigs from 'big_genomes/34.fa.sig'g'
loaded 1 sigs from 'big_genomes/35.fa.sig'30 sigs total
loaded 1 sigs from 'big_genomes/36.fa.sig'g'
loaded 1 sigs from 'big_genomes/37.fa.sig'g'
loaded 1 sigs from 'big_genomes/38.fa.sig'g'
loaded 1 sigs from 'big_genomes/39.fa.sig'g'
loaded 1 sigs from 'big_genomes/4.fa.sig'g'
loaded 1 sigs from 'big_genomes/40.fa.sig'g'
loaded 1 sigs from 'big_genomes/41.fa.sig'g'
loaded 1 sigs from 'big_genomes/42.fa.sig'g'
loaded 1 sigs from 'big_genomes/43.fa.sig'g'
loaded 1 sigs from 'big_genomes/44.fa.sig'40 sigs total
loaded 1 sigs from 'big_genomes/45.fa.sig'g'
loaded 1 sigs from 'big_genomes/46.fa.sig'g'
loaded 1 sigs from 'big_genomes/47.fa.sig'g'
loaded 1 sigs from 'big_genomes/48.fa.sig'g'
loaded 1 sigs from 'big_genomes/49.fa.sig'g'
loaded 1 sigs from 'big_genomes/5.fa.sig'g'
loaded 1 sigs from 'big_genomes/50.fa.sig'g'
loaded 1 sigs from 'big_genomes/51.fa.sig'g'
loaded 1 sigs from 'big_genomes/52.fa.sig'g'
loaded 1 sigs from 'big_genomes/53.fa.sig'50 sigs total
loaded 1 sigs from 'big_genomes/54.fa.sig'g'
loaded 1 sigs from 'big_genomes/55.fa.sig'g'
loaded 1 sigs from 'big_genomes/56.fa.sig'g'
loaded 1 sigs from 'big_genomes/57.fa.sig'g'
loaded 1 sigs from 'big_genomes/58.fa.sig'g'
loaded 1 sigs from 'big_genomes/59.fa.sig'g'
loaded