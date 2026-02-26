# padel CWL Generation Report

## padel

### Tool Description
PaDEL-Descriptor is a free software for the calculation of molecular descriptors and fingerprints.

### Metadata
- **Docker Image**: quay.io/biocontainers/padel:2.21
- **Homepage**: https://github.com/Joao-M-Silva/padel_analytics
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/conda-forge/packages/padel/overview
- **Total Downloads**: 83.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/Joao-M-Silva/padel_analytics
- **Stars**: N/A
### Original Help Text
```text
Feb 26, 2026 2:42:12 PM org.jdesktop.application.Application$1 run
SEVERE: Application class padeldescriptor.PaDELDescriptorApp failed to launch
java.awt.HeadlessException: 
No X11 DISPLAY variable was set, but this program performed an operation which requires it.
	at java.desktop/sun.awt.HeadlessToolkit.getMenuShortcutKeyMask(HeadlessToolkit.java:135)
	at org.jdesktop.application.ResourceMap$KeyStrokeStringConverter.parseString(ResourceMap.java:1490)
	at org.jdesktop.application.ResourceMap.getObject(ResourceMap.java:573)
	at org.jdesktop.application.ResourceMap.getKeyStroke(ResourceMap.java:902)
	at org.jdesktop.application.ApplicationAction.initActionProperties(ApplicationAction.java:444)
	at org.jdesktop.application.ApplicationAction.<init>(ApplicationAction.java:252)
	at org.jdesktop.application.ApplicationActionMap.addAnnotationActions(ApplicationActionMap.java:147)
	at org.jdesktop.application.ApplicationActionMap.<init>(ApplicationActionMap.java:81)
	at org.jdesktop.application.ActionManager.createActionMapChain(ActionManager.java:64)
	at org.jdesktop.application.ActionManager.getActionMap(ActionManager.java:101)
	at org.jdesktop.application.ActionManager.getActionMap(ActionManager.java:174)
	at org.jdesktop.application.ApplicationContext.getActionMap(ApplicationContext.java:290)
	at padeldescriptor.PaDELDescriptorView.initComponents(Unknown Source)
	at padeldescriptor.PaDELDescriptorView.<init>(Unknown Source)
	at padeldescriptor.PaDELDescriptorApp.startup(Unknown Source)
	at org.jdesktop.application.Application$1.run(Application.java:171)
	at java.desktop/java.awt.event.InvocationEvent.dispatch(InvocationEvent.java:313)
	at java.desktop/java.awt.EventQueue.dispatchEventImpl(EventQueue.java:770)
	at java.desktop/java.awt.EventQueue$4.run(EventQueue.java:721)
	at java.desktop/java.awt.EventQueue$4.run(EventQueue.java:715)
	at java.base/java.security.AccessController.doPrivileged(Native Method)
	at java.base/java.security.ProtectionDomain$JavaSecurityAccessImpl.doIntersectionPrivilege(ProtectionDomain.java:85)
	at java.desktop/java.awt.EventQueue.dispatchEvent(EventQueue.java:740)
	at java.desktop/java.awt.EventDispatchThread.pumpOneEventForFilters(EventDispatchThread.java:203)
	at java.desktop/java.awt.EventDispatchThread.pumpEventsForFilter(EventDispatchThread.java:124)
	at java.desktop/java.awt.EventDispatchThread.pumpEventsForHierarchy(EventDispatchThread.java:113)
	at java.desktop/java.awt.EventDispatchThread.pumpEvents(EventDispatchThread.java:109)
	at java.desktop/java.awt.EventDispatchThread.pumpEvents(EventDispatchThread.java:101)
	at java.desktop/java.awt.EventDispatchThread.run(EventDispatchThread.java:90)

Exception in thread "AWT-EventQueue-0" java.lang.Error: Application class padeldescriptor.PaDELDescriptorApp failed to launch
	at org.jdesktop.application.Application$1.run(Application.java:177)
	at java.desktop/java.awt.event.InvocationEvent.dispatch(InvocationEvent.java:313)
	at java.desktop/java.awt.EventQueue.dispatchEventImpl(EventQueue.java:770)
	at java.desktop/java.awt.EventQueue$4.run(EventQueue.java:721)
	at java.desktop/java.awt.EventQueue$4.run(EventQueue.java:715)
	at java.base/java.security.AccessController.doPrivileged(Native Method)
	at java.base/java.security.ProtectionDomain$JavaSecurityAccessImpl.doIntersectionPrivilege(ProtectionDomain.java:85)
	at java.desktop/java.awt.EventQueue.dispatchEvent(EventQueue.java:740)
	at java.desktop/java.awt.EventDispatchThread.pumpOneEventForFilters(EventDispatchThread.java:203)
	at java.desktop/java.awt.EventDispatchThread.pumpEventsForFilter(EventDispatchThread.java:124)
	at java.desktop/java.awt.EventDispatchThread.pumpEventsForHierarchy(EventDispatchThread.java:113)
	at java.desktop/java.awt.EventDispatchThread.pumpEvents(EventDispatchThread.java:109)
	at java.desktop/java.awt.EventDispatchThread.pumpEvents(EventDispatchThread.java:101)
	at java.desktop/java.awt.EventDispatchThread.run(EventDispatchThread.java:90)
Caused by: java.awt.HeadlessException: 
No X11 DISPLAY variable was set, but this program performed an operation which requires it.
	at java.desktop/sun.awt.HeadlessToolkit.getMenuShortcutKeyMask(HeadlessToolkit.java:135)
	at org.jdesktop.application.ResourceMap$KeyStrokeStringConverter.parseString(ResourceMap.java:1490)
	at org.jdesktop.application.ResourceMap.getObject(ResourceMap.java:573)
	at org.jdesktop.application.ResourceMap.getKeyStroke(ResourceMap.java:902)
	at org.jdesktop.application.ApplicationAction.initActionProperties(ApplicationAction.java:444)
	at org.jdesktop.application.ApplicationAction.<init>(ApplicationAction.java:252)
	at org.jdesktop.application.ApplicationActionMap.addAnnotationActions(ApplicationActionMap.java:147)
	at org.jdesktop.application.ApplicationActionMap.<init>(ApplicationActionMap.java:81)
	at org.jdesktop.application.ActionManager.createActionMapChain(ActionManager.java:64)
	at org.jdesktop.application.ActionManager.getActionMap(ActionManager.java:101)
	at org.jdesktop.application.ActionManager.getActionMap(ActionManager.java:174)
	at org.jdesktop.application.ApplicationContext.getActionMap(ApplicationContext.java:290)
	at padeldescriptor.PaDELDescriptorView.initComponents(Unknown Source)
	at padeldescriptor.PaDELDescriptorView.<init>(Unknown Source)
	at padeldescriptor.PaDELDescriptorApp.startup(Unknown Source)
	at org.jdesktop.application.Application$1.run(Application.java:171)
	... 13 more
```

