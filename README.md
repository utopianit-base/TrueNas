# TrueNas

PowerShell module to manage FreeNAS and TrueNAS Systems.

The code is interacting with these systems by leveraging the `TrueNas` **API v2.0**

Based on version from https://github.com/PowerTrueNas/TrueNas with various corrections to module names, field names and full handling of multiple iscsi portals and initiators when creating an iscsi target.

As of 2020/10, the module is currently NOT available on the `PowerShell Gallery`.

Module tested on the following platforms:
* Windows 10 - Windows PowerShell 5.1
* Windows 10 - PowerShell Core 6.2.3
* Windows 10 - Powershell Core 7.x

##  Usage
1. Fork the repository
2. Import the Module.
```powershell
Import-module TrueNas.psd1
```

## Documentation

* Contribute (Thank you for your contributions!!)
  * See our [ToDo](docs/todo.md) list
  * [Test environment](docs/testenvironment.md)
* [Known issues](docs/knownissues.md)
* How-Tos
  * [Youtube Video - FreeNas Module / VMware PowerCLi](https://youtu.be/JpkEP9nkiN4)

## Resources

Utopian IT Version
* [github.com/utopianit-base/TrueNas](https://github.com/utopianit-base/TrueNas/)

Original Source
* [github.com/JM2K69/FreeNas](https://github.com/JM2K69/FreeNas)
* [JM2K69.github.io](https://JM2K69.github.io)
