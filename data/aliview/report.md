# aliview CWL Generation Report

## aliview

### Tool Description
AliView is a graphical alignment viewer and editor. It is primarily a GUI-based application, but it can accept a file path as a positional argument to open an alignment on startup.

### Metadata
- **Docker Image**: quay.io/biocontainers/aliview:1.30--hdfd78af_0
- **Homepage**: https://ormbunkar.se/aliview/
- **Package**: https://anaconda.org/channels/bioconda/packages/aliview/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/aliview/overview
- **Total Downloads**: 1.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/AliView/AliView
- **Stars**: N/A
### Original Help Text
```text
16:11:44.452 [main] INFO  aliview.AliView - version time Sun Mar 09 00:52:16 GMT 2025
Time to here in ms = 27
16:11:44.456 [main] DEBUG aliview.AliView - java.specification.version=23
16:11:44.457 [main] DEBUG aliview.AliView - sun.management.compiler=HotSpot 64-Bit Tiered Compilers
16:11:44.457 [main] DEBUG aliview.AliView - sun.jnu.encoding=UTF-8
16:11:44.457 [main] DEBUG aliview.AliView - java.runtime.version=23.0.2-internal-adhoc.conda.src
16:11:44.457 [main] DEBUG aliview.AliView - java.class.path=/usr/local/share/aliview/aliview.jar
16:11:44.457 [main] DEBUG aliview.AliView - user.name=root
16:11:44.457 [main] DEBUG aliview.AliView - stdout.encoding=UTF-8
16:11:44.457 [main] DEBUG aliview.AliView - java.vm.vendor=Oracle Corporation
16:11:44.457 [main] DEBUG aliview.AliView - path.separator=:
16:11:44.457 [main] DEBUG aliview.AliView - sun.arch.data.model=64
16:11:44.457 [main] DEBUG aliview.AliView - os.version=6.8.0-100-generic
16:11:44.457 [main] DEBUG aliview.AliView - java.runtime.name=OpenJDK Runtime Environment
16:11:44.457 [main] DEBUG aliview.AliView - file.encoding=UTF-8
16:11:44.458 [main] DEBUG aliview.AliView - java.vendor.url=https://openjdk.org/
16:11:44.458 [main] DEBUG aliview.AliView - user.timezone=GMT
16:11:44.458 [main] DEBUG aliview.AliView - java.vm.name=OpenJDK 64-Bit Server VM
16:11:44.458 [main] DEBUG aliview.AliView - java.vm.specification.version=23
16:11:44.458 [main] DEBUG aliview.AliView - os.name=Linux
16:11:44.458 [main] DEBUG aliview.AliView - sun.java.launcher=SUN_STANDARD
16:11:44.458 [main] DEBUG aliview.AliView - sun.boot.library.path=/usr/local/lib/jvm/lib
16:11:44.458 [main] DEBUG aliview.AliView - sun.java.command=/usr/local/share/aliview/aliview.jar --help
16:11:44.458 [main] DEBUG aliview.AliView - java.vendor.url.bug=https://bugreport.java.com/bugreport/
16:11:44.459 [main] DEBUG aliview.AliView - java.io.tmpdir=/tmp
16:11:44.459 [main] DEBUG aliview.AliView - jdk.debug=release
16:11:44.459 [main] DEBUG aliview.AliView - sun.cpu.endian=little
16:11:44.459 [main] DEBUG aliview.AliView - java.version=23.0.2-internal
16:11:44.459 [main] DEBUG aliview.AliView - user.home=/root
16:11:44.459 [main] DEBUG aliview.AliView - user.dir=/
16:11:44.459 [main] DEBUG aliview.AliView - os.arch=amd64
16:11:44.459 [main] DEBUG aliview.AliView - user.language=en
16:11:44.459 [main] DEBUG aliview.AliView - java.specification.vendor=Oracle Corporation
16:11:44.459 [main] DEBUG aliview.AliView - java.vm.specification.name=Java Virtual Machine Specification
16:11:44.459 [main] DEBUG aliview.AliView - java.version.date=2025-01-21
16:11:44.460 [main] DEBUG aliview.AliView - java.home=/usr/local/lib/jvm
16:11:44.460 [main] DEBUG aliview.AliView - file.separator=/
16:11:44.460 [main] DEBUG aliview.AliView - java.vm.compressedOopsMode=Zero based
16:11:44.460 [main] DEBUG aliview.AliView - native.encoding=UTF-8
16:11:44.460 [main] DEBUG aliview.AliView - line.separator=

16:11:44.460 [main] DEBUG aliview.AliView - java.library.path=/usr/java/packages/lib:/usr/lib64:/lib64:/lib:/usr/lib
16:11:44.460 [main] DEBUG aliview.AliView - java.vm.info=mixed mode, sharing
16:11:44.460 [main] DEBUG aliview.AliView - java.vm.specification.vendor=Oracle Corporation
16:11:44.460 [main] DEBUG aliview.AliView - stderr.encoding=UTF-8
16:11:44.460 [main] DEBUG aliview.AliView - java.specification.name=Java Platform API Specification
16:11:44.460 [main] DEBUG aliview.AliView - java.vendor=N/A
16:11:44.460 [main] DEBUG aliview.AliView - java.vm.version=23.0.2-internal-adhoc.conda.src
16:11:44.460 [main] DEBUG aliview.AliView - sun.io.unicode.encoding=UnicodeLittle
16:11:44.461 [main] DEBUG aliview.AliView - java.class.version=67.0
16:11:44.461 [main] INFO  aliview.AliView - debugEnvnull
16:11:44.463 [main] INFO  aliview.AliView -  /usr/local/share/aliview/aliview.jar --help
16:11:44.463 [main] INFO  aliview.AliView - java.vendorN/A
16:11:44.463 [main] INFO  aliview.AliView - java.version23.0.2-internal
16:11:44.463 [main] INFO  aliview.AliView - args.length=1
16:11:44.463 [main] INFO  aliview.AliView - arg=--help
16:11:44.851 [main] ERROR aliview.AliView - java.awt.HeadlessException: 
No X11 DISPLAY variable was set,
or no headful library support was found,
but this program performed an operation which requires it,

java.awt.HeadlessException: 
No X11 DISPLAY variable was set,
or no headful library support was found,
but this program performed an operation which requires it,

	at java.awt.GraphicsEnvironment.checkHeadless(GraphicsEnvironment.java:164) ~[?:?]
	at java.awt.Window.<init>(Window.java:553) ~[?:?]
	at java.awt.Frame.<init>(Frame.java:428) ~[?:?]
	at java.awt.Frame.<init>(Frame.java:393) ~[?:?]
	at javax.swing.JFrame.<init>(JFrame.java:180) ~[?:?]
	at aliview.AliViewWindow.<init>(AliViewWindow.java:258) ~[aliview.jar:?]
	at aliview.AliView.createNewAliViewWindow(AliView.java:539) [aliview.jar:?]
	at aliview.AliView.main(AliView.java:388) [aliview.jar:?]
```

