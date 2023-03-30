# Tag game

Play tag on Raspberry Pis!

## Rules

- The game is played by two players sitting opposite each other
- Each player is equipped with an airgapped VM/Raspberry Pi running an OS
- The players start hands-on at their computers the same time by an adjudicator
- They each get 7 minutes to install as many backdoors as possible on the other player's computer
- The players then switch computers and try to find the backdoors installed by the other player and remove them in again 7 minutes
- Points are scored for each backdoor that was installed which still remained
  - What counts as a backdoor is at the discretion of the adjudicator
  - In general backdoors can be privaledge escalation, remote access, other persistence, etc.
  - The players should not render the their own computer unusable before switching (don't lock root user, completely destroy config files, etc.)
