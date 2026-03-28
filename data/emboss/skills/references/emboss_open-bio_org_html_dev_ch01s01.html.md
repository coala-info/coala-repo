| 1.1. Licence Information | | |
| --- | --- | --- |
| [Prev](ch01.html) | Chapter 1. Getting Started | [Next](ch01s02.html) |

---

## 1.1. Licence Information

EMBOSS is licensed for use by everyone under the GNU Software licences. The AJAX and NUCLEUS libraries are released under the GNU Lesser General Public Licence (LGPL). The applications are released under the GNU General Public Licence (GPL). If you plan to develop proprietary software using the libraries you should read the full licensing conditions:

|  |
| --- |
| GPL (*<http://www.gnu.org/copyleft/gpl.html>*) |
| LGPL (*<http://www.gnu.org/copyleft/lgpl.html>*) |

The licences were chosen to provides maximum flexibility and encourage development. They give you freedom in software development, so long as you preserve those freedoms for others.

### 1.1.1. GPL

The GPL allows you to freely modify, copy, and distribute the application source code so long as the source code of the derived work is licensed under GPL and made available. This means you can freely extend and improve the EMBOSS applications.

It is important to distinguish a "derived work" from entirely new code. Typically, a derived work is either a direct modification of the original source code or is linked (statically or dynamically) to the original. For instance, software using a GPL licensed shared library would be a "derived work", which is why the LGPL is used for the EMBOSS libraries to avoid this restriction. Parsing of ACD files does *not* constitute a "derived work" and would not in itself be subject to the licence. Many developers have done this, for example, when writing an interface to EMBOSS.

### Important

The rules of the GPL licence only take effect when you distribute the code. This means you can use and modify the code for your own internal use without obtaining permission or having to notify anyone.

### 1.1.2. LGPL

The LGPL requires that all changes to the libraries must be published openly (the source code must be made available). It is possible, however, to develop a completely new application that uses the libraries without the requirement of releasing the source. The libraries can be linked with proprietary software whereas had they been licensed under the GPL the libraries could only be used with free programs.

### 1.1.3. Licensing under EMBASSY

Developers who do not use the GPL or LGPL licence can still contribute. The EMBASSY collection can include packages that use AJAX or NUCLEUS but under their own licensing conditions. They will be bound by the LGPL of the AJAX and NUCLEUS libraries, but not necessarily by the full GPL.

---

|  |  |  |
| --- | --- | --- |
| [Prev](ch01.html) | [Up](ch01.html) | [Next](ch01s02.html) |
| Chapter 1. Getting Started | [Home](index.html) | 1.2. Installation of CVS (Developers) Release |