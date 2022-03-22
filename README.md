# DefiNode Upgrader

The ```upgrade.sh``` script with upgrade your definode iff

- It is placed in the standard folder ```$HOME/.defi```
- You used cron to manage your defid
- You run Linux X86_64

## Usage

```
./upgrade.sh version snapshot

version - Version without the v. such as 2.6.2
snapshot - true or false. When true it will delete your current chain and restore from snapshot. Wallet will not be touched.
```

## Example

Upgrade to 2.7.0-alpha with snapshot

```
./upgrade.sh 2.7.0-alpha true
```
