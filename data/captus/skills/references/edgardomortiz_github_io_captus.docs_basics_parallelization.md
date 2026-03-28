1. [Captus](/captus.docs/) >
2. [Basics](/captus.docs/basics/) >
3. Parallelization

* + [**`--ram`**](#--ram)
  + [**`--threads`**](#--threads)
  + [**`--concurrent`**](#--concurrent)
  + [**`--debug`**](#--debug)
  + [**`--show_less`**](#--show_less)

# Parallelization

# (and other common options)

---

Throughout Captus’ modules we provide common options that allow you limit the computer’s resources available to `Captus`, change the way of running parallel tasks, and control the amount of text shown during a run:

### **`--ram`**

With this option you can specify the maximum RAM in GB that `Captus` is allowed to use. For example, if your system has 64 GB of RAM and you want to limit the use to 32.5 GB you would set the argument `--ram 32.5`.

This argument is optional, the default is **auto** (= 99% of available RAM).

---

### **`--threads`**

Similarly, you can specify the maximum number of CPU cores that `Captus` is allowed to use. If your system has 16 CPU cores but you need some cores for other analyses you could reduce it to, for example, 8 cores with `--threads 8`.

This argument is optional, the default is **auto** (= all CPU cores).

---

### **`--concurrent`**

This option sets the maximum number of tasks to run in parallel at any moment. For example, let’s imagine you set `--threads 16` and `--concurrent 2`, this means that `Captus` will run only 2 tasks in parallel but each of those tasks can use up to 8 CPU cores.

This argument is optional, the default is **auto** (the automatic adjustment varies between analysis steps).

---

### **`--debug`**

This flag enables the debugging mode, this ***disables parallelization*** so errors can be logged to screen. If you are seeing some samples failing steps or some other unexpected behavior you can enable `--debug` and submit the error shown to the `Issues` (<https://github.com/edgardomortiz/Captus/issues>) section in our GitHub repository.

---

### **`--show_less`**

This flag produces less verbose screen printout. Essentially, information about each sample will not be shown (but still logged) during the run.

---

Created by [Edgardo M. Ortiz](https://edgardomortiz.github.io/captus.docs/more/credits/#edgardo-m-ortiz) (06.08.2021)
Last modified by [Edgardo M. Ortiz](https://edgardomortiz.github.io/captus.docs/more/credits/#edgardo-m-ortiz) (11.11.2022)

[![](/captus.docs/images/logo.svg)](/)

Search

* [Home](/captus.docs/)

* [x] Submenu Basics[Basics](/captus.docs/basics/)
  + [Overview](/captus.docs/basics/overview/)
  + [Installation](/captus.docs/basics/installation/)
  + [Parallelization](/captus.docs/basics/parallelization/)
* [ ] Submenu Assembly[Assembly](/captus.docs/assembly/)
  + [x] Submenu Clean[**1.** Clean](/captus.docs/assembly/clean/)
    - [Input Preparation](/captus.docs/assembly/clean/preparation/)
    - [Options](/captus.docs/assembly/clean/options/)
    - [Output Files](/captus.docs/assembly/clean/output/)
    - [HTML Report](/captus.docs/assembly/clean/report/)
  + [x] Submenu Assemble[**2.** Assemble](/captus.docs/assembly/assemble/)
    - [Input Preparation](/captus.docs/assembly/assemble/preparation/)
    - [Options](/captus.docs/assembly/assemble/options/)
    - [Output Files](/captus.docs/assembly/assemble/output/)
    - [HTML Report](/captus.docs/assembly/assemble/report/)
  + [x] Submenu Extract[**3.** Extract](/captus.docs/assembly/extract/)
    - [Input Preparation](/captus.docs/assembly/extract/preparation/)
    - [Options](/captus.docs/assembly/extract/options/)
    - [Output Files](/captus.docs/assembly/extract/output/)
    - [HTML Report](/captus.docs/assembly/extract/report/)
  + [x] Submenu Align[**4.** Align](/captus.docs/assembly/align/)
    - [Options](/captus.docs/assembly/align/options/)
    - [Output Files](/captus.docs/assembly/align/output/)
    - [HTML Report](/captus.docs/assembly/align/report/)
* [Design](/captus.docs/design/)
* [ ] Submenu Tutorials[Tutorials](/captus.docs/tutorials/)
  + [Basic](/captus.docs/tutorials/basic/)
  + [Advanced](/captus.docs/tutorials/advanced/)

More

* [GitHub repo](https://github.com/edgardomortiz/Captus)
* [Credits](/captus.docs/more/credits)

---

* Language
* Theme

  Green
* Clear History

[Download](https://github.com/edgardomortiz/Captus/archive/master.zip)
[Star](https://github.com/edgardomortiz/Captus)
[Fork](https://github.com/edgardomortiz/Captus/fork)

Built with  by [Hugo](https://gohugo.io/)