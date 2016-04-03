# iibtoolkit
IBM Integration Bus v9 Toolkit with Healthcare Pack installed in a docker container.

The version of eclipse with all of the IIB plugins in 3.6.2.  This is pretty old by today's standards.  IIB won't even run successfully on CentOS 7.  So this is my attempt at creating a container that holds this tooling.

1.  CentOS 6 Base
2.  IIB Toolkit
3.  Updated to v9.0.0.4
4.  Healthcare Connectivity Pack v3.0.0.1
5.  XulRunner 1.9.2.19

# TODO:
Update the JDK of the toolkit to the latest GA version of IBM Java.

---
This does not fully work yet.  There are still some kinks.
Basically whenever a message flow or DFDL is editted, the editor freezes.
I'm not sure why...   I'll detail the issues from the workspace logs later.
