Converts some github (and other) repos straight to dummy .deb.
Doesn't care about Debian policies much, just gets the job done.

To use, create an empty Debian Stretch container (e.g. LXC).
Add a user and give him sudo privileges (he'll need `dpkg -i` and `apt-get`
mostly)

```
adduser --disabled-password user
apt-get install --yes vim sudo git
visudo:
  append this:
    user ALL=NOPASSWD: ALL

su user
cd
git clone https://github.com/goblin/debianize-github
cd debianize-github
```

To build all supported Debian packages, run

```
./make_all_debs.sh
```

They'll end up in the DEBS/ subdirectory.

To build just one package/repo, you can use e.g.:

```
./build goblin/treasure-goblin
```

Things will generally work only the first time, after which you'll
have to manually clean up all the mess in DEBS. Also, after building,
the packages will be automatically installed via sudo, so remember
to clean that too if you need.
