# DefiNode Upgrader

The ```upgrade.sh``` script will upgrade your definode if

- It is placed in the standard folder ```$HOME/.defi```
- You used cron to manage your defid
- You run Linux X86_64

:warning: :warning: :warning: This script does not check the above requirements - you have to!

Steps it will take

1. Disable CRON
2. Kill defid
3. Download update
4. If snapshot delete old chain and restore from snapshot
5. Restore CRON

## Usage

```
./upgrade.sh version snapshot

version - Version without the v. such as 2.6.2 or latest for the latest version
snapshot - true or false. When true it will delete your current chain and restore from snapshot. Wallet will not be touched.
```

## Example

Upgrade to latest version without snapshot (2.11.1 in this example)

```
./upgrade.sh latest
Disable CRON: [DONE]
Stop dfid: [DONE]
Updating defi node v.2.11.1: [DONE]
Enable CRON: [DONE]
.:[ DONE ]:.
```

Upgrade to 2.7.0-alpha with snapshot

```
./upgrade.sh 2.7.0-alpha true
Disable CRON: [DONE]
Stop dfid: [DONE]
Updating defi node v.2.7.0-alpha: [DONE]
Setup from snapshot: [DONE]
Enable CRON: [DONE]
.:[ DONE ]:.
```

Upgrade to 2.7.0-alpha without snapshot

```
./upgrade.sh 2.7.0-alpha
Disable CRON: [DONE]
Stop dfid: [DONE]
Updating defi node v.2.7.0-alpha: [DONE]
Enable CRON: [DONE]
.:[ DONE ]:.
```
