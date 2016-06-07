# Android Changelogs Generator
Just a small and simple bash script to generate changelogs between two git tags for an Android project. Note, the output of the script is markdown that you can neatly copy and paste into your GitHub release, or CHANGELOGS.md.

## Usage
```bash
$ sh gen-changelogs.sh -help

Android Changelogs Generator v1.0.0

A script to generate changelogs or release notes between two git tags. You can
save or copy and paste it into a new GitHub release, and/or CHANGELOGS.md.

usage: gen-changelogs.sh [-h] [-d -a] <tag1> <tag2>

where:
    -h  show this help text
    -d  git directory of project (default: .)
    -a  path to apk file (default: ./mobile/build/outputs/apk/mobile-release.apk)
```

To generate the changelogs between two tags on your project, adapt the following command.

```bash
$ sh gen-changelogs.sh -d ../my-app v1.0.0 v1.1.0
```

And to store the output in your pasteboard, adapt the following.

```bash
$ sh gen-changelogs.sh -d ../my-app v1.0.0 v1.1.0 | pbcopy
```

## Output
The following markdown output is an example of what this script generates.

```bash
$ sh gen-changelogs.sh -d ../my-app v1.0.0 v1.1.0
```

**Released**: June 07, 2016

**Checksum**

```
$ shasum -a256 mobile-release.apk
b3bdaface013cd52aacd7024017d4de511755f14fdba487f5bf66379dedcd94d mobile-release.apk
```

**Changes** [[diff](https://github.com/JVillella/my-app/compare/v1.0.0...v1.1.0)]

- [#720] _Release v1.1.0_
- [#722] _Implement flux capacitor_
- [#719] _Extend Intergalactic Computer Network for great fun_
- [#716] _Replace RecyclerView with LandfillView_
- [#718] _Rename Toolbar to Poolbar_
- [#708] _Plug memory leak with another memory leak_

## License
Android Changelogs Generator is released under the MIT license. See LICENSE for details.
