[![](../img/refgenie_logo_light.svg)](..)

* [Refgenomes server](../servers)

* Search
* [Manuscripts](../manuscripts)
* [GitHub](https://github.com/databio/refgenie/)
* [PyPI](https://pypi.org/project/refgenie)
* [Databio.org](http://databio.org)

* #### Getting Started

+ [Introduction](..)

+ [Demo videos](../demo_videos/)

+ [Overview](../overview/)

+ [Install and configure](../install/)

+ [Basic tutorial](../tutorial/)

+ [Citing refgenie](../manuscripts/)

* #### How-to guides

+ [Refer to assets](../asset_registry_paths/)

+ [Download pre-built assets](../pull/)

+ [Build assets](../build/)

+ [Add custom assets](../custom_assets/)

+ [Retrieve paths to assets](../seek/)

+ [Use asset tags](../tag/)

+ [Use aliases](../aliases/)

+ [Populate refgenie paths](../populate/)

+ [Compare genomes](../compare/)

+ [Run my own asset server](../refgenieserver/)

+ [Use refgenie from Python](../refgenconf/)

+ [Use refgenie in your pipeline](../code_snippets/)

+ [Use refgenie on the cloud](../remote/)

+ [Use refgenie with iGenomes](../igenomes/)

+ [Upgrade from config 0.3 to 0.4](./)

* #### Reference

+ [Studies using refgenie](../uses_refgenie/)

+ [Genome configuration file](../genome_config/)

+ [Glossary](../glossary/)

+ [Buildable assets](../available_assets/)

+ [Usage](../usage/)

+ [Python API](../autodoc_build/refgenconf/)

+ [FAQ](../faq/)

+ [Support](https://github.com/databio/refgenie/issues)

+ [Contributing](../contributing/)

+ [Changelog](../changelog/)

# Configuration file upgrade demonstration

In the following tutorial we will present the process of upgrading the refgenie configuration file and asset files from version **0.3** to version **0.4**.

First, let's install the refgenie and refgenconf Python packages that support version 0.3 of refgenie configuration file

## Working environment setup

Let's install the legacy refgenconf and refgenie Python packages

```
pip install refgenconf==0.9.3
pip install refgenie==0.9.3
```

```
Collecting refgenconf==0.9.3
  Using cached https://files.pythonhosted.org/packages/52/c3/6aed361205272e30cd3570ca1c33feae6ad977ad32ddff8e509752046272/refgenconf-0.9.3-py3-none-any.whl
Requirement already satisfied: requests in /Users/mstolarczyk/Library/Python/3.6/lib/python/site-packages (from refgenconf==0.9.3) (2.21.0)
Requirement already satisfied: attmap>=0.12.5 in /Library/Frameworks/Python.framework/Versions/3.6/lib/python3.6/site-packages (from refgenconf==0.9.3) (0.12.12.dev0)
Requirement already satisfied: tqdm>=4.38.0 in /Library/Frameworks/Python.framework/Versions/3.6/lib/python3.6/site-packages (from refgenconf==0.9.3) (4.47.0)
Requirement already satisfied: pyyaml in /Users/mstolarczyk/Library/Python/3.6/lib/python/site-packages (from refgenconf==0.9.3) (5.1)
Requirement already satisfied: yacman>=0.6.9 in /Library/Frameworks/Python.framework/Versions/3.6/lib/python3.6/site-packages (from refgenconf==0.9.3) (0.7.0)
Requirement already satisfied: pyfaidx in /Library/Frameworks/Python.framework/Versions/3.6/lib/python3.6/site-packages (from refgenconf==0.9.3) (0.5.9.1)
Requirement already satisfied: urllib3<1.25,>=1.21.1 in /Users/mstolarczyk/Library/Python/3.6/lib/python/site-packages (from requests->refgenconf==0.9.3) (1.24.1)
Requirement already satisfied: idna<2.9,>=2.5 in /Users/mstolarczyk/Library/Python/3.6/lib/python/site-packages (from requests->refgenconf==0.9.3) (2.8)
Requirement already satisfied: certifi>=2017.4.17 in /Users/mstolarczyk/Library/Python/3.6/lib/python/site-packages (from requests->refgenconf==0.9.3) (2019.3.9)
Requirement already satisfied: chardet<3.1.0,>=3.0.2 in /Users/mstolarczyk/Library/Python/3.6/lib/python/site-packages (from requests->refgenconf==0.9.3) (3.0.4)
Requirement already satisfied: ubiquerg>=0.2.1 in /Library/Frameworks/Python.framework/Versions/3.6/lib/python3.6/site-packages (from attmap>=0.12.5->refgenconf==0.9.3) (0.6.1)
Requirement already satisfied: oyaml in /Library/Frameworks/Python.framework/Versions/3.6/lib/python3.6/site-packages (from yacman>=0.6.9->refgenconf==0.9.3) (0.9)
Requirement already satisfied: setuptools>=0.7 in /Library/Frameworks/Python.framework/Versions/3.6/lib/python3.6/site-packages (from pyfaidx->refgenconf==0.9.3) (41.0.1)
Requirement already satisfied: six in /Users/mstolarczyk/Library/Python/3.6/lib/python/site-packages (from pyfaidx->refgenconf==0.9.3) (1.12.0)
Installing collected packages: refgenconf
  Found existing installation: refgenconf 0.10.0.dev0
    Uninstalling refgenconf-0.10.0.dev0:
      Successfully uninstalled refgenconf-0.10.0.dev0
Successfully installed refgenconf-0.9.3
WARNING: You are using pip version 19.2.3, however version 20.2.3 is available.
You should consider upgrading via the 'pip install --upgrade pip' command.
Collecting refgenie==0.9.3
  Using cached https://files.pythonhosted.org/packages/af/52/c1e1bc63b3543f591ebdf44caccfaab3c730708256d926b9f4b1c34d1865/refgenie-0.9.3-py3-none-any.whl
Requirement already satisfied: pyfaidx>=0.5.5.2 in /Library/Frameworks/Python.framework/Versions/3.6/lib/python3.6/site-packages (from refgenie==0.9.3) (0.5.9.1)
Requirement already satisfied: refgenconf>=0.9.1 in /Library/Frameworks/Python.framework/Versions/3.6/lib/python3.6/site-packages (from refgenie==0.9.3) (0.9.3)
Requirement already satisfied: logmuse>=0.2.6 in /Library/Frameworks/Python.framework/Versions/3.6/lib/python3.6/site-packages (from refgenie==0.9.3) (0.2.6)
Requirement already satisfied: piper>=0.12.1 in /Library/Frameworks/Python.framework/Versions/3.6/lib/python3.6/site-packages (from refgenie==0.9.3) (0.12.1)
Requirement already satisfied: six in /Users/mstolarczyk/Library/Python/3.6/lib/python/site-packages (from pyfaidx>=0.5.5.2->refgenie==0.9.3) (1.12.0)
Requirement already satisfied: setuptools>=0.7 in /Library/Frameworks/Python.framework/Versions/3.6/lib/python3.6/site-packages (from pyfaidx>=0.5.5.2->refgenie==0.9.3) (41.0.1)
Requirement already satisfied: attmap>=0.12.5 in /Library/Frameworks/Python.framework/Versions/3.6/lib/python3.6/site-packages (from refgenconf>=0.9.1->refgenie==0.9.3) (0.12.12.dev0)
Requirement already satisfied: requests in /Users/mstolarczyk/Library/Python/3.6/lib/python/site-packages (from refgenconf>=0.9.1->refgenie==0.9.3) (2.21.0)
Requirement already satisfied: tqdm>=4.38.0 in /Library/Frameworks/Python.framework/Versions/3.6/lib/python3.6/site-packages (from refgenconf>=0.9.1->refgenie==0.9.3) (4.47.0)
Requirement already satisfied: pyyaml in /Users/mstolarczyk/Library/Python/3.6/lib/python/site-packages (from refgenconf>=0.9.1->refgenie==0.9.3) (5.1)
Requirement already satisfied: yacman>=0.6.9 in /Library/Frameworks/Python.framework/Versions/3.6/lib/python3.6/site-packages (from refgenconf>=0.9.1->refgenie==0.9.3) (0.7.0)
Requirement already satisfied: ubiquerg>=0.4.5 in /Library/Frameworks/Python.framework/Versions/3.6/lib/python3.6/site-packages (from piper>=0.12.1->refgenie==0.9.3) (0.6.1)
Requirement already satisfied: psutil in /Users/mstolarczyk/Library/Python/3.6/lib/python/site-packages (from piper>=0.12.1->refgenie==0.9.3) (5.6.1)
Requirement already satisfied: pandas in /Library/Frameworks/Python.framework/Versions/3.6/lib/python3.6/site-packages (from piper>=0.12.1->refgenie==0.9.3) (1.0.3)
Requirement already satisfied: urllib3<1.25,>=1.21.1 in /Users/mstolarczyk/Library/Python/3.6/lib/python/site-packages (from requests->refgenconf>=0.9.1->refgenie==0.9.3) (1.24.1)
Requirement already satisfied: chardet<3.1.0,>=3.0.2 in /Users/mstolarczyk/Library/Python/3.6/lib/python/site-packages (from requests->refgenconf>=0.9.1->refgenie==0.9.3) (3.0.4)
Requirement already satisfied: certifi>=2017.4.17 in /Users/mstolarczyk/Library/Python/3.6/lib/python/site-packages (from requests->refgenconf>=0.9.1->refgenie==0.9.3) (2019.3.9)
Requirement already satisfied: idna<2.9,>=2.5 in /Users/mstolarczyk/Library/Python/3.6/lib/python/site-packages (from requests->refgenconf>=0.9.1->refgenie==0.9.3) (2.8)
Requirement already satisfied: oyaml in /Library/Frameworks/Python.framework/Versions/3.6/lib/python3.6/site-packages (from yacman>=0.6.9->refgenconf>=0.9.1->refgenie==0.9.3) (0.9)
Requirement already satisfied: pytz>=2017.2 in /Users/mstolarczyk/Library/Python/3.6/lib/python/site-packages (from pandas->piper>=0.12.1->refgenie==0.9.3) (2018.9)
Requirement already satisfied: python-dateutil>=2.6.1 in /Users/mstolarczyk/Library/Python/3.6/lib/python/site-packages (from pandas->piper>=0.12.1->refgenie==0.9.3) (2.8.0)
Requirement already satisfied: numpy>=1.13.3 in /Users/mstolarczyk/Library/Python/3.6/lib/python/site-packages (from pandas->piper>=0.12.1->refgenie==0.9.3) (1.17.3)
Installing collected packages: refgenie
  Found existing installation: refgenie 0.10.0.dev0
    Uninstalling refgenie-0.10.0.dev0:
      Successfully uninstalled refgenie-0.10.0.dev0
Successfully installed refgenie-0.9.3
WARNING: You are using pip version 19.2.3, however version 20.2.3 is available.
You should consider upgrading via the 'pip install --upgrade pip' command.
```

Now let's set up a directory that we will use for the config file and refgenie assets

```
export WORKDIR=~/Desktop/testing/refgenie/upgrade_test
rm -r $WORKDIR # remove first just to make sure the directory does not exist
mkdir -p $WORKDIR
cd $WORKDIR
```

Let's set `$REFGENIE` environment variable to point refgenie to the configuration file location and initialize it

```
export REFGENIE=$WORKDIR/g.yml
refgenie init -c $REFGENIE -s http://rg.databio.org:82/
```

```
Initialized genome configuration file: /Users/mstolarczyk/Desktop/testing/refgenie/upgrade_test/g.yml
```

Note that we subscribe to a test instance of refgenieserver, that supports both the old and new refgenie clients. This is because it exposes different API versions, that these clients use: `v2` (refgenie v0.9.3) and `v3` (refgenie v0.10.0-dev)

## Pull/build test assets

Next, let's retrieve couple of assets. As mentioned above, `v2` API is used to retrieve the asset.

```
refgenie pull rCRSd/fasta human_repeats/fasta rCRSd/bowtie2_index human_repeats/bwa_index
```

```
Downloading URL: http://rg.databio.org:82/v2/asset/rCRSd/fasta/archive
Download complete: /Users/mstolarczyk/Desktop/testing/refgenie/upgrade_test/rCRSd/fasta__default.tgz
Extracting asset tarball and saving to: /Users/mstolarczyk/Desktop/testing/refgenie/upgrade_test/rCRSd/fasta/default
Default tag for 'rCRSd/fasta' set to: default
Downloading URL: http://rg.databio.org:82/v2/asset/human_repeats/fasta/archive
Download complete: /Users/mstolarczyk/Desktop/testing/refgenie/upgrade_test/human_repeats/fasta__default.tgz
Extracting asset tarball and saving to: /Users/mstolarczyk/Desktop/testing/refgenie/upgrade_test/human_repeats/fasta/default
Default tag for 'human_repeats/fasta' set to: default
Downloading URL: http://rg.databio.org:82/v2/asset/rCRSd/bowtie2_index/archive
Download complete: /Users/mstolarczyk/Desktop/testing/refgenie/upgrade_test/rCRSd/bowtie2_index__default.tgz
Extracting asset tarball and saving to: /Users/mstolarczyk/Desktop/testing/refgenie/upgrade_test/rCRSd/bowtie2_index/default
Default tag for 'rCRSd/bowtie2_index' set to: default
Downloading URL: http://rg.databio.org:82/v2/asset/human_repeats/bwa_index/archive
Download complete: /Users/mstolarczyk/Desktop/testing/refgenie/upgrade_test/human_repeats/bwa_index__default.tgz
Extracting asset tarball and saving to: /Users/mstolarczyk/Desktop/testing/refgenie/upgrade_test/human_repeats/bwa_index/default
Default tag for 'human_repeats/bwa_index' set to: default
```

Now, let's download a small FASTA file and build a fasta asset for an arbitrary genome, which is not available at `http://rg.databio.org:82/`

```
wget -O human_alu.fa.gz http://big.databio.org/refgenie_raw/files.human_alu.fasta.fasta
```

```
--2020-10-12 17:39:25--  http://big.databio.org/refgenie_raw/files.human_alu.fasta.fasta
Resolving big.databio.org (big.databio.org)... 128.143.245.182, 128.143.245.181
Connecting to big.databio.org (big.databio.org)|128.143.245.182|:80... connected.
HTTP request sent, awaiting response... 200 OK
Length: 501 [application/octet-stream]
Saving to: ‘human_alu.fa.gz’

human_alu.fa.gz     100%[===================>]     501  --.-KB/s    in 0s

2020-10-12 17:39:25 (1.19 MB/s) - ‘human_alu.fa.gz’ saved [501/501]
```

```
refgenie build human_alu/fasta --files fasta=human_alu.fa.gz
```

```
Using 'default' as the default tag for 'human_alu/fasta'
Building 'human_alu/fasta:default' using 'fasta' recipe
Saving outputs to:
- content: /Users/mstolarczyk/Desktop/testing/refgenie/upgrade_test/human_alu
- logs: /Users/mstolarczyk/Desktop/testing/refgenie/upgrade_test/human_alu/fasta/default/_refgenie_build
### Pipeline run code and environment:

*              Command:  `/Library/Frameworks/Python.framework/Versions/3.6/bin/refgenie build human_alu/fasta --files fasta=human_alu.fa.gz`
*         Compute host:  MichalsMBP
*          Working dir:  /Users/mstolarczyk/Desktop/testing/refgenie/upgrade_test
*            Outfolder:  /Users/mstolarczyk/Desktop/testing/refgenie/upgrade_test/human_alu/fasta/default/_refgenie_build/
*  Pipeline started at:   (10-12 17:39:27) elapsed: 0.0 _TIME_

### Version log:

*       Python version:  3.6.5
*          Pypiper dir:  `/Library/Frameworks/Python.framework/Versions/3.6/lib/python3.6/site-packages/pypiper`
*      Pypiper version:  0.12.1
*         Pipeline dir:  `/Library/Frameworks/Python.framework/Versions/3.6/bin`
*     Pipeline version:  None

### Arguments passed to pipeline:

* `asset_registry_paths`:  `['human_alu/fasta']`
*             `assets`:  `None`
*            `command`:  `build`
*        `config_file`:  `/Library/Frameworks/Python.framework/Versions/3.6/lib/python3.6/site-packages/refgenie/refgenie.yaml`
*             `docker`:  `False`
*              `files`:  `[['fasta=human_alu.fa.gz']]`
*             `genome`:  `None`
*      `genome_config`:  `None`
* `genome_description`:  `None`
*             `logdev`:  `False`
*          `new_start`:  `False`
*          `outfolder`:  `/Users/mstolarczyk/Desktop/testing/refgenie/upgrade_test`
*             `params`:  `None`
*             `recipe`:  `None`
*            `recover`:  `False`
*       `requirements`:  `False`
*             `silent`:  `False`
*    `tag_description`:  `None`
*          `verbosity`:  `None`
*            `volumes`:  `None`

----------------------------------------

Target to produce: `/Users/mstolarczyk/Desktop/testing/refgenie/upgrade_test/human_alu/fasta/default/_refgenie_build/human_alu_fasta__default.flag`

> `cp human_alu.fa.gz /Users/mstolarczyk/Desktop/testing/refgenie/upgrade_test/human_alu/fasta/default/human_alu.fa.gz` (70063)
<pre>
psutil.ZombieProcess process still exists but it's a zombie (pid=70063)
Warning: couldn't add memory use for process: 70063
</pre>
Command completed. Elapsed time: 0:00:00. Running peak memory: 0.001GB.
  PID: 70063;   Command: cp;    Return code: 0; Memory used: 0.001GB

> `gzip -df /Users/mstolarczyk/Desktop/testing/r