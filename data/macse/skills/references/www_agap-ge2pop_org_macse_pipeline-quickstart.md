[Aller au contenu](#content "Aller au contenu")

[GE²pop](https://www.agap-ge2pop.org/)

Génomique évolutive et gestion des populations

[Home](https://www.agap-ge2pop.org/)

[Tools](https://www.agap-ge2pop.org/tools)

[Datasets](https://www.agap-ge2pop.org/datasets)

![](https://www.agap-ge2pop.org/wp-content/uploads/2023/06/logo_MACSE-1024x567.jpg)

[Tools](https://www.agap-ge2pop.org/tools/)

## **MACSE**

* [Overview](https://www.agap-ge2pop.org/macse/)
* Documentation
  + [Quickstart](https://www.agap-ge2pop.org/macse/macse-quickstart/)
  + [Documentation](https://www.agap-ge2pop.org/macse/macse-documentation/)
  + [Pipeline quickstart](https://www.agap-ge2pop.org/macse/pipeline-quickstart/)
  + [Pipeline documentation](https://www.agap-ge2pop.org/macse/pipeline-documentation/)
  + [Download tutorial files](https://www.agap-ge2pop.org/macse/download-tutorial-files/)
  + [Citing](https://www.agap-ge2pop.org/macse/citing/)
  + [Citations](https://scholar.google.com/scholar?hl=en&lr=&cites=https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0022594)
* Download
  + [MACSE & pipelines](https://www.agap-ge2pop.org/macsee-pipelines/)
  + [Barcoding alignments](https://www.agap-ge2pop.org/barcoding-alignments/)
  + [Tutorial files](https://www.agap-ge2pop.org/macse/download-tutorial-files/)
* [Members](https://www.agap-ge2pop.org/macse/members/)

# MACSE Pipeline quickstart

The MACSE v2 toolkit provides the building blocks to construct powerful alignment pipelines. However, the number of available subprograms and options featured in this version could be problematic for occasional users. We hence included a Graphical User Interface (GUI) in MACSE V2 and provide some of our own MACSE V2 pipelines. These pipelines are mostly bash scripts encapsulated within singularity containers and sometimes combined in nextflow workflows. This page provides basic information regarding [singularity](https://sylabs.io/), [nextflow](https://www.nextflow.io/) and how to run our pipelines using these tools.

## Singularity

### singularity: overview

A singularity container (Kurtzer, 2017) contains everything that is needed to execute a specific task. The person building the container has to handle dependencies and environment configuration so that the end-user do not need to bother. The file specifying the construction of the container is a simple text file called a recipe (we provide the recipe of our container as well as the containers). As our scripts/pipelines often relies on several other scripts and external tools (e.g. MAFFT) singularity container is very handy as the end user just need to install singularity and download the container without having to care for installing dependencies or setting environment variables.

### singularity: installation

Singularity is likely available on your HPC center. If not, you could ask your HPC aministrator to install it, the singularity team provide a [template message](https://sylabs.io/guides/3.4/user-guide/installation.html#installationrequest) for this request.
If you need to install it on your own computer the singularity team provides a step by step guide to [install singularity on linux](https://sylabs.io/guides/3.4/user-guide/installation.html#install-on-linux) and to [install it on WINDOWS or MAC.](https://sylabs.io/guides/3.4/user-guide/installation.html#install-on-windows-or-mac)

### singularity: basic usage

If singularity is installed on your cluster/computer you can launch a container that execute a complex task relying on several libraries or programs by simply downloading the corresponding container and asking singularity to execute it.

Here we provide singularity container compatible with singularity v3 (or above). Launching a container named *container.sif* on a computer where singularity is as simple as downloading it, adding the executable permission to it using

* *chmod +x container.sif*
* *./container.sif*
* *singularity run ./container.sif*
* *singularity run-help ./container.sif*

and then typing the command or, if you prefer To display the container help, use:

### singularity: getting containers

There are three way to get a container.

* You can simply download the container image .sif file as any other files (some are available in our [download section](https://www.agap-ge2pop.org/macsee-pipelines/)).
* Containers available on the singularity hub, can be download using the singularity pull command, e.g. *singularity pull –arch amd64 library://vranwez/default/omm\_macse:v10.02*
* You can rebuild the container (but this require the administrator rigths) using its recipe (small text file), e.g. *sudo singularity build OMM\_MACSE\_v10.01.sif OMM\_MACSE\_v10.01\_sing\_3.3.def*

### Singularity: running the OMM MACSE pipeline

When you need to handle numerous large dataset, the computation time required by the alignSequences subprogram of MACSE may become a problem.
We faced this problem during the V10 update of the OrthoMaM database and developped the OMM\_MACSE pipeline, that extensively rely on MACSE subprogramms, to be able to deal with such large datasets.
You can use the OMM\_MACSE pipeline developped to obtain [OrthoMaM](http://www.orthomam.univ-montp2.fr/orthomam/html/) alignments via the [MBB server](http://mbb.univ-montp2.fr/MBB/subsection/softExec.php?soft=OMM_MACSE) or using our singularity containers.
To run the OMM\_MACSE pipeline on the file [LOC\_48720\_NT.fasta](https://www.agap-ge2pop.org/wp-content/uploads/macse/doc/LOC_48720_NT.fasta) using our singularity container (with default options) you need to specify the input file, output directory and the prefix of the output files:

* *./OMM\_MACSE\_v10.01.sif –in\_seq\_file LOC\_48720.fasta –out\_dir RES\_LOC\_48720 –out\_file\_prefix LOC\_48720*

## Nextflow

Nextflow (Di Tommaso, 2017) enables scalable and reproducible scientific workflowsusing software containers allowing the adaptation of pipelines written in the most commonscripting languages. Nextflow separates the workflow itself from the directive regarding the correct way to execute it in the environment. One key advantage of Nextflow is that, by changing slightly the â€œnextflow.configâ€ file, the same workflow will be parallelized and launched to exploit the full resources of a high performance computing (HPC) cluster.

### Nextflow: installation

Nextflow is really easy to install and it can be installed as a regular user (no need to be root) using one of the following command:

* *curl -s https://get.nextflow.io | bash*
* or: *wget -qO- https://get.nextflow.io | bash*

### Nextflow: running the MACSE barcoding pipelines

To execute this pipeline, you need to get two of our singularity containers using:

* *singularity pull –arch amd64 library://vranwez/default/representative\_seqs:v01*
* *singularity pull –arch amd64 library://vranwez/default/omm\_macse:v10.02*

You also need to download the corresponding , and to adapt one of the nextflow configuration files that we provide. For instance, if you are working on a HPC using SGE as task manager, you can use [this configuration file](https://github.com/ranwez/MACSE_V2_PIPELINES/blob/master/MACSE_BARCODE/nextflow.config) and modify it to specific the name of the job queue to be used. Once you get everything, aligning hundred of thousands of barcoding sequences (here some mammals COI sequences) is as simple as:

* *./nextflow P\_macse\_barcode.nf –refSeq Homo\_sapiens\_NC\_012920\_COI\_ref.fasta –seqToAlign Mammalia\_BOLD\_121180seq\_COI.fasta –geneticCode 2 –outPrefix Mammalia\_COI*

## Possible problems

When running the singularity image you got a message indicating:

* *ERROR : Unknown image format/type: OMM\_MACSE\_V10.01.sif ABORT : Retval = 255*

You are probably trying to use a old singularity release to launch an image generated with a more recent release. Type *singularity –version* to know which release you are using, if your release is older than 3 (but above 2.5), please update it.

In rare case you may have an error message when running the container saying that:

* *ERROR : Base home directory does not exist within the container…*
* *singularity run -H /homedir/ranwez:/home/ranwez OMM\_MACSE\_V10.01.sif*

In this case please, can use the -H option as a tedious workaround; if your cluster home direcory is /homedir/your\_loggin instead of the more usual /home/your\_login expected by the singularity container you can specify this when lauching singularity. In my case, this leads to: and even so, I can only run the container from my home directory afterward. It is thus much better if your administrator can update the singularity configuration file on your cluster so that everything work smoothly. A better solution is to ask your HPC cluster administrator to fix singularity binding configuration or to help you regenerating the singularity image. To do so download the recipe file we provide and add instruction to create the missing directory in the %POST section. For instance on one cluster I got the following error message:

```
    #WARNING: Non existent bind point (directory) in container: /work
    #WARNING: Non existent bind point (directory) in container: /homedir
    #WARNING: Non existent bind point (directory) in container: /usr1/compte_mess
    #WARNING: Non existent bind point (directory) in container: /projects
    #ERROR  : Base home directory does not exist within the container: /homedir
    #ABORT  : Retval = 255

```

To fix the problem I add the following commands in the %post section of the OMM\_MACSE 2.5 recipe file

```
    mkdir /work
    mkdir /homedir
    mkdir /projects
    mkdir -p /usr1/compte_mess

```

and regenerate the singularity container (you need the administrative priviledges to do so)

* *sudo singularity build OMM\_MACSE\_v10.01.sif OMM\_MACSE\_v10.01\_sing\_2.5.def*

## Further readings

* [github repositories for MACSE\_V2 pipelines](https://github.com/ranwez/MACSE_V2_PIPELINES)
* [singularity documentation](https://sylabs.io/docs/)
* [Nextflow documentation](https://www.nextflow.io/docs/latest/config.html)

© 2026 GE²pop • Construit avec [GeneratePress](https://generatepress.com)