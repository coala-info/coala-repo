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

# MACSE installation and fundamental usage

## 1. Program installation and running

MACSE is really easy to install. Just download the jar file of the latest release of MACSE (e.g. macse*v2.0.jar) on your computer. Note that JAVA (JRE above 1.5) should be installed on your computer (*[download JAVA](https://www.java.com/fr/download/) *).*

To launch the graphical version of MACSE (GUI), double click on the jar file, or run the command line without any option:

```
java -jar macse.jar
```

If you want to run the command line version of MACSE you need to open a console.

* **Mac OS X:** Double-click on the *terminal* program that is in the Application/Utilities folder.
* **WINDOWS:** Get the windows invite by typing Windows + r. A small dialog windows should appear, then type *cmd* and click OK.
* **LINUX:** if you are using Linux OS you surely know how to get a console.

## 2. Using the graphical user interface (GUI) of MACSE

The main menu of the graphical interface lets you select one of the MACSE subprograms. Once the desired subprogram is selected, its options are displayed and can be set as you wish. As some subprograms have many options, they are sorted out in different groups/tabs:

* One tab contains only the mandatory options (indicated in red in other tabs)
* One tab contains all available options
* Other tabs contain a subset of options grouped by theme (output parameters, cost parameters, input files, etc…)

Once you have set options to the desired values, you can launch the task execution by clicking on the run button (bottom right).

Note that the command line corresponding to the options you have chosen is automatically created and displayed on the bottom left part of the window. You can hence use the GUI to easily generate the command line you need on a single example, copy this command (using copy/paste or the **copy to clipboard** button) and adapt this command to run it on multiple datasets using the command line facilities of MACSE.

Note also that every time you select a subprogram or click on an option field, a **brief help** is displayed on the top part of the window.

## 3. Using the command line version of MACSE

MACSE is a toolkit made of several (sub)programs. Options with the same name have identical roles in the different subprograms but each subprogram also have its own specific options. The first thing when using MACSE is to indicate the program you want to use thanks to the **-prog** option. If you have no idea, just put a random program name and MACSE will remind you the list of valid program names followed by a one line description:

```
java -jar macse.jar -prog wrongProgram
```

As the **wrongProgram** parameter is not a valid program, MACSE will display the list of valid program names (be careful MACSE is case sensitive).

Note that if you attempt to run MACSE without any option, it will not display any help but instead launch its graphical mode.

Note also that all documentation examples are provided using the convention that your jar file for MACSE is **macse.jar** whereas you probably have something like **macse\_v2.1.jar**.

Once you have chosen a program, you can list all its available options with the following command:

```
java -jar macse.jar -prog splitAlignment
```

This example will list all **splitAlignment** program options.

Note that the options are also displayed if incorrect options are used or if mandatory ones are missing.

If you have **numerous long sequences** MACSE can need more memory than provided by the default java parameter. You can specify that you want to allocate more memory to MACSE using the **Xmx** option of java. For instance

```
java -jar -Xmx600m macse.jar
```

will allocate 600 mega of memory to your java program.

© 2026 GE²pop • Construit avec [GeneratePress](https://generatepress.com)