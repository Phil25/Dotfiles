### Note

All files here are **not** how they appear in the system. Their paths are instead defined in the _manifest_ file.

Using the _manifest_ file, the script _update.sh_ manages their distribution.

### Distribution

Dotfile distribution is defined in _manifest_. Its format is `<file> <path>`, per line.

_path_ is the path of a **symlink** pointing to the _file_, which is relative to <repo>/files/ directory.

### update.sh

The update script iterates lines of _manifest_ and handles multiple situations regarding _file_ and _path_:

1. None exist
	* do nothing

1. Only _file_ exists
	* create symlink at _path_ pointing to _file_

1. Only _path_ exists
	* move _path_ to repo under name of _file_
	* create symlink at _path_ pointing to _file_

1. Both exist
	1. _path_ is a symlink
		* do nothing if _path_ is already a symlink to _file_
		* ask whether to replace _path_ with symlink to _file_
		* defaults to "No"
	1. _path_ is **not** a symlink then ask:
		1. override non-repo file - replace _path_ with a symlink to _file_
		1. override repo file - replace _file_ with _path_ and symlink
		1. skip - self-explanatory

Every deletion/replacement creates a file <deleted file>.backup at the location.
