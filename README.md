# [soypac](https://github.com/soyart/soypac)

An Arch Linux pacman user repository, available on [soyart.github.io/soypac](https://soyart.github.io/soypac).

## Using this pacman repository

### Importing GPG key to pacman

soypac only provides [signed pacman packages](https://wiki.archlinux.org/title/Pacman/Package_signing).

The signing key is sent to `keyserver.ubuntu.com`,
which can be downloaded, imported, and locally signed on user's machines.

Use `pacman-key` to import my GPG key from keyserver,
check its fingerprint, and locally sign the key:

```sh
pacman-key --recv-keys 2F7FDEEEB7E1D64119EC8AC0E7457D4B1A23879E
```

If the above command failed due to kerserver errors,
try specifying more verbose URLs:

```sh
pacman-key --keyserver hkp://keyserver.ubuntu.com --recv-keys 2F7FDEEEB7E1D64119EC8AC0E7457D4B1A23879E
pacman-key --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 2F7FDEEEB7E1D64119EC8AC0E7457D4B1A23879E
```

After key is imported, check its fingerprint and locally sign it:

```sh
pacman-key --finger 2F7FDEEEB7E1D64119EC8AC0E7457D4B1A23879E
pacman-key --lsign-key 2F7FDEEEB7E1D64119EC8AC0E7457D4B1A23879E
```

### Key maintenance

By default, soypac GPG key expires after 6 months. After expiration,
the key will be renewed manually and sent to keyserver.ubuntu.com.

If the GPG key expired and pacman complains, you may want to refresh the soypac key:

```sh
pacman-key --refresh-keys 2F7FDEEEB7E1D64119EC8AC0E7457D4B1A23879E
```

### Add this repo to [`pacman.conf(5)`](https://archlinux.org/pacman/pacman.conf.5.html)

Add the following snippet to `/etc/pacman.conf`:

```txt
[soypac]
server = https://soyart.github.io/soypac/x86_64
```

### Update and sync package database

```sh
pacman -Sy
```

And the next time you install a software via Pacman,
if soypac had higher priority then the package would be downloaded from soypac.

## End game

### Automation

soypac is currently being updated manually, i.e. up to me.

I want to create a GitHub Action hooks that tracks 3rd party
repositories e.g. [a pacman repo `archzfs`](https://github.com/archzfs/archzfs),
or [a regular AUR repo` linux-amd-znver2`](https://aur.archlinux.org/packages/linux-amd-znver2)
via triggers.

After being triggered, the GitHub Action will use a containerized
Arch Linux instance to build these AUR packages, sign the built packages.
and finally publish the binaries along with pacman database to soypac repository.

This will ensure that all target packages are built more timely,
as well as better transparency for users.

## Note to self

### Adding a package to repo, and signing databases

When adding a new package, add it to a target directory (i.e. `./x86_64`),
and run `add-pkg.sh`. The script will add the new package
to the repository's database, and then sign the database, 
producing a new database signature.

Note that this is different than signing the packages.

### Signing packages

Packages can be signed when they are build (e.g. in `/etc/makepkg.conf`),
or they can be signed by `./sign.sh`. The script will loop through all
relevant files in the target directory, with each file being signed.
